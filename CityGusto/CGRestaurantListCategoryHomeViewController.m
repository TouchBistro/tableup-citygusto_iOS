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
#import "CGAppDelegate.h"
#import "MBProgressHud.h"
#import "iCarousel.h"
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
    
    CALayer *bottomBorder4 = [CALayer layer];
    bottomBorder4.frame = CGRectMake(0.0f, self.restaurant4View.frame.size.height - 1, self.restaurant4View.frame.size.width, 1.0f);
    bottomBorder4.backgroundColor = [UIColor colorWithRed:208.0f/255.0f green:208.0f/255.0f blue:208.0f/255.0f alpha:1.0f].CGColor;
    [self.restaurant4View.layer insertSublayer:bottomBorder4 atIndex:0];
    
    CALayer *bottomBorder5 = [CALayer layer];
    bottomBorder5.frame = CGRectMake(0.0f, self.restaurant5View.frame.size.height - 1, self.restaurant5View.frame.size.width, 1.0f);
    bottomBorder5.backgroundColor = [UIColor colorWithRed:208.0f/255.0f green:208.0f/255.0f blue:208.0f/255.0f alpha:1.0f].CGColor;
    [self.restaurant5View.layer insertSublayer:bottomBorder5 atIndex:0];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.headerView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:173.0f/255.0f green:98.0f/255.0f blue:137.0f/255.0f alpha:1.0f].CGColor, (id)[UIColor colorWithRed:200.0f/255.0f green:150.0f/255.0f blue:176.0f/255.0f alpha:1.0f].CGColor, nil];
//    [self.headerView.layer insertSublayer:gradient atIndex:0];
    
    [self.scrollView setContentSize:CGSizeMake(320, 660)];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.scrollView.delegate = self;
    [self.scrollView setScrollEnabled:YES];
    
//    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"320x35Bottom.png"]];
//    titleImageView.frame = CGRectMake(0,220,320,35);
    
//    self.listNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
//    self.listNameLabel.textAlignment = NSTextAlignmentCenter;
    
//    if (self.currentRestaurantList){
//        self.listNameLabel.text = self.currentRestaurantList.name;
//    }
    
//    [titleImageView addSubview:self.listNameLabel];
//    [self.imageSliderView addSubview:titleImageView];
    
}

