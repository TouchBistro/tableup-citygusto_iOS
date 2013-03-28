//
//  CGRestaurantDetailViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 3/25/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurantDetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface CGRestaurantDetailViewController ()

@end

@implementation CGRestaurantDetailViewController

@synthesize scrollView;

@synthesize nameLabel;
@synthesize likeLabel;
@synthesize numberOfLikesLabel;
@synthesize numberOfDislikesLabel;
@synthesize topFiveLabel;

@synthesize headerView;
@synthesize informationSectionView;
@synthesize ratingsView;
@synthesize topFiveView;
@synthesize infoView;

@synthesize restaurant;

- (void)viewDidLoad
{
    nameLabel.text = self.restaurant.name;
    numberOfLikesLabel.text = [self.restaurant.numberOfLikes stringValue];
    numberOfDislikesLabel.text = [self.restaurant.numberOfDislikes stringValue];
    
    
    NSString *topFive = @"Current Top 5 in ";
    topFive = [topFive stringByAppendingString:[self.restaurant.numberOfTopFiveLists stringValue]];
    topFive = [topFive stringByAppendingString:@" Lists"];
    topFiveLabel.text = topFive;
    
    [topFiveView.layer setCornerRadius:5.0f];
    [topFiveView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [topFiveView.layer setBorderWidth:0.5f];
    
    self.addressLabel.text = self.restaurant.address1;
    NSString *cityText = self.restaurant.cityName;
    cityText = [cityText stringByAppendingString:@", "];
    cityText = [cityText stringByAppendingString:self.restaurant.state];
    cityText = [cityText stringByAppendingString:@" "];
    cityText = [cityText stringByAppendingString:self.restaurant.zipcode];
    self.cityLabel.text = cityText;
    
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    self.scrollView.delegate = self;
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:CGSizeMake(320, 1000)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)map:(id)sender {
}
@end
