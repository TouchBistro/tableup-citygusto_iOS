//
//  CGCuisineViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 3/27/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurantParameter.h"
#import "CGCuisineViewController.h"
#import "CGCuisine.h"
#import "CGFeature.h"
#import "MBProgressHUD.h"
#import <RestKit/RestKit.h>

@interface CGCuisineViewController ()

@end

@implementation CGCuisineViewController

@synthesize cuisines;

- (void)viewDidLoad
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        UIImage *navBarImg = [UIImage imageNamed:@"appHeader.png"];
        [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
        
    }
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [CGRestaurantParameter shared].cuisinesForSelectedLocation.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CuisineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CGCuisine *cuisine = [[CGRestaurantParameter shared].cuisinesForSelectedLocation objectAtIndex:indexPath.row];
    
    if (cuisine){
        cell.textLabel.text = [[[CGRestaurantParameter shared].cuisinesForSelectedLocation objectAtIndex:indexPath.row] name];
        cell.textLabel.textColor = [UIColor colorWithRed:98.0f/255.0f green:98.0f/255.0f blue:98.0f/255.0f alpha:1.0f];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
    	cell.textLabel.shadowColor = [UIColor whiteColor];
		cell.textLabel.shadowOffset = CGSizeMake(1, 1);
        
        if ([CGRestaurantParameter shared].cuisines.count > 0){
            NSUInteger index = [[CGRestaurantParameter shared].cuisines  indexOfObject:cuisine];
            if (index != NSNotFound) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
    }
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //add to selected cuisines
    CGCuisine *selectedCuisine = [[CGRestaurantParameter shared].cuisinesForSelectedLocation objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryNone){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [[CGRestaurantParameter shared].cuisines addObject:selectedCuisine];
    } else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        [[CGRestaurantParameter shared].cuisines removeObject:selectedCuisine];
    }
    
}

- (IBAction)done:(id)sender {
//    [[CGRestaurantParameter shared] fetchFeatures];
    [self startSpinner];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/features"
                                           parameters:[[CGRestaurantParameter shared] buildParameterMap]
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if (mappingResult){
                                                      [[CGRestaurantParameter shared].featuresForSelectedLocationAndCuisines removeAllObjects];
                                                      [[CGRestaurantParameter shared].featuresForSelectedLocationAndCuisines addObjectsFromArray:[[mappingResult dictionary] objectForKey:@"features"]];
                                                  }
                                                  [self dismissViewControllerAnimated:YES completion:nil];
                                                  [self stopSpinner];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                  message:@"There was an issue"
                                                                                                 delegate:nil
                                                                                        cancelButtonTitle:@"OK"
                                                                                        otherButtonTitles:nil];
                                                  [alert show];
                                                  NSLog(@"Hit error: %@", error);
                                                  
                                                  [self stopSpinner];
                                                  [self dismissViewControllerAnimated:YES completion:nil];
                                              }];
    
}

- (void) startSpinner {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    hud.userInteractionEnabled = YES;
}

- (void) stopSpinner {
    [MBProgressHUD hideHUDForView:self.tableView animated:YES];
}
@end
