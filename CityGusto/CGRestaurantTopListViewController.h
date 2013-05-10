//
//  CGRestaurantTopListViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 3/28/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurant.h"
#import "CGTopListPosition.h"
#import <UIKit/UIKit.h>

@interface CGRestaurantTopListViewController : UITableViewController

@property (nonatomic, strong) CGRestaurant *selectedRestaurant;
@property (nonatomic, strong) CGTopListPosition *selectedTopList;

@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (nonatomic, strong) NSMutableArray *restaurants;

@end
