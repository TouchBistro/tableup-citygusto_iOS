//
//  CGNewRestaurantsListViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 4/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurant.h"
#import <UIKit/UIKit.h>

@interface CGNewRestaurantsListViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *restaurants;
@property (nonatomic, strong) CGRestaurant *selectedRestaurant;

@end
