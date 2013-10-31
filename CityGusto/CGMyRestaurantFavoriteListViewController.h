//
//  CGMyRestaurantFavoriteListViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 4/19/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGMyRestaurantFavoriteListViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *restaurantFavoriteLists;
@property (strong, nonatomic) NSMutableArray *restaurants;

@property (strong, nonatomic) UIActivityIndicatorView *activityView;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;

@end
