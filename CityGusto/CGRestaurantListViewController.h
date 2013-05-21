//
//  CGRestaurantListViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 3/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurant.h"
#import "CGRestaurantOptionsViewController.h"
#import <UIKit/UIKit.h>

@interface CGRestaurantListViewController : UITableViewController <CGRestaurantOptionsViewDelegate>

@property (nonatomic, strong) NSMutableArray *restaurants;
@property (nonatomic, assign, getter=isDataLoaded) BOOL dataLoaded;
@property (nonatomic, assign, getter=isResultsEmpty) BOOL resultsEmpty;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (nonatomic, strong) CGRestaurant *selectedRestaurant;

@property (nonatomic, strong) UIView *footerView;

- (void) viewMorePressed:(id)sender;
@property (strong, nonatomic) IBOutlet UINavigationItem *navBarItem;

@end