- (void)viewDidLoad
{
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        UIImage *navBarImg = [UIImage imageNamed:@"appHeader.png"];
        [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
    }
    
    self.expertNameView = [[UIView alloc] initWithFrame:CGRectMake(0, self.imageSliderView.frame.origin.y + self.imageSliderView.frame.size.height, self.view.frame.size.width, 20)];
    self.expertNameView.backgroundColor = [UIColor clearColor];
    
    CALayer *bottomBorderExpertView = [CALayer layer];
    bottomBorderExpertView.frame = CGRectMake(0.0f, self.expertNameView.frame.size.height - 1, self.expertNameView.frame.size.width, 1.0f);
    bottomBorderExpertView.backgroundColor = [UIColor colorWithRed:208.0f/255.0f green:208.0f/255.0f blue:208.0f/255.0f alpha:1.0f].CGColor;
    [self.expertNameView.layer insertSublayer:bottomBorderExpertView atIndex:0];
    
    self.expertNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    self.expertNameLabel.font = [UIFont boldSystemFontOfSize:12.0];
    self.expertNameLabel.textColor = [UIColor colorWithRed:98.0/255.0 green:137.0/255.0 blue:173.0/255.0 alpha:1.0f];
    self.expertNameLabel.textAlignment = NSTextAlignmentCenter;
    self.expertNameLabel.backgroundColor = [UIColor clearColor];
    
    [self.expertNameView addSubview:self.expertNameLabel];
    self.showingVotedBy = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(swithLocationChanged) name:locationChangedNotification object:nil];
    self.locationChangedFlag = NO;
    
    self.restaurantListPhotoUrls = [[NSMutableArray alloc] init];
    
    self.carousel.type = iCarouselTypeLinear;
	self.carousel.decelerationRate = 0.95f;
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
    UITapGestureRecognizer *singleFingerTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(handleRestaurantViewTap:)];
    UITapGestureRecognizer *singleFingerTap5 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(handleRestaurantViewTap:)];
    
    UITapGestureRecognizer *singleFingerTapListView1 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(handleRestaurantListViewTap:)];
    
    UITapGestureRecognizer *singleFingerTapHeaderView1 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                              action:@selector(handleHeaderViewTap:)];
    
    [singleFingerTap1 setCancelsTouchesInView:NO];
    [singleFingerTap2 setCancelsTouchesInView:NO];
    [singleFingerTap3 setCancelsTouchesInView:NO];
    [singleFingerTap4 setCancelsTouchesInView:NO];
    [singleFingerTap5 setCancelsTouchesInView:NO];
    [self.restaurant1View addGestureRecognizer:singleFingerTap1];
    [self.restaurant2View addGestureRecognizer:singleFingerTap2];
    [self.restaurant3View addGestureRecognizer:singleFingerTap3];
    [self.restaurant4View addGestureRecognizer:singleFingerTap4];
    [self.restaurant5View addGestureRecognizer:singleFingerTap5];
    
    [singleFingerTapListView1 setCancelsTouchesInView:NO];
    [self.listNameView addGestureRecognizer:singleFingerTapListView1];
    
    [singleFingerTapHeaderView1 setCancelsTouchesInView:NO];
    [self.headerView addGestureRecognizer:singleFingerTapHeaderView1];
    
    self.restaurantListPhotoUrls = [[NSMutableArray alloc] init];
    
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"320x35Bottom.png"]];
    titleImageView.frame = CGRectMake(0,220,320,35);
    
    self.listNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
    self.listNameLabel.textAlignment = NSTextAlignmentCenter;
    
    if (self.currentRestaurantList){
        self.listNameLabel.text = self.currentRestaurantList.name;
    }
    
    [titleImageView addSubview:self.listNameLabel];
    [self.imageSliderView addSubview:titleImageView];
    
    if (self.currentCategory == nil){
        [self startSpinner];
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurantListCategories"
                                               parameters:[[CGRestaurantParameter shared] buildParameterMap]
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      //[[CGRestaurantParameter shared] getCurrentLocation];
                                                      
                                                      if (mappingResult){
                                                          self.restaurantListCategories = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                          
                                                          CGRestaurantListCategory *expertCategory = [[CGRestaurantListCategory alloc] init];
                                                          expertCategory.restaurantListCategoryId = [NSNumber numberWithInt:4];
                                                          expertCategory.name = @"Experts";
                                                          
                                                          [self.restaurantListCategories addObject:expertCategory];
                                                          
                                                          CGRestaurantListCategory *personalCategory = [[CGRestaurantListCategory alloc] init];
                                                          personalCategory.restaurantListCategoryId = [NSNumber numberWithInt:5];
                                                          personalCategory.name = @"Personal";
                                                          
                                                          [self.restaurantListCategories addObject:personalCategory];
                                                          
                                                          if (self.restaurantListCategories.count > 0){
                                                              currentCategory = self.restaurantListCategories[0];
                                                              if (currentCategory){
                                                                  self.currentRestaurantList = self.currentCategory.restaurantLists[0];
                                                              }
                                                              [self showRestaurantListCategory];
                                                          }
                                                      }
                                                      
                                                      [self stopSpinner];
                                                      
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
                                                      
                                                      [self stopSpinner];
                                                  }];
    }
    
    
    
    [super viewDidLoad];
}

-(void) showRestaurantListCategory{
    self.restaurant1Label.text = @"";
    self.restaurant2Label.text = @"";
    self.restaurant3Label.text = @"";
    self.restaurant4Label.text = @"";
    self.restaurant5Label.text = @"";
    self.listNameLabel.text = @"";
    
    self.expertNameView.hidden = YES;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    
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
                        listRestaurantText = [listRestaurantText stringByAppendingString:[formatter stringFromNumber:self.restaurant1.distance]];
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
                        listRestaurantText = [listRestaurantText stringByAppendingString:[formatter stringFromNumber:self.restaurant2.distance]];
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
                        listRestaurantText = [listRestaurantText stringByAppendingString:[formatter stringFromNumber:self.restaurant3.distance]];
//                        listRestaurantText = [listRestaurantText stringByAppendingString:[self.restaurant3.distance stringValue]];
                        listRestaurantText = [listRestaurantText stringByAppendingString:@" Miles"];
                    }
                    
                    self.restaurant3Label.text = listRestaurantText;
                }
            }
            
            if (3 < self.currentRestaurantList.restaurants.count){
                if (currentRestaurantList.restaurants[3]){
                    self.restaurant4 = currentRestaurantList.restaurants[3];
                    
                    NSString *listRestaurantText = @"4) ";
                    listRestaurantText = [listRestaurantText stringByAppendingString:self.restaurant4.name];
                    
                    if (self.restaurant3.distance){
                        listRestaurantText = [listRestaurantText stringByAppendingString:@" - "];
                        listRestaurantText = [listRestaurantText stringByAppendingString:[formatter stringFromNumber:self.restaurant4.distance]];
                        //                        listRestaurantText = [listRestaurantText stringByAppendingString:[self.restaurant3.distance stringValue]];
                        listRestaurantText = [listRestaurantText stringByAppendingString:@" Miles"];
                    }
                    
                    self.restaurant4Label.text = listRestaurantText;
                }
            }
            
            if (4 < self.currentRestaurantList.restaurants.count){
                if (currentRestaurantList.restaurants[4]){
                    self.restaurant5 = currentRestaurantList.restaurants[4];
                    
                    NSString *listRestaurantText = @"5) ";
                    listRestaurantText = [listRestaurantText stringByAppendingString:self.restaurant5.name];
                    
                    if (self.restaurant5.distance){
                        listRestaurantText = [listRestaurantText stringByAppendingString:@" - "];
                        listRestaurantText = [listRestaurantText stringByAppendingString:[formatter stringFromNumber:self.restaurant5.distance]];
                        //                        listRestaurantText = [listRestaurantText stringByAppendingString:[self.restaurant3.distance stringValue]];
                        listRestaurantText = [listRestaurantText stringByAppendingString:@" Miles"];
                    }
                    
                    self.restaurant5Label.text = listRestaurantText;
                }
            }
            
            if (self.currentRestaurantList.user){
                self.expertNameView.hidden = NO;
                CGListUser *voter = self.currentRestaurantList.user;
                
                if (voter.lastname){
                    NSString *votedByTest = [NSString stringWithFormat:@"Votes By: %@ %@", voter.firstname, voter.lastname];
                    self.expertNameLabel.text = votedByTest;
                }else{
                    NSString *votedByTest = [NSString stringWithFormat:@"Votes By: %@", voter.firstname];
                    self.expertNameLabel.text = votedByTest;
                }
            }
            
        }
    }
}

