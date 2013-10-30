//
//  CGMyRestaurantFavoriteListViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 4/19/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurantFavoriteList.h"
#import "CGNewRestaurantsListViewController.h"
#import "CGMyRestaurantFavoriteListViewController.h"
#import "CGRestaurantListFavoriteViewController.h"
#import "MBProgressHud.h"
#import <RestKit/RestKit.h>

@interface CGMyRestaurantFavoriteListViewController ()

@end

@implementation CGMyRestaurantFavoriteListViewController

@synthesize restaurantFavoriteLists;

- (void)viewDidLoad
{
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.tableView addSubview: self.activityView];
    
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
    return self.restaurantFavoriteLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RestaurantFavListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CGRestaurantFavoriteList *favList = [self.restaurantFavoriteLists objectAtIndex:indexPath.row];
    cell.textLabel.text = favList.name;
    cell.textLabel.textColor = [UIColor colorWithRed:98.0f/255.0f green:98.0f/255.0f blue:98.0f/255.0f alpha:1.0f];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRestaurantFavoriteList *favList = [self.restaurantFavoriteLists objectAtIndex:indexPath.row];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:favList.restaurantFavoriteListId forKey:@"id"];
     
    [self startSpinner];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurantFavoriteLists"
                                           parameters:params
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if (mappingResult){
                                                      self.restaurants = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                      [self performSegueWithIdentifier:@"restaurantFavoriteListRestaurantSegue" sender:self];
                                                  }
                                                  [self stopSpinner];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                  message:@"There was an issue"
                                                                                                 delegate:nil
                                                                                        cancelButtonTitle:@"OK"
                                                                                        otherButtonTitles:nil];
                                                  [alert show];
                                                  
                                                  [self stopSpinner];
                                              }];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"restaurantFavoriteListRestaurantSegue"]){
        CGRestaurantListFavoriteViewController *favoriteViewController = [segue destinationViewController];
        favoriteViewController.restaurants = self.restaurants;
    }
}

- (void) startSpinner {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    hud.userInteractionEnabled = YES;
}

- (void) stopSpinner {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
