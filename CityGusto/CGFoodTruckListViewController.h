//
//  CGFoodTruckListViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 5/22/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGFoodTruckOptionsViewController.h"
#import "MHLazyTableImages.h"
#import "CGRestaurant.h"
#import <UIKit/UIKit.h>

@interface CGFoodTruckListViewController : UITableViewController <CGFoodTrucksOptionsViewDelegate, MHLazyTableImagesDelegate, UIScrollViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *foodTrucks;

@property (nonatomic, assign, getter=isDataLoaded) BOOL dataLoaded;

@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (nonatomic, strong) CGRestaurant *selectedFoodTruck;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *mapHeaderButton;

@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, assign, getter=isResultsEmpty) BOOL resultsEmpty;
@property (strong, nonatomic) UIView *noResultsView;

@property (assign, nonatomic) BOOL locationChanged;

- (void) viewMorePressed:(id)sender;


@property (nonatomic, strong) NSString *term;

@end
