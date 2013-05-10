//
//  CGRestaurantTopListViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 3/28/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGTopListPosition.h"
#import "CGRestaurantList.h"
#import "CGRestaurantParameter.h"
#import "CGRestaurantTopListViewController.h"
#import "CGRestaurantListListViewController.h"
#import <RestKit/RestKit.h>

@interface CGRestaurantTopListViewController ()

@end

@implementation CGRestaurantTopListViewController

- (void)viewDidLoad
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        UIImage *navBarImg = [UIImage imageNamed:@"appHeader.png"];
        [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
        
    }
    
    if (self.selectedRestaurant.restaurantListPositions.count == 0){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *noMenuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, 320, 60)];
        noMenuLabel.text = @"There are no lists for this restaurant.";
        noMenuLabel.textColor = [UIColor colorWithRed:98.0f/255.0f green:137.0f/255.0f blue:173.0f/255.0f alpha:1.0f];
        noMenuLabel.textAlignment = NSTextAlignmentCenter;
        
        [view addSubview:noMenuLabel];
        [self.view addSubview:view];
        [self.view bringSubviewToFront:view];
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
    return self.selectedRestaurant.restaurantListPositions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CGTopListPosition *toplist = [self.selectedRestaurant.restaurantListPositions objectAtIndex:indexPath.row];
    
    NSString *listDetails = @"#";
    listDetails = [listDetails stringByAppendingString:[toplist.position stringValue]];
    listDetails = [listDetails stringByAppendingString:@") "];
    listDetails = [listDetails stringByAppendingString:toplist.listName];
    listDetails = [listDetails stringByAppendingString:@": "];
    
    if (toplist.neighborhoodName){
        listDetails = [listDetails stringByAppendingString:toplist.neighborhoodName];
        listDetails = [listDetails stringByAppendingString:@" - "];
    }
    
    listDetails = [listDetails stringByAppendingString:toplist.cityName];
    
    cell.textLabel.text = listDetails;
    cell.textLabel.textColor = [UIColor colorWithRed:98.0f/255.0f green:98.0f/255.0f blue:98.0f/255.0f alpha:1.0f];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGTopListPosition *toplist = [self.selectedRestaurant.restaurantListPositions objectAtIndex:indexPath.row];
    self.selectedTopList = toplist;
    
    NSMutableDictionary *params = [[CGRestaurantParameter shared] buildParameterMap];
    [params setObject:toplist.listId forKey:@"listId"];
    
    [self startSpinner];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurants"
                                           parameters:params
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if (mappingResult){
                                                      self.restaurants = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                      
                                                      [self.activityView stopAnimating];
                                                      [self performSegueWithIdentifier:@"topRestaurantListToListSegue" sender:self];
                                                  }
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                  message:@"There was an issue"
                                                                                                 delegate:nil
                                                                                        cancelButtonTitle:@"OK"
                                                                                        otherButtonTitles:nil];
                                                  [alert show];
                                                  NSLog(@"Hit error: %@", error);
                                                  
                                                  [self.activityView stopAnimating];
                                              }];

    
    
    
}

- (void) startSpinner {
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.center = CGPointMake(self.tableView.frame.size.width / 2.0, self.tableView.frame.size.height / 2.0);
    [self.tableView addSubview: self.activityView];
    
    [self.activityView startAnimating];
}

- (void) stopSpinner {
    [self.activityView stopAnimating];
    [self.activityView removeFromSuperview];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"topRestaurantListToListSegue"]){
        CGRestaurantListListViewController *listViewController = [segue destinationViewController];
        listViewController.restaurants = self.restaurants;
        [listViewController setDataLoaded:YES];
        listViewController.restaurantList = [[CGRestaurantList alloc] init];
        listViewController.restaurantList.name = self.selectedTopList.listName;
        listViewController.restaurantList.restaurantListId = self.selectedTopList.listId;
        [listViewController.tableView reloadData];
    }

}

@end
