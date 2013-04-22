//
//  CGEventDetailViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 4/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGEventDetailViewController.h"
#import "CGRestaurantHomeViewController.h"

#import <RestKit/RestKit.h>

@interface CGEventDetailViewController ()

@end

@implementation CGEventDetailViewController

@synthesize event;
@synthesize scroller;
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
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityView.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: self.activityView];
    
    UITapGestureRecognizer *singleFingerTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(handleVenueViewTap:)];
    
    [singleFingerTap1 setCancelsTouchesInView:NO];
    [self.venueView addGestureRecognizer:singleFingerTap1];
    
    self.eventNameLabel.text = self.event.name;
    self.nextDateLabel.text = self.event.dateString;
    self.addressLabel.text = self.event.venueAddress1;
    self.cityLabel.text = self.event.venueCityName;
    self.neighborhoodLabel.text = self.event.venueNeighborhoodName;
    self.venueNameLabel.text = self.event.venueName;
    
    [super viewDidLoad];
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
        [params setObject:self.event.venueId forKey:@"id"];
        
        [self.activityView startAnimating];
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/MattsMenus/mobile/native/restaurants"
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
    }
}

@end
