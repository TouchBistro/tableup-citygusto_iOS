//
//  CGEventDetailViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 4/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurant.h"
#import "CGEvent.h"
#import <UIKit/UIKit.h>

@interface CGEventDetailViewController : UITableViewController

@property (nonatomic, strong) CGEvent *event;
@property (nonatomic, strong) CGRestaurant *restaurant;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UILabel *eventNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *venueNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *nextDateLabel;

@property (strong, nonatomic) IBOutlet UIView *venueView;
@property (strong, nonatomic) IBOutlet UIView *dateView;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *neighborhoodLabel;

@property (strong, nonatomic) UIActivityIndicatorView *activityView;

- (IBAction)map:(id)sender;
- (IBAction)call:(id)sender;

@end
