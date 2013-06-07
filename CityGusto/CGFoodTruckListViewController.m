//
//  CGFoodTruckListViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 5/22/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGFoodTruckListViewController.h"
#import "CGFoodTruckCell.h"
#import <QuartzCore/QuartzCore.h>
#import "CGRestaurantHomeViewController.h"
#import "CGRestaurantMapViewController.h"
#import "MHLazyTableImages.h"
#import "CGFoodTruckOptionsViewController.h"
#import "CGRestaurantParameter.h"
#import "CGAppDelegate.h"
#import "MBProgressHud.h"
#import <RestKit/RestKit.h>

#define AppIconHeight    60.0f

@interface CGFoodTruckListViewController ()

@end

@implementation CGFoodTruckListViewController{
    MHLazyTableImages *_lazyImages;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if (self.locationChanged){
        self.locationChanged = NO;
        
        [self startSpinner];
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/foodtrucks/cuisines"
                                               parameters:[[CGRestaurantParameter shared] buildFoodTruckParameterMap]
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      if (mappingResult){
                                                          [[CGRestaurantParameter shared].foodTruckCuisinesForSelectedLocation removeAllObjects];
                                                          [[CGRestaurantParameter shared].foodTruckCuisinesForSelectedLocation addObjectsFromArray:[[mappingResult dictionary] objectForKey:@"cuisines"]];
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
        
        NSMutableDictionary *params = [[CGRestaurantParameter shared] buildFoodTruckParameterMap];
        [params setObject:@"true" forKey:@"reduced"];
        
        [CGRestaurantParameter shared].offset = 0;
        
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/foodtrucks"
                                               parameters:params
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      if (mappingResult){
                                                          self.foodTrucks = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                          
                                                          if (self.foodTrucks.count < 20){
                                                              self.tableView.tableFooterView = nil;
                                                          }else{
                                                              [self.tableView setTableFooterView:self.footerView];
                                                          }
                                                          
                                                          [self setDataLoaded:YES];
                                                          self.resultsEmpty = self.foodTrucks.count == 0 ? YES : NO;
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
                                                      [self stopSpinner];
                                                  }];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        UIImage *navBarImg = [UIImage imageNamed:@"appHeader.png"];
        [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(swithLocationChanged) name:locationChangedNotification object:nil];
    self.locationChanged = NO;
    
    _lazyImages = [[MHLazyTableImages alloc] init];
    _lazyImages.placeholderImage = [UIImage imageNamed:@"CityGusto App Icon - 60x60.png"];
    _lazyImages.delegate = self;
    _lazyImages.tableView = self.tableView;

    [self setDataLoaded:NO];
    
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 60)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(10, 3, 300, 44)];
    
    [button setTitle:@"View More" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    
    [button addTarget:self action:@selector(viewMorePressed:)
     forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIBarMetricsDefault];
    
    UIImage *greenImg = [UIImage imageNamed:@"buttonBackgroundGreen.png"];
    [button setBackgroundImage:greenImg forState:UIBarMetricsDefault];
    
    [self.footerView addSubview:button];
    
    [self.tableView setTableFooterView:self.footerView];
    
    self.noResultsView = [[UIView alloc] initWithFrame:self.tableView.frame];
    self.noResultsView.backgroundColor = [UIColor whiteColor];
    
    UILabel *matchesLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,320,320)];
    matchesLabel.font = [UIFont boldSystemFontOfSize:18];
    matchesLabel.numberOfLines = 0;
    matchesLabel.shadowColor = [UIColor lightTextColor];
    matchesLabel.textColor = [UIColor darkGrayColor];
    matchesLabel.shadowOffset = CGSizeMake(0, 1);
    matchesLabel.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0f];
    matchesLabel.textAlignment =  NSTextAlignmentCenter;
    matchesLabel.text = @"Your search returned no results.  Try clearing filters.";
    
    self.noResultsView.hidden = YES;
    [self.noResultsView addSubview:matchesLabel];
    [self.tableView insertSubview:self.noResultsView aboveSubview:self.tableView];
    
    [self startSpinner];
    if (self.foodTrucks.count == 0){
        NSMutableDictionary *params = [[CGRestaurantParameter shared] buildFoodTruckParameterMap];
        [params setObject:@"true" forKey:@"reduced"];
        
        [CGRestaurantParameter shared].offset = 0;
        
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/foodtrucks/cuisines"
                                               parameters:[[CGRestaurantParameter shared] buildFoodTruckParameterMap]
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      if (mappingResult){
                                                          [[CGRestaurantParameter shared].foodTruckCuisinesForSelectedLocation removeAllObjects];
                                                          [[CGRestaurantParameter shared].foodTruckCuisinesForSelectedLocation addObjectsFromArray:[[mappingResult dictionary] objectForKey:@"cuisines"]];
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
        
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/foodtrucks"
                                               parameters:params
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      if (mappingResult){
                                                          self.foodTrucks = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                          
                                                          if (self.foodTrucks.count < 20){
                                                              self.tableView.tableFooterView = nil;
                                                          }else{
                                                              [self.tableView setTableFooterView:self.footerView];
                                                          }
                                                          
                                                          [self setDataLoaded:YES];
                                                          self.resultsEmpty = self.foodTrucks.count == 0 ? YES : NO;
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
                                                      [self stopSpinner];
                                                  }];
    }
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
    if (self.resultsEmpty){
        self.noResultsView.hidden = NO;
    }else{
        self.noResultsView.hidden = YES;
    }
    return self.foodTrucks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FoodTruckCell";
    
    CGFoodTruckCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    CGRestaurant *restaurant = [self.foodTrucks objectAtIndex:indexPath.row];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    
    if (cell){
        NSString *name = restaurant.name;
        if (restaurant.distance){
            name = [name stringByAppendingString:@" - "];
            name = [name stringByAppendingString:[formatter stringFromNumber:restaurant.distance]];
            name = [name stringByAppendingString:@" Miles"];
        }
        
        cell.nameLabel.text = name;
        
        //NSURL *url = [NSURL URLWithString:restaurant.primaryPhotoURL];
        //NSData *data = [NSData dataWithContentsOfURL:url];
        //UIImage *image = [UIImage imageWithData:data];
        
        //cell.primaryPhotoImage.image = image;
        
        [_lazyImages addLazyImageForCell:cell withIndexPath:indexPath];
        
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
        
        cell.addressLabel.text = restaurant.address1;
        
        CALayer *bottomBorder = [CALayer layer];
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = cell.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f].CGColor, (id)[UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f].CGColor, nil];
        [cell.layer insertSublayer:gradient atIndex:0];
        
		bottomBorder.frame = CGRectMake(0.0f, cell.headerView.frame.size.height - 1, cell.headerView.frame.size.width, 1.0f);
        bottomBorder.backgroundColor = [UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f].CGColor;
        
        [cell.headerView.layer addSublayer:bottomBorder];
        
        cell.nameLabel.layer.shadowColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f].CGColor;
        cell.nameLabel.layer.shadowOffset = CGSizeMake(0.0, 0.0);
        [cell.nameLabel.layer setMasksToBounds:YES];
        
        cell.nameLabel.layer.shadowRadius = 3.0;
        cell.nameLabel.layer.shadowOpacity = 0.5;
        
        cell.topFiveLabel.text = topList;
        
        [cell.primaryPhotoImage.layer setBorderColor:[UIColor whiteColor].CGColor];
        [cell.primaryPhotoImage.layer setBorderWidth:1.5f];
        [cell.primaryPhotoImage.layer setShadowColor:[UIColor blackColor].CGColor];
        [cell.primaryPhotoImage.layer setShadowOpacity:0.8];
        [cell.primaryPhotoImage.layer setShadowRadius:3.0];
        [cell.primaryPhotoImage.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
        
        // New line
        //[cell.primaryPhotoImage.layer setShadowPath:[UIBezierPath bezierPathWithRect:cell.primaryPhotoImage.bounds].CGPath];
    }
    
    return cell;
}

