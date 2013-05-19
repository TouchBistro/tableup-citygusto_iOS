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
#import "CGRestaurantHomeViewController.h"
#import "CGRestaurantOptionsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <RestKit/RestKit.h>

@interface CGRestaurantListViewController ()

@end

@implementation CGRestaurantListViewController

@synthesize restaurants;
@synthesize selectedRestaurant;
@synthesize activityView;

- (void)viewDidLoad
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        UIImage *navBarImg = [UIImage imageNamed:@"appHeader.png"];
        [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
        
    }
    
    [self setDataLoaded:NO];
    
    
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 60)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(10, 3, 300, 44)];
    
    [button setTitle:@"View More" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    
    [button addTarget:self action:@selector(viewMorePressed:)
     forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIBarMetricsDefault];
    
    UIImage *greenImg = [UIImage imageNamed:@"buttonBackgroundGreen.png"];
    [button setBackgroundImage:greenImg forState:UIBarMetricsDefault];
    
    [self.footerView addSubview:button];
    
    [self.tableView setTableFooterView:self.footerView];
    
    [self startSpinner];
    if (self.restaurants.count == 0){
        NSMutableDictionary *params = [[CGRestaurantParameter shared] buildParameterMap];
        [params setObject:@"true" forKey:@"reduced"];
        
        [CGRestaurantParameter shared].offset = 0;
        
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurants"
                                               parameters:params
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      if (mappingResult){
                                                          self.restaurants = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                          
                                                          if (self.restaurants.count < 25){
                                                              self.tableView.tableFooterView = nil;
                                                          }else{
                                                              [self.tableView setTableFooterView:self.footerView];
                                                          }
                                                          
                                                          [self setDataLoaded:YES];
                                                          [self.tableView reloadData];
                                                          [self stopSpinner];
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
    
    [super viewDidLoad];
}

- (void) startSpinner {
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.center = CGPointMake(self.tableView.frame.size.width / 2.0, self.tableView.frame.size.height / 2.0);
    [self.tableView addSubview: activityView];
    
    [self.activityView startAnimating];
}

- (void) stopSpinner {
    [self.activityView stopAnimating];
    [self.activityView removeFromSuperview];
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
        NSString *name = restaurant.name;
        if (restaurant.distance){
            name = [name stringByAppendingString:@" - "];
            name = [name stringByAppendingString:[restaurant.distance stringValue]];
            name = [name stringByAppendingString:@" Miles"];
        }
        
        cell.nameLabel.text = name;
        
        NSURL *url = [NSURL URLWithString:restaurant.primaryPhotoURL];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        cell.primaryPhotoImage.image = image;
        
        NSString *topList = @"Currently in Top 5 of ";
        topList = [topList stringByAppendingString:[restaurant.numberOfTopFiveLists stringValue]];
        topList = [topList stringByAppendingString:@" Lists"];
        
        NSString *numberOfRatings = [restaurant.numberOfRatings stringValue];
        numberOfRatings = [numberOfRatings stringByAppendingString:@" Ratings"];
        
        cell.ratings.text = numberOfRatings;
        
        if (restaurant.numberOfStars == [NSNumber numberWithInt:1]) {
            [cell.starImages setImage:[UIImage imageNamed:@"stars_1.png"]];
        }else if (restaurant.numberOfStars == [NSNumber numberWithInt:2]) {
            [cell.starImages setImage:[UIImage imageNamed:@"stars_2.png"]];
        }else if (restaurant.numberOfStars == [NSNumber numberWithInt:3]) {
            [cell.starImages setImage:[UIImage imageNamed:@"stars_3.png"]];
        }else if (restaurant.numberOfStars == [NSNumber numberWithInt:4]) {
            [cell.starImages setImage:[UIImage imageNamed:@"stars_4.png"]];
        }else if (restaurant.numberOfStars == [NSNumber numberWithInt:5]) {
            [cell.starImages setImage:[UIImage imageNamed:@"stars_5.png"]];
        }else{
            [cell.starImages setImage:[UIImage imageNamed:@"stars_0.png"]];
        }
        
        if (restaurant.numberOfDollarSigns == [NSNumber numberWithInt:1]){
            [cell.priceImageView setImage:[UIImage imageNamed:@"reviewdollars1.png"]];
        }else if (restaurant.numberOfDollarSigns == [NSNumber numberWithInt:2]){
            [cell.priceImageView setImage:[UIImage imageNamed:@"reviewdollars2.png"]];
        }else if (restaurant.numberOfDollarSigns == [NSNumber numberWithInt:3]){
            [cell.priceImageView setImage:[UIImage imageNamed:@"reviewdollars3.png"]];
        }else if (restaurant.numberOfDollarSigns == [NSNumber numberWithInt:4]){
            [cell.priceImageView setImage:[UIImage imageNamed:@"reviewdollars4.png"]];
        }else if (restaurant.numberOfDollarSigns == [NSNumber numberWithInt:5]){
            [cell.priceImageView setImage:[UIImage imageNamed:@"reviewdollars5.png"]];
        }else{
            [cell.priceImageView setImage:[UIImage imageNamed:@"reviewdollars1.png"]];
        }
        
        //style
//        cell.headerView.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
//        cell.nameLabel.textColor = [UIColor colorWithRed:98.0f/255.0f green:137.0f/255.0f blue:173.0f/255.0f alpha:1.0f];
        
        CALayer *bottomBorder = [CALayer layer];
        
        bottomBorder.frame = CGRectMake(0.0f, cell.headerView.frame.size.height - 1, cell.headerView.frame.size.width, 1.0f);
        bottomBorder.backgroundColor = [UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f].CGColor;
        
        [cell.headerView.layer addSublayer:bottomBorder];
        
        cell.nameLabel.layer.shadowColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f].CGColor;
        cell.nameLabel.layer.shadowOffset = CGSizeMake(0.0, 0.0);
        [cell.nameLabel.layer setMasksToBounds:YES];
        
        cell.nameLabel.layer.shadowRadius = 3.0;
        cell.nameLabel.layer.shadowOpacity = 0.5;
        
        cell.topFiveLabel.text = topList;
        
        [cell.primaryPhotoImage.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [cell.primaryPhotoImage.layer setBorderWidth:1.5f];
        [cell.primaryPhotoImage.layer setShadowColor:[UIColor blackColor].CGColor];
        [cell.primaryPhotoImage.layer setShadowOpacity:0.8];
        [cell.primaryPhotoImage.layer setShadowRadius:3.0];
        [cell.primaryPhotoImage.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
        
    }
    
    return cell;

}


- (void) viewMorePressed:(id)sender{
    
    [CGRestaurantParameter shared].offset = [NSNumber numberWithInt:[[CGRestaurantParameter shared].offset intValue] + 25];
    NSMutableDictionary *params = [[CGRestaurantParameter shared] buildParameterMap];
    [params setObject:@"true" forKey:@"reduced"];
    
    [self startSpinner];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurants"
                                           parameters:params
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if (mappingResult){
                                                      [self.restaurants addObjectsFromArray:[mappingResult array]];
                                                      
                                                      [self setDataLoaded:YES];
                                                      [self.tableView reloadData];
                                                      
                                                      if ([mappingResult array].count < 25){
                                                          self.tableView.tableFooterView = nil;
                                                      }else{
                                                          [self.tableView setTableFooterView:self.footerView];
                                                      }
                                                      
                                                      [self stopSpinner];
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
    CGRestaurant *restaurant = [self.restaurants objectAtIndex:indexPath.row];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:restaurant.restaurantId, @"id", nil];
    
    [self startSpinner];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurants"
                                           parameters:params
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if (mappingResult){
                                                      self.selectedRestaurant = [[mappingResult array] objectAtIndex:0];
                                                      
                                                      [self stopSpinner];
                                                      [self performSegueWithIdentifier:@"homeSegue" sender:self];
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



-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"mapSegue"]){
        CGRestaurantMapViewController *mapController = [segue destinationViewController];
        mapController.restaurants = self.restaurants;
    }else if ([[segue identifier] isEqualToString:@"homeSegue"]){
        CGRestaurantHomeViewController *homeController = [segue destinationViewController];
        homeController.restaurant = self.selectedRestaurant;
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
    
    if (self.restaurants.count < 25){
        self.tableView.tableFooterView = nil;
    }else{
        [self.tableView setTableFooterView:self.footerView];
    }
    
    [self.tableView reloadData];
}

@end
