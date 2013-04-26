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

-(void)viewDidLayoutSubviews{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.headerView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:137.0f/255.0f green:173.0f/255.0f blue:98.0f/255.0f alpha:1.0f].CGColor, (id)[UIColor colorWithRed:176.0f/255.0f green:200.0f/255.0f blue:150.0f/255.0f alpha:1.0f].CGColor, nil];
    [self.headerView.layer insertSublayer:gradient atIndex:0];
}

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
    
    if (self.restaurant.twitterUserName || self.restaurant.facebookURL || self.restaurant.website){
        
        UIImage *greyImage = [UIImage imageNamed:@"buttonBackgroundGrey.png"];
        UIView *footerView = [[UIView alloc] init];
        
        NSInteger height = 0;
        if (self.restaurant.twitterUserName) {
            height += 50;
        }
        
        if (self.restaurant.facebookURL) {
            height += 50;
        }
        
        if (self.restaurant.website) {
            height += 50;
        }
        
        [footerView setFrame:CGRectMake(0, 0, 320, height)];
        
        if (self.restaurant.twitterUserName){
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button setFrame:CGRectMake(20, 0, 280, 44)];
            
            [button setTitle:@"Twitter" forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
            
            [button addTarget:self action:@selector(viewTwitter:)
             forControlEvents:UIControlEventTouchUpInside];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIBarMetricsDefault];
            [button setBackgroundImage:greyImage forState:UIBarMetricsDefault];
            
            [footerView addSubview:button];
            
        }
        
        if (self.restaurant.facebookURL){
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            if (self.restaurant.twitterUserName){
                [button setFrame:CGRectMake(20, 47, 280, 44)];
            }else{
                [button setFrame:CGRectMake(20, 0, 280, 44)];
            }
            
            
            [button setTitle:@"Facebook" forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
            
            [button addTarget:self action:@selector(viewFacebook:)
             forControlEvents:UIControlEventTouchUpInside];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIBarMetricsDefault];
            [button setBackgroundImage:greyImage forState:UIBarMetricsDefault];
            
            [footerView addSubview:button];
            [self.tableView setTableFooterView:footerView];
        }
        
        if (self.restaurant.website){
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            if (self.restaurant.twitterUserName){
                if (self.restaurant.facebookURL) {
                    [button setFrame:CGRectMake(20, 94, 280, 44)];
                }else{
                    [button setFrame:CGRectMake(20, 47, 280, 44)];
                }
            }else{
                if (self.restaurant.facebookURL) {
                    [button setFrame:CGRectMake(20, 47, 280, 44)];
                }else{
                    [button setFrame:CGRectMake(20, 0, 280, 44)];
                }
            }
            
            [button setFrame:CGRectMake(20, 0, 280, 44)];
            
            [button setTitle:@"Website" forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
            
            [button addTarget:self action:@selector(viewWebsite:)
             forControlEvents:UIControlEventTouchUpInside];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIBarMetricsDefault];
            [button setBackgroundImage:greyImage forState:UIBarMetricsDefault];
            
            [footerView addSubview:button];
            [self.tableView setTableFooterView:footerView];
        }
        
        [self.tableView setTableFooterView:footerView];
        
        
    }
    
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

- (void) viewTwitter:(id)sender{
    NSString *urlString = @"http://twitter.com/";
    urlString = [urlString stringByAppendingString:self.restaurant.twitterUserName];
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

- (void) viewFacebook:(id)sender{
    NSString *urlString = @"http://";
    urlString = [urlString stringByAppendingString:self.restaurant.facebookURL];
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}


- (IBAction)call:(id)sender {
    NSString *phoneNumber = [@"tel://" stringByAppendingString:self.restaurant.phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}
@end
