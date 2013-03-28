//
//  CGRestaurantListViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 3/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurantListViewController.h"
#import "CGRestaurant.h"
#import "CGRestaurantCell.h"
#import "CGRestaurantParameter.h"
#import "CGRestaurantMapViewController.h"
#import "CGRestaurantDetailViewController.h"
#import "CGRestaurantOptionsViewController.h"

#import <RestKit/RestKit.h>

@interface CGRestaurantListViewController ()

@end

@implementation CGRestaurantListViewController

@synthesize restaurants;
@synthesize selectedRestaurant;
@synthesize activityView;

- (void)viewDidLoad
{
    [self setDataLoaded:NO];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 60)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(10, 3, 300, 44)];
    
    [button setTitle:@"View More" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    
    [button addTarget:self action:@selector(viewMorePressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
    
    [self.tableView setTableFooterView:footerView];
    
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityView.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.tableView addSubview: activityView];
    
    [self.activityView startAnimating];
    if (self.restaurants.count == 0){
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/MattsMenus/mobile/native/restaurants"
                                               parameters:[[CGRestaurantParameter shared] buildParameterMap]
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      if (mappingResult){
                                                          self.restaurants = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                          [self setDataLoaded:YES];
                                                          [self.tableView reloadData];
                                                          [self.activityView stopAnimating];
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
                                                  }];
        
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
    return self.restaurants.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RestaurantCell";
    
    CGRestaurantCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    CGRestaurant *restaurant = [self.restaurants objectAtIndex:indexPath.row];
    
    if (cell){
        cell.nameLabel.text = restaurant.name;
        
        NSURL *url = [NSURL URLWithString:restaurant.primaryPhotoURL150x150];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        cell.primaryPhotoImage.image = image;
        
        NSString *topList = @"Currently in Top 5 of ";
        topList = [topList stringByAppendingString:[restaurant.numberOfTopFiveLists stringValue]];
        topList = [topList stringByAppendingString:@" Lists"];
        
        NSString *numberOfRatings = [restaurant.numberOfRatings stringValue];
        numberOfRatings = [numberOfRatings stringByAppendingString:@" Ratings"];
        
        cell.ratings.text = numberOfRatings;
    }
    
    return cell;

}


- (void) viewMorePressed:(id)sender{
    [self.activityView startAnimating];
    
    [CGRestaurantParameter shared].offset = [NSNumber numberWithInt:[[CGRestaurantParameter shared].offset intValue] + 25];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/MattsMenus/mobile/native/restaurants"
                                           parameters:[[CGRestaurantParameter shared] buildParameterMap]
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if (mappingResult){
                                                      [self.restaurants addObjectsFromArray:[mappingResult array]];
                                                      
                                                      [self setDataLoaded:YES];
                                                      [self.tableView reloadData];
                                                      
                                                      [self.activityView startAnimating];
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
                                              }];
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedRestaurant = [self.restaurants objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}



-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"mapSegue"]){
        UINavigationController *navController = [segue destinationViewController];
        
        if (navController != nil){
            CGRestaurantMapViewController *mapController = (CGRestaurantMapViewController *)navController.topViewController;
            mapController.restaurants = self.restaurants;
        }
    }else if ([[segue identifier] isEqualToString:@"detailSegue"]){
        CGRestaurantDetailViewController *detailController = [segue destinationViewController];
        detailController.restaurant = self.selectedRestaurant;
    }else if ([[segue identifier] isEqualToString:@"optionSegue"]){
        UINavigationController *navController = [segue destinationViewController];
        
        if (navController != nil){
            CGRestaurantOptionsViewController *optionsController = (CGRestaurantOptionsViewController *)navController.topViewController;
            optionsController.delegate = self;
        }
    }
}

- (void) updateRestaurants:(NSArray *)newRestaurants{
    [self.restaurants removeAllObjects];
    [self.restaurants addObjectsFromArray:newRestaurants];
    
    [self.tableView reloadData];
}

@end
