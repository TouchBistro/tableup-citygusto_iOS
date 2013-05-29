//
//  CGRestaurantListCategoryHomeViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 4/4/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurantListCategoryHomeViewController.h"
#import "CGRestaurantParameter.h"
#import "CGRestaurantList.h"
#import "CGRestaurant.h"
#import "CGRestaurantListCategory.h"
#import "CGRestaurantHomeViewController.h"
#import "CGRestaurantListListViewController.h"
#import "CGSelectRestaurantListViewController.h"
#import "CGPhoto.h"
#import "AsyncImageView.h"
#import <CoreLocation/CoreLocation.h>
#import <RestKit/RestKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CGRestaurantListCategoryHomeViewController ()

@end

@implementation CGRestaurantListCategoryHomeViewController

@synthesize restaurantListCategories;

@synthesize headerView;
@synthesize headerLabel;
@synthesize listNameLabel;
@synthesize imageSliderView;

@synthesize restaurant1View;
@synthesize restaurant2View;
@synthesize restaurant3View;

@synthesize restaurant1Label;
@synthesize restaurant2Label;
@synthesize restaurant3Label;

@synthesize footerView;
@synthesize locationButton;

@synthesize activityView;

@synthesize currentCategory;
@synthesize currentRestaurantList;

@synthesize restaurant1;
@synthesize restaurant2;
@synthesize restaurant3;

@synthesize selectedRestaurant;

- (void)awakeFromNib
{
    self.wrap = NO;
}

-(void)viewDidLayoutSubviews{
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.restaurant1View.frame.size.height - 1, self.restaurant1View.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor colorWithRed:208.0f/255.0f green:208.0f/255.0f blue:208.0f/255.0f alpha:1.0f].CGColor;
    [self.restaurant1View.layer insertSublayer:bottomBorder atIndex:0];
    
    CALayer *bottomBorder2 = [CALayer layer];
    bottomBorder2.frame = CGRectMake(0.0f, self.restaurant2View.frame.size.height - 1, self.restaurant2View.frame.size.width, 1.0f);
    bottomBorder2.backgroundColor = [UIColor colorWithRed:208.0f/255.0f green:208.0f/255.0f blue:208.0f/255.0f alpha:1.0f].CGColor;
    [self.restaurant2View.layer insertSublayer:bottomBorder2 atIndex:0];
    
    CALayer *bottomBorder3 = [CALayer layer];
    bottomBorder3.frame = CGRectMake(0.0f, self.restaurant3View.frame.size.height - 1, self.restaurant3View.frame.size.width, 1.0f);
    bottomBorder3.backgroundColor = [UIColor colorWithRed:208.0f/255.0f green:208.0f/255.0f blue:208.0f/255.0f alpha:1.0f].CGColor;
    [self.restaurant3View.layer insertSublayer:bottomBorder3 atIndex:0];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.headerView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:173.0f/255.0f green:98.0f/255.0f blue:137.0f/255.0f alpha:1.0f].CGColor, (id)[UIColor colorWithRed:200.0f/255.0f green:150.0f/255.0f blue:176.0f/255.0f alpha:1.0f].CGColor, nil];
    [self.headerView.layer insertSublayer:gradient atIndex:0];
}

