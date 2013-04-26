//
//  CGEventDetailViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 4/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurant.h"
#import "CGEvent.h"
#import "CGLocal.h"
#import <UIKit/UIKit.h>

@interface CGEventDetailViewController : UITableViewController

@property (nonatomic, strong) CGEvent *event;
@property (nonatomic, strong) CGRestaurant *restaurant;
@property (nonatomic, strong) CGLocal *local;

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
@property (strong, nonatomic) IBOutlet UIView *callView;

@property (strong, nonatomic) IBOutlet UILabel *likeLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberOfLikesLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberOfDislikesLabel;
@property (strong, nonatomic) IBOutlet UIView *ratingsView;
@property (strong, nonatomic) IBOutlet UILabel *topFiveLabel;
@property (strong, nonatomic) IBOutlet UIView *topFiveView;

@property (strong, nonatomic) IBOutlet UIImageView *starImageView;
@property (strong, nonatomic) IBOutlet UILabel *ratingLabel;

@property (strong, nonatomic) IBOutlet UIView *likeView;
@property (strong, nonatomic) IBOutlet UIView *venueWebsiteView;

- (IBAction)map:(id)sender;
- (IBAction)call:(id)sender;

@end
