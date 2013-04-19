//
//  CGMoreViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 4/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGLoginViewController.h"

@interface CGMoreViewController : UITableViewController <CGLoginViewDelegate>

@property (nonatomic, strong) NSMutableArray *restaurants;
@property (nonatomic, strong) NSMutableArray *restaurantFavoriteLists;
@property (strong, nonatomic) UIActivityIndicatorView *activityView;

@end
