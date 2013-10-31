//
//  CGRestaurantOptionsViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 3/25/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGLocationViewController.h"
#import <UIKit/UIKit.h>

@protocol CGRestaurantOptionsViewDelegate
- (void) updateRestaurants:(NSArray *)newRestaurants;
- (void) updateCuisines:(NSArray *)newCuisines;
- (void) updateFeatures:(NSArray *)newFeatures;
@end

@interface CGRestaurantOptionsViewController : UIViewController <UIScrollViewDelegate, CGLocationViewDelegate>{
    id <CGRestaurantOptionsViewDelegate> delegate;
}

@property (nonatomic, assign) id <CGRestaurantOptionsViewDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UILabel *sortLabel;

@property (strong, nonatomic) IBOutlet UISwitch *deliversSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *kitchenSwitch;

@property (strong, nonatomic) IBOutlet UIButton *searchButton;

@property (strong, nonatomic) IBOutlet UIButton *cuisinesButton;
@property (strong, nonatomic) IBOutlet UIButton *featureButton;
@property (strong, nonatomic) IBOutlet UIButton *clearAllButton;
@property (strong, nonatomic) IBOutlet UIButton *changeSortButton;
@property (strong, nonatomic) IBOutlet UIButton *locationButton;

@property (nonatomic, assign) NSInteger sortIndex;

@property (nonatomic, strong) UIActivityIndicatorView *activityView;

- (IBAction)cancel:(id)sender;
- (IBAction)clearAll:(id)sender;
- (IBAction)search:(id)sender;
- (IBAction)changeSort:(id)sender;
- (IBAction)locationChange:(id)sender;

-(void)locationChanged;
@property (strong, nonatomic) IBOutlet UIScrollView *scroller;
@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;

@end
