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
#import "CGRestaurantListViewController.h"
#import "CGSelectRestaurantListViewController.h"
#import <RestKit/RestKit.h>

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

- (void)viewDidLoad
{
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
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
    
    [self.activityView startAnimating];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/MattsMenus/mobile/native/restaurantListCategories"
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
    [super viewDidLoad];
}

-(void) showRestaurantListCategory{
    if (currentCategory){
        self.headerLabel.text = currentCategory.name;
        if (self.currentRestaurantList == nil){
            self.currentRestaurantList = self.currentCategory.restaurantLists[0];
        }
        
        if (currentRestaurantList){
            self.listNameLabel.text = currentRestaurantList.name;
            if (currentRestaurantList.restaurants.count > 0){
                if (currentRestaurantList.restaurants[0]){
                    self.restaurant1 = currentRestaurantList.restaurants[0];
                    NSString *listRestaurantText = @"1) ";
                    listRestaurantText = [listRestaurantText stringByAppendingString:self.restaurant1.name];
                    
                    self.restaurant1Label.text = listRestaurantText;
                }
                
                if (currentRestaurantList.restaurants[1]){
                    self.restaurant2 = currentRestaurantList.restaurants[1];
                    NSString *listRestaurantText = @"2) ";
                    listRestaurantText = [listRestaurantText stringByAppendingString:self.restaurant2.name];
                    
                    self.restaurant2Label.text = listRestaurantText;
                }
                
                if (currentRestaurantList.restaurants[2]){
                    self.restaurant3 = currentRestaurantList.restaurants[2];
                    
                    NSString *listRestaurantText = @"3) ";
                    listRestaurantText = [listRestaurantText stringByAppendingString:self.restaurant3.name];
                    
                    self.restaurant3Label.text = listRestaurantText;
                }
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleRestaurantViewTap:(UITapGestureRecognizer *)recognizer {
    if (recognizer.view == self.restaurant1View){
        selectedRestaurant = self.restaurant1;
    }else if (recognizer.view == self.restaurant2View){
        selectedRestaurant = self.restaurant2;
    }else if (recognizer.view == self.restaurant3View){
        selectedRestaurant = self.restaurant3;
    }
    
    if (selectedRestaurant){
        [self performSegueWithIdentifier:@"listRestaurantDetailSegue" sender:self];
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"listRestaurantDetailSegue"]){
        CGRestaurantHomeViewController *homeController = [segue destinationViewController];
        homeController.restaurant = self.selectedRestaurant;
    }else if ([[segue identifier] isEqualToString:@"restaurantListListSegue"]){
        CGRestaurantListViewController *listViewController = [segue destinationViewController];
        
        NSMutableDictionary *params = [[CGRestaurantParameter shared] buildParameterMap];
        [params setObject:self.currentRestaurantList.restaurantListId forKey:@"listId"];
        
        [self.activityView startAnimating];
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/MattsMenus/mobile/native/restaurants"
                                               parameters:params
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      if (mappingResult){
                                                          
                                                          listViewController.restaurants = [[NSMutableArray alloc] initWithArray:[mappingResult array]];
                                                          [listViewController setDataLoaded:YES];
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


- (void) updateRestaurantList:(CGRestaurantList *) restaurantList{
    self.currentRestaurantList = restaurantList;
    [self showRestaurantListCategory];
}

- (void) updateRestaurantCategory:(CGRestaurantListCategory *) restaurantCategory{
    self.currentCategory = restaurantCategory;
    if (self.currentCategory){
        self.currentRestaurantList = self.currentCategory.restaurantLists[0];
    }
    [self showRestaurantListCategory];
}


- (void)locationChanged{
    [locationButton setTitle:[CGRestaurantParameter shared].getLocationName forState:UIControlStateNormal];
    
    [self.activityView startAnimating];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/MattsMenus/mobile/native/restaurantListCategories"
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
@end
