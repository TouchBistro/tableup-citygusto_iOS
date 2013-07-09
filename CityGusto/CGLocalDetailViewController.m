//
//  CGLocalDetailViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 4/26/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGLocalDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>

@interface CGLocalDetailViewController ()

@end

@implementation CGLocalDetailViewController

- (void)viewDidLoad
{
    self.headerLabel.text = self.local.name;
    
    NSString *cityText = self.local.cityName;
    cityText = [cityText stringByAppendingString:@", "];
    cityText = [cityText stringByAppendingString:self.local.state];
    cityText = [cityText stringByAppendingString:@" "];
    cityText = [cityText stringByAppendingString:self.local.zipcode];
    self.cityLabel.text = cityText;
    
    self.address1.text = self.local.address1;
    self.neighborhoodLabel.text = self.local.neighborhoodName;
    
    NSURL *url = [NSURL URLWithString:self.local.primaryPhotoURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    self.imageView.image = image;
    
    [self.imageView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.imageView.layer setBorderWidth:1.5f];
    [self.imageView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.imageView.layer setShadowOpacity:0.8];
    [self.imageView.layer setShadowRadius:3.0];
    [self.imageView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    if (self.local.twitterUserName || self.local.facebookURL || self.local.website){
        
        UIImage *blueImage = [UIImage imageNamed:@"buttonBackgroundBlue.png"];
        UIView *footerView = [[UIView alloc] init];
        
        NSInteger height = 0;
        if (self.local.twitterUserName) {
            height += 50;
        }
        
        if (self.local.facebookURL) {
            height += 50;
        }
        
        if (self.local.website) {
            height += 50;
        }
        
        [footerView setFrame:CGRectMake(0, 187, 320, height)];
        
        if (self.local.twitterUserName && [self.local.twitterUserName length] > 0){
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button setFrame:CGRectMake(20, 0, 280, 44)];
            
            [button setTitle:@"Twitter" forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
            
            [button addTarget:self action:@selector(viewTwitter:)
             forControlEvents:UIControlEventTouchUpInside];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIBarMetricsDefault];
            [button setBackgroundImage:blueImage forState:UIBarMetricsDefault];
            
            [footerView addSubview:button];
            
        }
        
        if (self.local.facebookURL && [self.local.facebookURL length] > 0){
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            if (self.local.twitterUserName){
                [button setFrame:CGRectMake(20, 47, 280, 44)];
            }else{
                [button setFrame:CGRectMake(20, 0, 280, 44)];
            }
            
            
            [button setTitle:@"Facebook" forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
            
            [button addTarget:self action:@selector(viewFacebook:)
             forControlEvents:UIControlEventTouchUpInside];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIBarMetricsDefault];
            [button setBackgroundImage:blueImage forState:UIBarMetricsDefault];
            
            [footerView addSubview:button];
        }
        
        if (self.local.website && [self.local.website length] > 0){
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            if (self.local.twitterUserName){
                if (self.local.facebookURL) {
                    [button setFrame:CGRectMake(20, 94, 280, 44)];
                }else{
                    [button setFrame:CGRectMake(20, 47, 280, 44)];
                }
            }else{
                if (self.local.facebookURL) {
                    [button setFrame:CGRectMake(20, 47, 280, 44)];
                }else{
                    [button setFrame:CGRectMake(20, 0, 280, 44)];
                }
            }
            
            [button setTitle:@"Website" forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
            
            [button addTarget:self action:@selector(viewWebsite:)
             forControlEvents:UIControlEventTouchUpInside];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIBarMetricsDefault];
            [button setBackgroundImage:blueImage forState:UIBarMetricsDefault];
            
            [footerView addSubview:button];
        }
        
        [self.view addSubview:footerView];
        
        
    }
    
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.headerView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:173.0f/255.0f green:98.0f/255.0f blue:137.0f/255.0f alpha:1.0f].CGColor, (id)[UIColor colorWithRed:200.0f/255.0f green:150.0f/255.0f blue:176.0f/255.0f alpha:1.0f].CGColor, nil];
    
    [self.headerView.layer insertSublayer:gradient atIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)map:(id)sender{
    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        // Create an MKMapItem to pass to the Maps app
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([self.local.latitude doubleValue], [self.local.longitude doubleValue]);
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                       addressDictionary:nil];
        
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        [mapItem setName:self.local.name];
        // Pass the map item to the Maps app
        [mapItem openInMapsWithLaunchOptions:nil];
    }
}

- (IBAction)call:(id)sender {
    NSString *phoneNumber = [@"tel://" stringByAppendingString:self.local.phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

- (IBAction)website:(id)sender {
    NSURL *url = [NSURL URLWithString:self.local.website];
    [[UIApplication sharedApplication] openURL:url];
}

- (void) viewTwitter:(id)sender{
    NSString *urlString = @"http://twitter.com/";
    urlString = [urlString stringByAppendingString:self.local.twitterUserName];
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

- (void) viewFacebook:(id)sender{
    NSString *urlString = @"http://";
    urlString = [urlString stringByAppendingString:self.local.facebookURL];
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

- (void) viewWebsite:(id)sender{
    NSString *urlString = @"http://";
    urlString = [urlString stringByAppendingString:self.local.website];
    
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

@end
