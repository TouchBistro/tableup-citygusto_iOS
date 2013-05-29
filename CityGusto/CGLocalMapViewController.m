//
//  CGLocalMapViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 4/26/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGLocalMapViewController.h"
#import "CGLocalAnnotation.h"
#import <MapKit/MapKit.h>

#define METERS_PER_MILE 1609.344

@interface CGLocalMapViewController ()

@end

@implementation CGLocalMapViewController

- (void)viewWillAppear:(BOOL)animated {
}

- (void)viewDidAppear:(BOOL)animated {
    //boston center
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 42.3583;
    zoomLocation.longitude= -71.0603;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5 * METERS_PER_MILE, 0.5 * METERS_PER_MILE);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    
    [self.mapView setRegion:adjustedRegion animated:YES];
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[self.local.latitude doubleValue] longitude:[self.local.longitude doubleValue]];
    
    CGLocalAnnotation *annotation = [[CGLocalAnnotation alloc] initWithLocation:location.coordinate];
    annotation.title = self.local.name;
    annotation.local = self.local;
    [self.mapView addAnnotation:annotation];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
