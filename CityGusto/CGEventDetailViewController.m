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
    self.addressLabel.text = self.event.venueAddress1;
    
    NSString *cityText = self.event.venueCityName;
    cityText = [cityText stringByAppendingString:@", "];
    cityText = [cityText stringByAppendingString:self.event.venueState];
    cityText = [cityText stringByAppendingString:@" "];
    cityText = [cityText stringByAppendingString:self.event.venueZipcode];
    
    self.cityLabel.text = self.event.venueCityName;
    self.neighborhoodLabel.text = self.event.venueNeighborhoodName;
    self.venueNameLabel.text = self.event.venueName;
    
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
    }
}



@end
