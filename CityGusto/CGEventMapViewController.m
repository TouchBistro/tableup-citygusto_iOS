//
//  CGEventMapViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 5/8/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGEvent.h"
#import "CGAnnotation.h"
#import "CGEventAnnotation.h"
#import "CGEventMapViewController.h"

@interface CGEventMapViewController ()

@end

@implementation CGEventMapViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    for (CGEvent *event in self.events) {
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[event.venueLatitude doubleValue] longitude:[event.venueLongitude doubleValue]];
        
        CGEventAnnotation *annotation = [[CGEventAnnotation alloc] initWithLocation:location.coordinate];
        annotation.title = event.name;
        annotation.event = event;
        [self.mapView addAnnotation:annotation];
    }
    
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in self.mapView.annotations){
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    [self.mapView setVisibleMapRect:zoomRect animated:YES];
    
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
    CGEventAnnotation *annotation = [[self.mapView selectedAnnotations] objectAtIndex:0];
    self.seletedEvent = annotation.event;
    [self performSegueWithIdentifier:@"mapEventHomeSegue" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"mapEventHomeSegue"]){
//        CGRestaurantHomeViewController *homeController = [segue destinationViewController];
//        homeController.restaurant = self.selectedRestaurant;
    }
}

@end