- (void)viewDidLoad
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        UIImage *navBarImg = [UIImage imageNamed:@"appHeader.png"];
        [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
    }
    
    self.restaurantListPhotoUrls = [[NSMutableArray alloc] init];
    
    self.carousel.type = iCarouselTypeCoverFlow2;
	self.carousel.decelerationRate = 0.5f;
	self.carousel.scrollSpeed = 0.5f;
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: self.activityView];
    
    UITapGestureRecognizer *singleFingerTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(handleRestaurantViewTap:)];
    UITapGestureRecognizer *singleFingerTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(handleRestaurantViewTap:)];
    UITapGestureRecognizer *singleFingerTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(handleRestaurantViewTap:)];
    
    UITapGestureRecognizer *singleFingerTapListView1 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(handleRestaurantListViewTap:)];
    
    UITapGestureRecognizer *singleFingerTapHeaderView1 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                              action:@selector(handleHeaderViewTap:)];
    
    [singleFingerTap1 setCancelsTouchesInView:NO];
    [singleFingerTap2 setCancelsTouchesInView:NO];
    [singleFingerTap3 setCancelsTouchesInView:NO];
    [self.restaurant1View addGestureRecognizer:singleFingerTap1];
    [self.restaurant2View addGestureRecognizer:singleFingerTap2];
    [self.restaurant3View addGestureRecognizer:singleFingerTap3];
    
    [singleFingerTapListView1 setCancelsTouchesInView:NO];
    [self.listNameView addGestureRecognizer:singleFingerTapListView1];
    
    [singleFingerTapHeaderView1 setCancelsTouchesInView:NO];
    [self.headerView addGestureRecognizer:singleFingerTapHeaderView1];
    
    self.restaurantListPhotoUrls = [[NSMutableArray alloc] init];
    
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDelegate:self];
        
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [self.locationManager startUpdatingLocation];
    
        
    
    [super viewDidLoad];
}

-(void) showRestaurantListCategory{
    self.restaurant1Label.text = @"";
    self.restaurant2Label.text = @"";
    self.restaurant3Label.text = @"";
    
    if (currentCategory){
        self.headerLabel.text = currentCategory.name;
        if (self.currentRestaurantList == nil){
            self.currentRestaurantList = self.currentCategory.restaurantLists[0];
        }
        
        if (currentRestaurantList){
            self.listNameLabel.text = currentRestaurantList.name;
            
            if (0 < self.currentRestaurantList.restaurants.count){
                if (currentRestaurantList.restaurants[0]){
                    self.restaurant1 = currentRestaurantList.restaurants[0];
                    NSString *listRestaurantText = @"1) ";
                    listRestaurantText = [listRestaurantText stringByAppendingString:self.restaurant1.name];
                    
                    if (self.restaurant1.distance){
                        listRestaurantText = [listRestaurantText stringByAppendingString:@" - "];
                        listRestaurantText = [listRestaurantText stringByAppendingString:[self.restaurant1.distance stringValue]];
                        listRestaurantText = [listRestaurantText stringByAppendingString:@" Miles"];
                    }
                    
                    self.restaurant1Label.text = listRestaurantText;
                }
            }
            
            if (1 < self.currentRestaurantList.restaurants.count){
                if (currentRestaurantList.restaurants[1]){
                    self.restaurant2 = currentRestaurantList.restaurants[1];
                    
                    NSString *listRestaurantText = @"2) ";
                    listRestaurantText = [listRestaurantText stringByAppendingString:self.restaurant2.name];
                    
                    if (self.restaurant2.distance){
                        listRestaurantText = [listRestaurantText stringByAppendingString:@" - "];
                        listRestaurantText = [listRestaurantText stringByAppendingString:[self.restaurant2.distance stringValue]];
                        listRestaurantText = [listRestaurantText stringByAppendingString:@" Miles"];
                    }
                    
                    self.restaurant2Label.text = listRestaurantText;
                }
            }
            
            if (2 < self.currentRestaurantList.restaurants.count){
                if (currentRestaurantList.restaurants[2]){
                    self.restaurant3 = currentRestaurantList.restaurants[2];
                    
                    NSString *listRestaurantText = @"3) ";
                    listRestaurantText = [listRestaurantText stringByAppendingString:self.restaurant3.name];
                    
                    if (self.restaurant3.distance){
                        listRestaurantText = [listRestaurantText stringByAppendingString:@" - "];
                        listRestaurantText = [listRestaurantText stringByAppendingString:[self.restaurant3.distance stringValue]];
                        listRestaurantText = [listRestaurantText stringByAppendingString:@" Miles"];
                    }
                    
                    self.restaurant3Label.text = listRestaurantText;
                }
            }
        }
    }
}

