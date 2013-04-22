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
#import "CGRestaurantMapViewController.h"
#import "CGRestaurantPhotoViewController.h"
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
    
    [ratingsView.layer setCornerRadius:5.0f];
    [ratingsView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [ratingsView.layer setBorderWidth:0.5f];
    
    self.addressLabel.text = self.restaurant.address1;
    NSString *cityText = self.restaurant.cityName;
    cityText = [cityText stringByAppendingString:@", "];
    cityText = [cityText stringByAppendingString:self.restaurant.state];
    cityText = [cityText stringByAppendingString:@" "];
    cityText = [cityText stringByAppendingString:self.restaurant.zipcode];
    self.cityLabel.text = cityText;
    
    NSString *numberOfRatings = [self.restaurant.numberOfRatings stringValue];
    numberOfRatings = [numberOfRatings stringByAppendingString:@" Ratings"];
    self.ratingLabel.text = numberOfRatings;
    
    if (self.restaurant.numberOfStars == [NSNumber numberWithInt:1]) {
        [self.starImageView setImage:[UIImage imageNamed:@"stars_1.png"]];
    }else if (self.restaurant.numberOfStars == [NSNumber numberWithInt:2]) {
        [self.starImageView setImage:[UIImage imageNamed:@"stars_2.png"]];
    }else if (self.restaurant.numberOfStars == [NSNumber numberWithInt:3]) {
        [self.starImageView setImage:[UIImage imageNamed:@"stars_3.png"]];
    }else if (self.restaurant.numberOfStars == [NSNumber numberWithInt:4]) {
        [self.starImageView setImage:[UIImage imageNamed:@"stars_4.png"]];
    }else if (self.restaurant.numberOfStars == [NSNumber numberWithInt:5]) {
        [self.starImageView setImage:[UIImage imageNamed:@"stars_5.png"]];
    }else{
        [self.starImageView setImage:[UIImage imageNamed:@"stars_0.png"]];
    }
    
    self.headerView.opaque = NO;
    self.headerView.backgroundColor = [UIColor clearColor];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.headerView.bounds;
//    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:137.0f/255.0f green:173.0f/255.0f blue:98.0f/255.0f alpha:1.0f].CGColor, (id)[UIColor colorWithRed:176.0f/255.0f green:200.0f/255.0f blue:150.0f/255.0f alpha:1.0f].CGColor, nil];
    
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    
    [self.headerView.layer insertSublayer:gradient atIndex:0];
    
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
    }else if ([[segue identifier] isEqualToString:@"mapFromHomeSegue"]){
        CGRestaurantMapViewController *mapController = [segue destinationViewController];
        
        NSMutableArray *restaurants = [[NSMutableArray alloc]initWithObjects:self.restaurant, nil];
        [mapController.restaurants removeAllObjects];
        mapController.restaurants = restaurants;
    }else if ([[segue identifier] isEqualToString:@"restaurantPhotosSegue"]){
        CGRestaurantPhotoViewController *photoController = [segue destinationViewController];
        photoController.photos = self.restaurant.photos;
    }
}

- (IBAction)call:(id)sender {
}
@end