-(void) viewDidAppear:(BOOL)animated{
    [locationButton setTitle:[CGRestaurantParameter shared].getLocationName forState:UIControlStateNormal];
    
    if (self.locationChangedFlag == YES){
        self.locationChangedFlag = NO;
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
    }else if (recognizer.view == self.restaurant4View){
        restaurant = self.restaurant4;
    }else if (recognizer.view == self.restaurant5View){
        restaurant = self.restaurant5;
    }
    
    if (restaurant){
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:restaurant.restaurantId, @"id", nil];
        
        [self startSpinner];
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurants"
                                               parameters:params
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      if (mappingResult){
                                                          self.selectedRestaurant = [[mappingResult array] objectAtIndex:0];
                                                          [self stopSpinner];
                                                          
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
                                                      [self stopSpinner];
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
        
        if (self.currentRestaurantList.user){
            [params setObject:self.currentRestaurantList.user.userId forKey:@"userId"];
        }
        
        [self startSpinner];
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurants"
                                               parameters:params
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      if (mappingResult){
                                                          
                                                          listViewController.restaurants = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                          [listViewController setDataLoaded:YES];
                                                          listViewController.restaurantList = self.currentRestaurantList;
                                                          [listViewController.tableView reloadData];
                                                          
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
    if ([restaurantCategory.restaurantListCategoryId intValue] == 4 || [restaurantCategory.restaurantListCategoryId intValue] == 5){
        [self startSpinner];
        NSMutableDictionary *params = [[CGRestaurantParameter shared] buildParameterMap];
        [params setObject:restaurantCategory.restaurantListCategoryId forKey:@"id"];
        
        if ([restaurantCategory.restaurantListCategoryId intValue] == 5){
            [params setObject:[CGRestaurantParameter shared].loggedInUser.username forKey:@"username"];
        }
        
        
        if (self.showingVotedBy == NO){
            [self.scrollView addSubview:self.expertNameView];
            
            CGRect newFrame = self.restaurant1View.frame;
            newFrame.origin.y += 20;
            self.restaurant1View.frame = newFrame;
            
            CGRect newFrame2 = self.restaurant2View.frame;
            newFrame2.origin.y += 20;
            self.restaurant2View.frame = newFrame2;
            
            CGRect newFrame3 = self.restaurant3View.frame;
            newFrame3.origin.y += 20;
            self.restaurant3View.frame = newFrame3;
            
            CGRect newFrame4 = self.restaurant4View.frame;
            newFrame4.origin.y += 20;
            self.restaurant4View.frame = newFrame4;
            
            CGRect newFrame5 = self.restaurant5View.frame;
            newFrame5.origin.y += 20;
            self.restaurant5View.frame = newFrame5;
            
            CGRect newFrame6 = self.footerView.frame;
            newFrame6.origin.y += 20;
            self.footerView.frame = newFrame6;
            
            self.showingVotedBy = YES;
        }
        
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurantListCategories"
                                               parameters:params
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      currentCategory = [[NSMutableArray alloc] initWithArray:[mappingResult array]][0];
                                                      if (currentCategory){
                                                          self.currentRestaurantList = self.currentCategory.restaurantLists[0];
                                                      }
                                                      
                                                      [self.restaurantListPhotoUrls removeAllObjects];
                                                      NSUInteger count = 0;
                                                      for (CGRestaurantList *restauantList in self.currentCategory.restaurantLists){
                                                          NSInteger index = MAX(0, count);
                                                          
                                                          [self.restaurantListPhotoUrls insertObject:restauantList.photoURL atIndex:index];
                                                          count++;
                                                      }
                                                      
                                                      [self stopSpinner];
                                                      [self showRestaurantListCategory];
                                                      [self.carousel reloadData];
                                                      [self.carousel scrollToItemAtIndex:0 animated:NO];
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
    }else{
        if (self.showingVotedBy == YES){
            [self.expertNameView removeFromSuperview];
            
            CGRect newFrame = self.restaurant1View.frame;
            newFrame.origin.y -= 20;
            self.restaurant1View.frame = newFrame;
            
            CGRect newFrame2 = self.restaurant2View.frame;
            newFrame2.origin.y -= 20;
            self.restaurant2View.frame = newFrame2;
            
            CGRect newFrame3 = self.restaurant3View.frame;
            newFrame3.origin.y -= 20;
            self.restaurant3View.frame = newFrame3;
            
            CGRect newFrame4 = self.restaurant4View.frame;
            newFrame4.origin.y -= 20;
            self.restaurant4View.frame = newFrame4;
            
            CGRect newFrame5 = self.restaurant5View.frame;
            newFrame5.origin.y -= 20;
            self.restaurant5View.frame = newFrame5;
            
            CGRect newFrame6 = self.footerView.frame;
            newFrame6.origin.y -= 20;
            self.footerView.frame = newFrame6;
            
            self.showingVotedBy = NO;
        }
        
        self.currentCategory = restaurantCategory;
        if (self.currentCategory){
            self.currentRestaurantList = self.currentCategory.restaurantLists[0];
        }
        
        [self.restaurantListPhotoUrls removeAllObjects];
        NSUInteger count = 0;
        for (CGRestaurantList *restauantList in self.currentCategory.restaurantLists){
            NSInteger index = MAX(0, count);
            [self.restaurantListPhotoUrls insertObject:restauantList.photoURL atIndex:index];
            count++;
        }
        
        [self.carousel reloadData];
        [self showRestaurantListCategory];
        [self.carousel scrollToItemAtIndex:0 animated:NO];
    }
}


- (void)locationChanged{
    self.locationChangedFlag = YES;
}

#pragma mark -
#pragma mark iCarousel methods

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    switch (option)
    {
        case iCarouselOptionSpacing:
        {
            return value * 5;
        }
        default:
        {
            return value;
        }
    }
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [self.restaurantListPhotoUrls count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    NSString *photoURL = [self.restaurantListPhotoUrls objectAtIndex:index];
    AsyncImageView *imageView;
    
    if (view == nil)
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 240.0f, 200.0f)];
        view.backgroundColor = [UIColor clearColor];
        
        imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(20, 0, 200.0f, 200.0f)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [view addSubview:imageView];
    }else{
        for (UIView *v in view.subviews) {
            if ([v isKindOfClass:[AsyncImageView class]]){
                imageView = (AsyncImageView *)v;
            }
        }
    }
    
    //cancel any previously loading images for this view
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:imageView];
    
    //set image URL. AsyncImageView class will then dynamically load the image
    imageView.imageURL = [NSURL URLWithString:photoURL];
    
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