-(void) viewDidAppear:(BOOL)animated{
    [locationButton setTitle:[CGRestaurantParameter shared].getLocationName forState:UIControlStateNormal];
    
    if (self.currentCategory == nil){
        [self.activityView startAnimating];
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurantListCategories"
                                               parameters:[[CGRestaurantParameter shared] buildParameterMap]
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      if (mappingResult){
                                                          self.restaurantListCategories = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                          if (self.restaurantListCategories.count > 0){
                                                              currentCategory = self.restaurantListCategories[0];
                                                              if (currentCategory){
                                                                  self.currentRestaurantList = self.currentCategory.restaurantLists[0];
                                                              }
                                                              [self showRestaurantListCategory];
                                                          }
                                                      }
                                                      
                                                      [self.activityView stopAnimating];
                                                      
                                                      [self.restaurantListPhotoUrls removeAllObjects];
                                                      NSUInteger count = 0;
                                                      for (CGRestaurantList *restauantList in self.currentCategory.restaurantLists){
                                                          NSInteger index = MAX(0, count);
                                                          
                                                          [self.restaurantListPhotoUrls insertObject:restauantList.photoURL atIndex:index];
                                                          count++;
                                                      }
                                                      
                                                      [self.carousel reloadData];
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleRestaurantViewTap:(UITapGestureRecognizer *)recognizer {
    CGRestaurant *restaurant;
    
    if (recognizer.view == self.restaurant1View){
        restaurant = self.restaurant1;
    }else if (recognizer.view == self.restaurant2View){
        restaurant = self.restaurant2;
    }else if (recognizer.view == self.restaurant3View){
        restaurant = self.restaurant3;
    }
    
    if (restaurant){
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:restaurant.restaurantId, @"id", nil];
        
        [self.activityView startAnimating];
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurants"
                                               parameters:params
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      if (mappingResult){
                                                          self.selectedRestaurant = [[mappingResult array] objectAtIndex:0];
                                                          [self.activityView stopAnimating];
                                                          
                                                          [self performSegueWithIdentifier:@"listRestaurantDetailSegue" sender:self];
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
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"listRestaurantDetailSegue"]){
        CGRestaurantHomeViewController *homeController = [segue destinationViewController];
        homeController.restaurant = self.selectedRestaurant;
    }else if ([[segue identifier] isEqualToString:@"restaurantListListSegue"]){
        CGRestaurantListListViewController *listViewController = [segue destinationViewController];
        
        NSMutableDictionary *params = [[CGRestaurantParameter shared] buildParameterMap];
        [params setObject:self.currentRestaurantList.restaurantListId forKey:@"listId"];
        
        [self.activityView startAnimating];
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurants"
                                               parameters:params
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      if (mappingResult){
                                                          
                                                          listViewController.restaurants = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                          [listViewController setDataLoaded:YES];
                                                          listViewController.restaurantList = self.currentRestaurantList;
                                                          [listViewController.tableView reloadData];
                                                          
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
                                                      
                                                      [self.activityView stopAnimating];
                                                  }];
        
    }else if ([[segue identifier] isEqualToString:@"selectListSegue"]){
        UINavigationController *navController = [segue destinationViewController];
        
        if (navController != nil){
            CGSelectRestaurantListViewController *selectListView = (CGSelectRestaurantListViewController *)navController.topViewController;
            selectListView.restaurantLists = self.currentCategory.restaurantLists;
            selectListView.delegate = self;
        }
    }else if ([[segue identifier] isEqualToString:@"selectCategorySegue"]){
        UINavigationController *navController = [segue destinationViewController];
        
        if (navController != nil){
            CGSelectRestaurantCategoryViewController *selectCategoryView = (CGSelectRestaurantCategoryViewController *)navController.topViewController;
            selectCategoryView.restaurantCategories = self.restaurantListCategories;
            selectCategoryView.delegate = self;
        }
    }else if ([[segue identifier] isEqualToString:@"listLocationSegue"]){
        UINavigationController *navController = [segue destinationViewController];
        
        if (navController != nil){
            CGLocationViewController *locationController = (CGLocationViewController *)navController.topViewController;
            locationController.delegate = self;
        }
    }
    
}
- (void)handleRestaurantListViewTap:(UITapGestureRecognizer *)recognizer {
    if (recognizer.view == self.listNameView){
        [self performSegueWithIdentifier:@"restaurantListListSegue" sender:self];
    }
}

- (void)handleHeaderViewTap:(UITapGestureRecognizer *)recognizer {
    if (recognizer.view == self.headerView){
        [self performSegueWithIdentifier:@"selectCategorySegue" sender:self];
    }
}


