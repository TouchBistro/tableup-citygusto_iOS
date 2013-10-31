//
//  CGRestaurantListViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 3/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurant.h"
#import "CGRestaurantOptionsViewController.h"
#import "MHLazyTableImages.h"
#import <UIKit/UIKit.h>

@interface CGRestaurantListViewController : UITableViewController <CGRestaurantOptionsViewDelegate, MHLazyTableImagesDelegate, UIScrollViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *restaurants;
@property (nonatomic, assign, getter=isDataLoaded) BOOL dataLoaded;

@property (nonatomic, assign, getter=isResultsEmpty) BOOL resultsEmpty;
@property (strong, nonatomic) UIView *noResultsView;

@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (nonatomic, strong) CGRestaurant *selectedRestaurant;

@property (nonatomic, strong) UIView *footerView;

- (void) viewMorePressed:(id)sender;
@property (strong, nonatomic) IBOutlet UINavigationItem *navBarItem;


@property (nonatomic, assign) BOOL locationChanged;

@property (nonatomic, strong) NSString *term;
@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;

@end
