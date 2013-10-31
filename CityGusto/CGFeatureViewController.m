//
//  CGFeatureViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 3/27/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGFeatureViewController.h"
#import "CGRestaurantParameter.h"
#import "CGFeature.h"

@interface CGFeatureViewController ()

@end

@implementation CGFeatureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navItem.title = [CGRestaurantParameter shared].getLocationName;
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
    return [CGRestaurantParameter shared].featuresForSelectedLocationAndCuisines.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FeatureCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CGFeature *feature = [[CGRestaurantParameter shared].featuresForSelectedLocationAndCuisines objectAtIndex:indexPath.row];
    
    if (feature){
        cell.textLabel.text = [[[CGRestaurantParameter shared].featuresForSelectedLocationAndCuisines objectAtIndex:indexPath.row] name];
        cell.textLabel.textColor = [UIColor colorWithRed:98.0f/255.0f green:98.0f/255.0f blue:98.0f/255.0f alpha:1.0f];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
    	cell.textLabel.shadowColor = [UIColor whiteColor];
		cell.textLabel.shadowOffset = CGSizeMake(1, 1);
        
        if ([CGRestaurantParameter shared].features.count > 0){
            NSUInteger index = [[CGRestaurantParameter shared].features indexOfObject:feature];
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
    CGFeature *selectedFeature = [[CGRestaurantParameter shared].featuresForSelectedLocationAndCuisines objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryNone){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [[CGRestaurantParameter shared].features addObject:selectedFeature];
    } else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        [[CGRestaurantParameter shared].features removeObject:selectedFeature];
    }
    
}

- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