-(void) swithLocationChanged{
    self.locationChangedFlag = YES;
    [locationButton setTitle:[CGRestaurantParameter shared].getLocationName forState:UIControlStateNormal];
    
    [self startSpinner];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurantListCategories"
                                           parameters:[[CGRestaurantParameter shared] buildParameterMap]
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  [self stopSpinner];
                                                  
                                                  if (mappingResult){
                                                      self.locationChangedFlag = NO;
                                                      self.restaurantListCategories = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                      
                                                      CGRestaurantListCategory *expertCategory = [[CGRestaurantListCategory alloc] init];
                                                      expertCategory.restaurantListCategoryId = [NSNumber numberWithInt:4];
                                                      expertCategory.name = @"Experts";
                                                      
                                                      [self.restaurantListCategories addObject:expertCategory];
                                                      
                                                      CGRestaurantListCategory *personalCategory = [[CGRestaurantListCategory alloc] init];
                                                      personalCategory.restaurantListCategoryId = [NSNumber numberWithInt:5];
                                                      personalCategory.name = @"Personal";
                                                      
                                                      [self.restaurantListCategories addObject:personalCategory];
                                                      
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
                                                  
                                                  [self stopSpinner];
                                              }];
}

- (void) startSpinner {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading 'Best of' Lists";
    hud.userInteractionEnabled = YES;
}

- (void) stopSpinner {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (IBAction)search:(id)sender {
    [self performSegueWithIdentifier:@"listSearchSegue" sender:self];
}

- (IBAction)locationChange:(id)sender{
    [self performSegueWithIdentifier:@"listLocationSegue" sender:self];
}

@end
