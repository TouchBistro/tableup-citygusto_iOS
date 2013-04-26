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
    
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.headerView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:137.0f/255.0f green:173.0f/255.0f blue:98.0f/255.0f alpha:1.0f].CGColor, (id)[UIColor colorWithRed:176.0f/255.0f green:200.0f/255.0f blue:150.0f/255.0f alpha:1.0f].CGColor, nil];
    
    [self.headerView.layer insertSublayer:gradient atIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)map:(id)sender {
}

- (IBAction)call:(id)sender {
}

- (IBAction)website:(id)sender {
}
@end
