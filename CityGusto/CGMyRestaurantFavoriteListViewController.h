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
@property (strong, nonatomic) IBOutlet UIView *headerView;

@end