- (void) updateRestaurantList:(CGRestaurantList *) restaurantList selectedIndex:(NSInteger)index{
    //self.currentRestaurantList = restaurantList;
    //[self showRestaurantListCategory];
    
    //[self.carousel scrollToItemAtIndex:index animated:NO];
    
    self.currentRestaurantList = restaurantList;
    [self performSegueWithIdentifier:@"restaurantListListSegue" sender:self];
}

- (void) updateRestaurantCategory:(CGRestaurantListCategory *) restaurantCategory{
    self.currentCategory = restaurantCategory;
    if (self.currentCategory){
        self.currentRestaurantList = self.currentCategory.restaurantLists[0];
    }
    
    [self.restaurantListPhotoUrls removeAllObjects];
    NSUInteger count = 0;
    for (CGRestaurantList *restauantList in self.currentCategory.restaurantLists){
        NSInteger index = MAX(0, count);
        
        [self.restaurantListPhotoUrls insertObject:restauantList.photoURL atIndex:index];
//        [self.carousel insertItemAtIndex:index animated:YES];
        
        count++;
    }
    
    [self.carousel reloadData];
    [self showRestaurantListCategory];
    [self.carousel scrollToItemAtIndex:0 animated:NO];
}


- (void)locationChanged{
    [locationButton setTitle:[CGRestaurantParameter shared].getLocationName forState:UIControlStateNormal];
    
    [self.activityView startAnimating];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurantListCategories"
                                           parameters:[[CGRestaurantParameter shared] buildParameterMap]
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  [self.activityView stopAnimating];

                                                  if (mappingResult){
                                                      self.restaurantListCategories = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                      if (self.restaurantListCategories.count > 0){
                                                          self.currentCategory = self.restaurantListCategories[0];
                                                          if (self.currentCategory){
                                                              self.currentRestaurantList = self.currentCategory.restaurantLists[0];
                                                          }
                                                          
                                                          [self.restaurantListPhotoUrls removeAllObjects];
                                                          NSUInteger count = 0;
                                                          for (CGRestaurantList *restauantList in self.currentCategory.restaurantLists){
                                                              NSInteger index = MAX(0, count);
                                                              
                                                              [self.restaurantListPhotoUrls insertObject:restauantList.photoURL atIndex:index];
//                                                              [self.carousel insertItemAtIndex:index animated:YES];
                                                              
                                                              count++;
                                                          }
                                                          
                                                          [self.carousel reloadData];
                                                          [self showRestaurantListCategory];
                                                          [self.carousel scrollToItemAtIndex:0 animated:NO];
                                                      }
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

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [self.restaurantListPhotoUrls count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    NSString *photoURL = [self.restaurantListPhotoUrls objectAtIndex:index];
    
    if (view == nil)
    {
        view = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, 130.0f, 130.0f)];
        view.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    //cancel any previously loading images for this view
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:view];
    
    //set image URL. AsyncImageView class will then dynamically load the image
    ((AsyncImageView *)view).imageURL = [NSURL URLWithString:photoURL];
    
    return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    return 0;
}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    return self.wrap;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    CGRestaurantList *restaurantList = [self.currentCategory.restaurantLists objectAtIndex:index];
    self.currentRestaurantList = restaurantList;
    [self performSegueWithIdentifier:@"restaurantListListSegue" sender:self];
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)aCarousel{
    CGRestaurantList *restaurantList = [self.currentCategory.restaurantLists objectAtIndex:aCarousel.currentItemIndex];
    
    self.currentRestaurantList = restaurantList;
    [self showRestaurantListCategory];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [self.locationManager stopUpdatingLocation];
    
    CLLocation *location = [locations objectAtIndex:0];
    
    CGRestaurantParameter *params = [CGRestaurantParameter shared];
    
    params.useCurrentLocation = YES;
    params.lat = [NSNumber numberWithDouble:location.coordinate.latitude];
    params.lon = [NSNumber numberWithDouble:location.coordinate.longitude];
    
    [self locationChanged];
}


- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self.locationManager stopUpdatingLocation];
}

@end