- (void) startSpinner {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    hud.userInteractionEnabled = YES;
}

- (void) stopSpinner {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void) viewMorePressed:(id)sender{
    
    [CGRestaurantParameter shared].foodTruckOffset = [NSNumber numberWithInt:[[CGRestaurantParameter shared].offset intValue] + 20];
    NSMutableDictionary *params = [[CGRestaurantParameter shared] buildFoodTruckParameterMap];
    [params setObject:@"true" forKey:@"reduced"];
    
    [self startSpinner];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/foodtrucks"
                                           parameters:params
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if (mappingResult){
                                                      [self.foodTrucks addObjectsFromArray:[mappingResult array]];
                                                      
                                                      [self setDataLoaded:YES];
                                                      [self.tableView reloadData];
                                                      
                                                      if ([mappingResult array].count < 20){
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
    CGRestaurant *restaurant = [self.foodTrucks objectAtIndex:indexPath.row];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:restaurant.restaurantId, @"id", nil];
    
    [self startSpinner];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/foodtrucks"
                                           parameters:params
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if (mappingResult){
                                                      self.selectedFoodTruck = [[mappingResult array] objectAtIndex:0];
                                                      
                                                      [self stopSpinner];
                                                      [self performSegueWithIdentifier:@"foodTruckHomeSegue" sender:self];
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
    if ([[segue identifier] isEqualToString:@"mapFoodTruckSegue"]){
        CGRestaurantMapViewController *mapController = [segue destinationViewController];
        mapController.restaurants = self.foodTrucks;
    }
    
   else if ([[segue identifier] isEqualToString:@"foodTruckHomeSegue"]){
        CGRestaurantHomeViewController *homeController = [segue destinationViewController];
        homeController.restaurant = self.selectedFoodTruck;
    }else if ([[segue identifier] isEqualToString:@"foodTruckOptionsSegue"]){
        UINavigationController *navController = [segue destinationViewController];
        
        if (navController != nil){
            CGFoodTruckOptionsViewController *optionsController = (CGFoodTruckOptionsViewController *)navController.topViewController;
            optionsController.delegate = self;
        }
    }
}

- (void) updateFoodTrucks:(NSArray *)newFoodTrucks{
    [self.foodTrucks removeAllObjects];
    [self.foodTrucks addObjectsFromArray:newFoodTrucks];
    
    if (self.foodTrucks.count < 20){
        self.tableView.tableFooterView = nil;
    }else{
        [self.tableView setTableFooterView:self.footerView];
    }
    
    self.resultsEmpty = self.foodTrucks.count == 0 ? YES : NO;
    
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointZero animated:NO];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	[_lazyImages scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	[_lazyImages scrollViewDidEndDecelerating:scrollView];
}

#pragma mark - MHLazyTableImagesDelegate

- (NSURL *)lazyTableImages:(MHLazyTableImages *)lazyTableImages lazyImageURLForIndexPath:(NSIndexPath *)indexPath
{
    CGRestaurant *restaurant = [self.foodTrucks objectAtIndex:indexPath.row];
	return [NSURL URLWithString:restaurant.primaryPhotoURL];
}

- (UIImage *)lazyTableImages:(MHLazyTableImages *)lazyTableImages postProcessLazyImage:(UIImage *)image forIndexPath:(NSIndexPath *)indexPath
{
    if (image.size.width != AppIconHeight && image.size.height != AppIconHeight)
 		return [self scaleImage:image toSize:CGSizeMake(AppIconHeight, AppIconHeight)];
    else
        return image;
}

- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size
{
	UIGraphicsBeginImageContextWithOptions(size, YES, 0.0f);
	CGRect imageRect = CGRectMake(0.0f, 0.0f, size.width, size.height);
	[image drawInRect:imageRect];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

-(void) swithLocationChanged{
    self.locationChanged = YES;
}

@end
