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
#import "CGLocalDetailViewController.h"
#import <RestKit/RestKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>

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
    
    UITapGestureRecognizer *singleFingerTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(handleVenueViewTap:)];
    
    UITapGestureRecognizer *singleFingerTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(handleVenueViewWebsiteTap:)];
    
    [singleFingerTap1 setCancelsTouchesInView:NO];
    [self.venueView addGestureRecognizer:singleFingerTap1];
    
    [singleFingerTap2 setCancelsTouchesInView:NO];
    [self.venueWebsiteView addGestureRecognizer:singleFingerTap2];
    
    self.eventNameLabel.text = self.event.name;
    self.nextDateLabel.text = self.event.nextOccurrenceDate;
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
    
    //calculate the footer height
    //once we find a null website name then we stop calculating
    NSInteger height = 0;
    if (self.event.eventWebsiteName1) {
        height += 50;
        if (self.event.eventWebsiteName2) {
            height += 50;
            if (self.event.eventWebsiteName3) {
                height += 50;
                if (self.event.eventWebsiteName4) {
                    height += 50;
                    if (self.event.eventWebsiteName5) {
                        height += 50;
                        if (self.event.eventWebsiteName6) {
                            height += 50;
                            if (self.event.eventWebsiteName7) {
                                height += 50;
                                if (self.event.eventWebsiteName8) {
                                    height += 50;
                                    if (self.event.eventWebsiteName9) {
                                        height += 50;
                                        if (self.event.eventWebsiteName10) {
                                            height += 50;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    UIView *footerView = [[UIView alloc] init];
    [footerView setFrame:CGRectMake(0, 0, 320, height)];
    
    
    if (self.event.eventWebsiteName1) {
        UIImage *greyImage = [UIImage imageNamed:@"buttonBackgroundGrey.png"];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setFrame:CGRectMake(20, 0, 280, 44)];
        
        [button setTitle:self.event.eventWebsiteDescription1 forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        
        [button addTarget:self action:@selector(viewEventWebsite1:)
         forControlEvents:UIControlEventTouchUpInside];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIBarMetricsDefault];
        [button setBackgroundImage:greyImage forState:UIBarMetricsDefault];
        
        [footerView addSubview:button];
        
        if (self.event.eventWebsiteName2) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button setFrame:CGRectMake(20, 0, 280, 44)];
            
            [button setTitle:self.event.eventWebsiteDescription2 forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
            
            [button addTarget:self action:@selector(viewEventWebsite2:)
             forControlEvents:UIControlEventTouchUpInside];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIBarMetricsDefault];
            [button setBackgroundImage:greyImage forState:UIBarMetricsDefault];
            
            [footerView addSubview:button];
            
            if (self.event.eventWebsiteName3) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                [button setFrame:CGRectMake(20, 0, 280, 44)];
                
                [button setTitle:self.event.eventWebsiteDescription3 forState:UIControlStateNormal];
                [button.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
                
                [button addTarget:self action:@selector(viewEventWebsite3:)
                 forControlEvents:UIControlEventTouchUpInside];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIBarMetricsDefault];
                [button setBackgroundImage:greyImage forState:UIBarMetricsDefault];
                
                [footerView addSubview:button];
                
                if (self.event.eventWebsiteName4) {
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    [button setFrame:CGRectMake(20, 0, 280, 44)];
                    
                    [button setTitle:self.event.eventWebsiteDescription4 forState:UIControlStateNormal];
                    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
                    
                    [button addTarget:self action:@selector(viewEventWebsite4:)
                     forControlEvents:UIControlEventTouchUpInside];
                    
                    [button setTitleColor:[UIColor whiteColor] forState:UIBarMetricsDefault];
                    [button setBackgroundImage:greyImage forState:UIBarMetricsDefault];
                    
                    [footerView addSubview:button];
                    
                    if (self.event.eventWebsiteName5) {
                        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                        [button setFrame:CGRectMake(20, 0, 280, 44)];
                        
                        [button setTitle:self.event.eventWebsiteDescription5 forState:UIControlStateNormal];
                        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
                        
                        [button addTarget:self action:@selector(viewEventWebsite5:)
                         forControlEvents:UIControlEventTouchUpInside];
                        
                        [button setTitleColor:[UIColor whiteColor] forState:UIBarMetricsDefault];
                        [button setBackgroundImage:greyImage forState:UIBarMetricsDefault];
                        
                        [footerView addSubview:button];
                        
                        if (self.event.eventWebsiteName6) {
                            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                            [button setFrame:CGRectMake(20, 0, 280, 44)];
                            
                            [button setTitle:self.event.eventWebsiteDescription6 forState:UIControlStateNormal];
                            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
                            
                            [button addTarget:self action:@selector(viewEventWebsite6:)
                             forControlEvents:UIControlEventTouchUpInside];
                            
                            [button setTitleColor:[UIColor whiteColor] forState:UIBarMetricsDefault];
                            [button setBackgroundImage:greyImage forState:UIBarMetricsDefault];
                            
                            [footerView addSubview:button];
                            
                            if (self.event.eventWebsiteName7) {
                                UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                                [button setFrame:CGRectMake(20, 0, 280, 44)];
                                
                                [button setTitle:self.event.eventWebsiteDescription7 forState:UIControlStateNormal];
                                [button.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
                                
                                [button addTarget:self action:@selector(viewEventWebsite7:)
                                 forControlEvents:UIControlEventTouchUpInside];
                                
                                [button setTitleColor:[UIColor whiteColor] forState:UIBarMetricsDefault];
                                [button setBackgroundImage:greyImage forState:UIBarMetricsDefault];
                                
                                [footerView addSubview:button];
                                
                                if (self.event.eventWebsiteName8) {
                                    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                                    [button setFrame:CGRectMake(20, 0, 280, 44)];
                                    
                                    [button setTitle:self.event.eventWebsiteDescription8 forState:UIControlStateNormal];
                                    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
                                    
                                    [button addTarget:self action:@selector(viewEventWebsite8:)
                                     forControlEvents:UIControlEventTouchUpInside];
                                    
                                    [button setTitleColor:[UIColor whiteColor] forState:UIBarMetricsDefault];
                                    [button setBackgroundImage:greyImage forState:UIBarMetricsDefault];
                                    
                                    [footerView addSubview:button];
                                    
                                    if (self.event.eventWebsiteName9) {
                                        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                                        [button setFrame:CGRectMake(20, 0, 280, 44)];
                                        
                                        [button setTitle:self.event.eventWebsiteDescription9 forState:UIControlStateNormal];
                                        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
                                        
                                        [button addTarget:self action:@selector(viewEventWebsite9:)
                                         forControlEvents:UIControlEventTouchUpInside];
                                        
                                        [button setTitleColor:[UIColor whiteColor] forState:UIBarMetricsDefault];
                                        [button setBackgroundImage:greyImage forState:UIBarMetricsDefault];
                                        
                                        [footerView addSubview:button];
                                        
                                        if (self.event.eventWebsiteName10) {
                                            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                                            [button setFrame:CGRectMake(20, 0, 280, 44)];
                                            
                                            [button setTitle:self.event.eventWebsiteDescription10 forState:UIControlStateNormal];
                                            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
                                            
                                            [button addTarget:self action:@selector(viewEventWebsite10:)
                                             forControlEvents:UIControlEventTouchUpInside];
                                            
                                            [button setTitleColor:[UIColor whiteColor] forState:UIBarMetricsDefault];
                                            [button setBackgroundImage:greyImage forState:UIBarMetricsDefault];
                                            
                                            [footerView addSubview:button];
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    [self.tableView setTableFooterView:footerView];
    
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

- (IBAction)viewVenueWebsite:(id)sender {
    NSString *urlString = @"http://";
    urlString = [urlString stringByAppendingString:self.event.eventVenueWebsite];
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)map:(id)sender{
    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([self.event.venueLatitude doubleValue], [self.event.venueLongitude doubleValue]);
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                       addressDictionary:nil];
        
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        [mapItem setName:self.restaurant.name];
        // Pass the map item to the Maps app
        [mapItem openInMapsWithLaunchOptions:nil];
    }
}

- (IBAction)call:(id)sender {
    NSString *phoneNumber = [@"tel://" stringByAppendingString:self.event.eventVenuePhoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

- (void)handleVenueViewWebsiteTap:(UITapGestureRecognizer *)recognizer {
    if (recognizer.view == self.venueWebsiteView){
        NSURL *url = [NSURL URLWithString:self.event.eventVenueWebsite];
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)handleVenueViewTap:(UITapGestureRecognizer *)recognizer {
    if (recognizer.view == self.venueView){
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:self.event.eventVenueId forKey:@"id"];
        
        if ([self.event.eventVenueType isEqualToString:@"local"]){
            [self startSpinner];
            [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/locals"
                                                   parameters:params
                                                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                          if (mappingResult){
                                                              self.local = [[mappingResult array] objectAtIndex:0];
                                                          }
                                                          
                                                          [self stopSpinner];
                                                          [self performSegueWithIdentifier:@"eventLocalDetailSegue" sender:self];
                                                      }
                                                      failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                          message:@"There was an issue"
                                                                                                         delegate:nil
                                                                                                cancelButtonTitle:@"OK"
                                                                                                otherButtonTitles:nil];
                                                          [alert show];
                                                          NSLog(@"Hit error: %@", error);
                                                          [self stopSpinner];
                                                      }];
        }else{
            [self startSpinner];
            [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurants"
                                                   parameters:params
                                                      success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                          if (mappingResult){
                                                              self.restaurant = [[mappingResult array] objectAtIndex:0];
                                                          }
                                                          
                                                          [self stopSpinner];
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
                                                          [self stopSpinner];
                                                      }];
            
        }
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"eventToRestaurantSegue"]){
        CGRestaurantHomeViewController *homeController = [segue destinationViewController];
        homeController.restaurant = self.restaurant;
    }else if ([[segue identifier] isEqualToString:@"eventMoreInformationSegue"]){
        CGEventMoreInformationViewController *moreInformationController = [segue destinationViewController];
        moreInformationController.selectedEvent = self.event;
    }else if ([[segue identifier] isEqualToString:@"eventLocalDetailSegue"]){
        CGLocalDetailViewController *localDetailViewController = [segue destinationViewController];
        localDetailViewController.local = self.local;
    }
}

- (void) startSpinner {
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.center = CGPointMake(self.tableView.frame.size.width / 2.0, self.tableView.frame.size.height / 2.0);
    [self.tableView addSubview: activityView];
    
    [self.activityView startAnimating];
}

- (void) stopSpinner {
    [self.activityView stopAnimating];
    [self.activityView removeFromSuperview];
}

- (void) viewEventWebsite1:(id)sender{
    NSString *urlString = @"http://";
    urlString = [urlString stringByAppendingString:self.event.eventWebsiteName1];
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

- (void) viewEventWebsite2:(id)sender{
    NSString *urlString = @"http://";
    urlString = [urlString stringByAppendingString:self.event.eventWebsiteName2];
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

- (void) viewEventWebsite3:(id)sender{
    NSString *urlString = @"http://";
    urlString = [urlString stringByAppendingString:self.event.eventWebsiteName3];
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

- (void) viewEventWebsite4:(id)sender{
    NSString *urlString = @"http://";
    urlString = [urlString stringByAppendingString:self.event.eventWebsiteName4];
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

- (void) viewEventWebsite5:(id)sender{
    NSString *urlString = @"http://";
    urlString = [urlString stringByAppendingString:self.event.eventWebsiteName5];
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

- (void) viewEventWebsite6:(id)sender{
    NSString *urlString = @"http://";
    urlString = [urlString stringByAppendingString:self.event.eventWebsiteName6];
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

- (void) viewEventWebsite7:(id)sender{
    NSString *urlString = @"http://";
    urlString = [urlString stringByAppendingString:self.event.eventWebsiteName7];
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

- (void) viewEventWebsite8:(id)sender{
    NSString *urlString = @"http://";
    urlString = [urlString stringByAppendingString:self.event.eventWebsiteName8];
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

- (void) viewEventWebsite9:(id)sender{
    NSString *urlString = @"http://";
    urlString = [urlString stringByAppendingString:self.event.eventWebsiteName9];
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

- (void) viewEventWebsite10:(id)sender{
    NSString *urlString = @"http://";
    urlString = [urlString stringByAppendingString:self.event.eventWebsiteName10];
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

@end
