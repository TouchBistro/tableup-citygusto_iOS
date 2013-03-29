//
//  CGRestaurantHomeViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 3/28/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//
#import "CGRestaurantReviewSiteViewController.h"
#import "CGRestaurantHomeViewController.h"
#import "CGRestaurantMenuViewController.h"
#import "CGRestaurantTopListViewController.h"
#import "CGMoreInformationViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface CGRestaurantHomeViewController ()

@end

@implementation CGRestaurantHomeViewController

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

- (void)viewDidLoad
{
    nameLabel.text = self.restaurant.name;
    numberOfLikesLabel.text = [self.restaurant.numberOfLikes stringValue];
    numberOfDislikesLabel.text = [self.restaurant.numberOfDislikes stringValue];
    
    
    NSString *topFive = @"Current Top 5 in ";
    if (self.restaurant.numberOfTopFiveLists){
        topFive = [topFive stringByAppendingString:[self.restaurant.numberOfTopFiveLists stringValue]];
        topFive = [topFive stringByAppendingString:@" Lists"];
    }else{
        topFive = [topFive stringByAppendingString:@"0 Lists"];
    }
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"menusSegue"]){
        CGRestaurantMenuViewController *menuController = [segue destinationViewController];
        menuController.selectedRestaurant = self.restaurant;
    }else if ([[segue identifier] isEqualToString:@"reviewSiteSegue"]){
        CGRestaurantReviewSiteViewController *reviewSiteController = [segue destinationViewController];
        reviewSiteController.selectedRestaurant = self.restaurant;
    }else if ([[segue identifier] isEqualToString:@"topListSegue"]){
        CGRestaurantTopListViewController *topListController = [segue destinationViewController];
        topListController.selectedRestaurant = self.restaurant;
    }else if ([[segue identifier] isEqualToString:@"moreInfoSegue"]){
        CGMoreInformationViewController *moreInfoController = [segue destinationViewController];
        moreInfoController.selectedRestaurant = self.restaurant;
    }
}

- (IBAction)call:(id)sender {
}
@end
