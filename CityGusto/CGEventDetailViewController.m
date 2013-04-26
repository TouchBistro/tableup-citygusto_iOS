//
//  CGEventDetailViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 4/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGEventDetailViewController.h"
#import "CGRestaurantHomeViewController.h"
#import "CGEventMoreInformationViewController.h"
#import <RestKit/RestKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CGEventDetailViewController ()

@end

@implementation CGEventDetailViewController

@synthesize event;
@synthesize headerView;
@synthesize eventNameLabel;

@synthesize venueNameLabel;
@synthesize nextDateLabel;

@synthesize venueView;
@synthesize dateView;
@synthesize addressLabel;
@synthesize cityLabel;
@synthesize neighborhoodLabel;

@synthesize activityView;

- (void)viewDidLoad
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        UIImage *navBarImg = [UIImage imageNamed:@"appHeader.png"];
        [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
        
    }
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: self.activityView];
    
    UITapGestureRecognizer *singleFingerTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(handleVenueViewTap:)];
    
    [singleFingerTap1 setCancelsTouchesInView:NO];
    [self.venueView addGestureRecognizer:singleFingerTap1];
    
    self.eventNameLabel.text = self.event.name;
    self.nextDateLabel.text = self.event.dateString;
    self.addressLabel.text = self.event.eventVenueAddress;
    
    NSString *cityText = self.event.eventVenueCityName;
    cityText = [cityText stringByAppendingString:@", "];
    cityText = [cityText stringByAppendingString:self.event.eventVenueState];
    cityText = [cityText stringByAppendingString:@" "];
    cityText = [cityText stringByAppendingString:self.event.eventVenueZipcode];
    
    self.cityLabel.text = cityText;
    self.neighborhoodLabel.text = self.event.eventVenueNeighborhoodName;
    self.venueNameLabel.text = self.event.eventVenueName;
    
    self.numberOfLikesLabel.text = [self.event.numberOfLikes stringValue];
    self.numberOfDislikesLabel.text = [self.event.numberOfDislikes stringValue];
    
    [self.ratingsView.layer setCornerRadius:5.0f];
    [self.ratingsView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.ratingsView.layer setBorderWidth:0.5f];
    
    NSString *numberOfRatings = [self.event.numberOfRatings stringValue];
    numberOfRatings = [numberOfRatings stringByAppendingString:@" Ratings"];
    self.ratingLabel.text = numberOfRatings;
    
    if (self.event.numberOfStars == [NSNumber numberWithInt:1]) {
        [self.starImageView setImage:[UIImage imageNamed:@"stars_1.png"]];
    }else if (self.event.numberOfStars == [NSNumber numberWithInt:2]) {
        [self.starImageView setImage:[UIImage imageNamed:@"stars_2.png"]];
    }else if (self.event.numberOfStars == [NSNumber numberWithInt:3]) {
        [self.starImageView setImage:[UIImage imageNamed:@"stars_3.png"]];
    }else if (self.event.numberOfStars == [NSNumber numberWithInt:4]) {
        [self.starImageView setImage:[UIImage imageNamed:@"stars_4.png"]];
    }else if (self.event.numberOfStars == [NSNumber numberWithInt:5]) {
        [self.starImageView setImage:[UIImage imageNamed:@"stars_5.png"]];
    }else{
        [self.starImageView setImage:[UIImage imageNamed:@"stars_0.png"]];
    }
    
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.headerView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:137.0f/255.0f green:173.0f/255.0f blue:98.0f/255.0f alpha:1.0f].CGColor, (id)[UIColor colorWithRed:176.0f/255.0f green:200.0f/255.0f blue:150.0f/255.0f alpha:1.0f].CGColor, nil];
    
    [self.headerView.layer insertSublayer:gradient atIndex:0];
    
    CALayer *bottomBorder = [CALayer layer];
    
    bottomBorder.frame = CGRectMake(0.0f, self.venueView.frame.size.height - 1, self.venueView.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f].CGColor;
    
    [self.venueView.layer addSublayer:bottomBorder];
    
    CALayer *bottomDateBorder = [CALayer layer];
    
    bottomDateBorder.frame = CGRectMake(0.0f, self.dateView.frame.size.height - 1, self.dateView.frame.size.width, 1.0f);
    bottomDateBorder.backgroundColor = [UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f].CGColor;
    
    [self.dateView.layer addSublayer:bottomDateBorder];
    
    CALayer *bottomCallBorder = [CALayer layer];
    
    bottomCallBorder.frame = CGRectMake(0.0f, self.callView.frame.size.height - 1, self.callView.frame.size.width, 1.0f);
    bottomCallBorder.backgroundColor = [UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f].CGColor;
    
    [self.callView.layer addSublayer:bottomCallBorder];
    
    CALayer *bottomLikeBorder = [CALayer layer];
    
    bottomLikeBorder.frame = CGRectMake(0.0f, self.likeView.frame.size.height - 1, self.likeView.frame.size.width, 1.0f);
    bottomLikeBorder.backgroundColor = [UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f].CGColor;
    
    [self.likeView.layer addSublayer:bottomLikeBorder];
    
    CALayer *bottomVenueWebsiteBorder = [CALayer layer];
    
    bottomVenueWebsiteBorder.frame = CGRectMake(0.0f, self.venueWebsiteView.frame.size.height - 1, self.venueWebsiteView.frame.size.width, 1.0f);
    bottomVenueWebsiteBorder.backgroundColor = [UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f blue:221.0f/255.0f alpha:1.0f].CGColor;
    
    [self.venueWebsiteView.layer addSublayer:bottomVenueWebsiteBorder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)map:(id)sender {
}

- (IBAction)call:(id)sender {
}

- (void)handleVenueViewTap:(UITapGestureRecognizer *)recognizer {
    if (recognizer.view == self.venueView){
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:self.event.eventVenueId forKey:@"id"];
        
        [self.activityView startAnimating];
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurants"
                                               parameters:params
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      if (mappingResult){
                                                          self.restaurant = [[mappingResult array] objectAtIndex:0];
                                                      }
                                                      
                                                      [self.activityView stopAnimating];
                                                      [self performSegueWithIdentifier:@"eventToRestaurantSegue" sender:self];
                                                  }
                                                  failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                      message:@"There was an issue"
                                                                                                     delegate:nil
                                                                                            cancelButtonTitle:@"OK"
                                                                                            otherButtonTitles:nil];
                                                      [alert show];
                                                      NSLog(@"Hit error: %@", error);
                                                      [self.activityView stopAnimating];
                                                  }];
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"eventToRestaurantSegue"]){
        CGRestaurantHomeViewController *homeController = [segue destinationViewController];
        homeController.restaurant = self.restaurant;
    }else if ([[segue identifier] isEqualToString:@"eventMoreInformationSegue"]){
        CGEventMoreInformationViewController *moreInformationController = [segue destinationViewController];
        moreInformationController.selectedEvent = self.event;
    }
}



@end
