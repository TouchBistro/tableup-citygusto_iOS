//
//  CGRestaurantListFavoriteViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 5/21/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurant.h"
#import "MHLazyTableImages.h"
#import <UIKit/UIKit.h>

@interface CGRestaurantListFavoriteViewController : UITableViewController <MHLazyTableImagesDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *restaurants;

@property (nonatomic, assign, getter=isDataLoaded) BOOL dataLoaded;

@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (nonatomic, strong) CGRestaurant *selectedRestaurant;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *mapHeaderButton;

@end
