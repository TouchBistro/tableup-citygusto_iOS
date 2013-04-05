//
//  CGRestaurantListListViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 4/5/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurantList.h"
#import "CGRestaurant.h"
#import <UIKit/UIKit.h>

@interface CGRestaurantListListViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *restaurants;
@property (nonatomic, assign, getter=isDataLoaded) BOOL dataLoaded;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (nonatomic, strong) CGRestaurantList *restaurantList;
@property (nonatomic, strong) CGRestaurant *selectedRestaurant;

@end
