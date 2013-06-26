//
//  CGSelectRestaurantCategoryViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 4/5/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//
#import "CGRestaurantListCategory.h"
#import "CGSelectRestaurantCategoryViewController.h"
#import "CGRestaurantListCategory.h"
#import "CGAppDelegate.h"
#import <RestKit/RestKit.h>
#import "CGRestaurantParameter.h"
#import "CGLoginViewController.h"

@interface CGSelectRestaurantCategoryViewController ()

@end

@implementation CGSelectRestaurantCategoryViewController

@synthesize delegate = _delegate;

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
    return self.restaurantCategories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CategoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CGRestaurantListCategory *category = [self.restaurantCategories objectAtIndex:indexPath.row];
    if (category){
        cell.textLabel.text = category.name;
        cell.textLabel.textColor = [UIColor colorWithRed:98.0f/255.0f green:98.0f/255.0f blue:98.0f/255.0f alpha:1.0f];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGRestaurantListCategory *category = [self.restaurantCategories objectAtIndex:indexPath.row];
    self.selectedCategory = category;
    
    if ([category.restaurantListCategoryId intValue] == 5){
        if ([CGRestaurantParameter shared].loggedInUser){
            [self loginSuccessful];            
        }else{
            CGAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
            if (appDelegate.session.isOpen){
                [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection,
                                                                       id<FBGraphUser> user,
                                                                       NSError *error) {
                    if (!error) {
                        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
                        [params setObject:user.id forKey:@"fbUid"];
                        
                        [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/facebook/login"
                                                               parameters:params
                                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                                      if (mappingResult){
                                                                          [CGRestaurantParameter shared].loggedInUser = [[mappingResult array] objectAtIndex:0];
                                                                          [self loginSuccessful];
                                                                      }
                                                                  }
                                                                  failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                                      message:@"There was an issue"
                                                                                                                     delegate:nil
                                                                                                            cancelButtonTitle:@"OK"
                                                                                                            otherButtonTitles:nil];
                                                                      [alert show];
                                                                  }];
                    }
                }];
            }else{
                [self performSegueWithIdentifier:@"restaurantCategoryLoginSegue" sender:self];
            }
        }
    }else{
        [self.delegate updateRestaurantCategory:category];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"restaurantCategoryLoginSegue"]){
        UINavigationController *navController = [segue destinationViewController];
        
        if (navController != nil){
            CGLoginViewController *loginController = (CGLoginViewController *)navController.topViewController;
            loginController.delegate = self;
        }
    }
}

-(void) loginSuccessful {
    [self.delegate updateRestaurantCategory:self.selectedCategory];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)cancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
