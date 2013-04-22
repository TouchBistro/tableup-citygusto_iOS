//
//  CGRestaurantMapViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 3/25/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurantMapViewController.h"
#import "CGRestaurant.h"
#import "CGRestaurantHomeViewController.h"
#import "CGAnnotation.h"
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#define METERS_PER_MILE 1609.344

@interface CGRestaurantMapViewController ()

@end

@implementation CGRestaurantMapViewController

@synthesize restaurants;
@synthesize mapView;
@synthesize selectedRestaurant;

- (void)viewDidLoad
{
    self.mapView.delegate = self;
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    //boston center
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 42.3583;
    zoomLocation.longitude= -71.0603;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5 * METERS_PER_MILE, 0.5 * METERS_PER_MILE);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    
    [self.mapView setRegion:adjustedRegion animated:YES];
    
    for (CGRestaurant *restaurant in restaurants) {
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[restaurant.latitude doubleValue] longitude:[restaurant.longitude doubleValue]];
        
        CGAnnotation *annotation = [[CGAnnotation alloc] initWithLocation:location.coordinate];
        annotation.title = restaurant.name;
        annotation.restaurant = restaurant;
        [self.mapView addAnnotation:annotation];
    }

}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *mapPin = nil;
    if(annotation != map.userLocation)
    {
        static NSString *defaultPinID = @"defaultPin";
        mapPin = (MKPinAnnotationView *)[map dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if (mapPin == nil )
        {
            mapPin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                     reuseIdentifier:defaultPinID];
            mapPin.canShowCallout = YES;
            
            UIButton *disclosureButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [disclosureButton addTarget:self action:@selector(showRestaurantHome:) forControlEvents:UIControlEventTouchUpInside];
            
            mapPin.rightCalloutAccessoryView = disclosureButton;
            
        }
        else
            mapPin.annotation = annotation;
        
    }
    return mapPin;
}

-(void) showRestaurantHome:(UIButton *) sender {
    CGAnnotation *annotation = [[mapView selectedAnnotations] objectAtIndex:0];
    self.selectedRestaurant = annotation.restaurant;
    [self performSegueWithIdentifier:@"mapHomeSegue" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"mapHomeSegue"]){
        CGRestaurantHomeViewController *homeController = [segue destinationViewController];
        homeController.restaurant = self.selectedRestaurant;
    }
}

@end