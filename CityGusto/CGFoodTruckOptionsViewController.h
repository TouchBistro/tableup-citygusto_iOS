//
//  CGFoodTruckOptionsViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 5/22/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//
#import "CGLocationViewController.h"
#import <UIKit/UIKit.h>

@protocol CGFoodTrucksOptionsViewDelegate
- (void) updateFoodTrucks:(NSArray *)newFoodTrucks;
@end

@interface CGFoodTruckOptionsViewController : UIViewController <UIScrollViewDelegate, CGLocationViewDelegate>{
    id <CGFoodTrucksOptionsViewDelegate> delegate;
}

@property (nonatomic, assign) id <CGFoodTrucksOptionsViewDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UILabel *sortLabel;

@property (strong, nonatomic) IBOutlet UISwitch *openSwitch;

@property (strong, nonatomic) IBOutlet UIButton *searchButton;

@property (strong, nonatomic) IBOutlet UIButton *cuisinesButton;
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



@end
