//
//  CGLocalDetailViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 4/26/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGLocalDetailViewController.h"
#import <QuartzCore/QuartzCore.h>

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
    
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.headerView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:158.0f/255.0f green:157.0f/255.0f blue:157.0f/255.0f alpha:1.0f].CGColor, (id)[UIColor colorWithRed:197.0f/255.0f green:196.0f/255.0f blue:196.0f/255.0f alpha:1.0f].CGColor, nil];
    
    [self.headerView.layer insertSublayer:gradient atIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)map:(id)sender {
}

- (IBAction)call:(id)sender {
    NSString *phoneNumber = [@"tel://" stringByAppendingString:self.local.phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

- (IBAction)website:(id)sender {
    NSURL *url = [NSURL URLWithString:self.local.website];
    [[UIApplication sharedApplication] openURL:url];
}
@end
