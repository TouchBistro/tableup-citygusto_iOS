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
#import "CGEventDetailViewController.h"
#import "CGEventMapViewController.h"

@interface CGEventMapViewController ()

@end

@implementation CGEventMapViewController

@synthesize events;

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
        static NSString *defaultPinID = @"defaultEventPin";
        mapPin = (MKPinAnnotationView *)[map dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if (mapPin == nil )
        {
            mapPin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                     reuseIdentifier:defaultPinID];
            mapPin.canShowCallout = YES;
            
            UIButton *disclosureButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [disclosureButton addTarget:self action:@selector(showEventHome:) forControlEvents:UIControlEventTouchUpInside];
            
            mapPin.rightCalloutAccessoryView = disclosureButton;
            
        }
        else
            mapPin.annotation = annotation;
        
    }
    return mapPin;
}

-(void) showEventHome:(UIButton *) sender {
    CGEventAnnotation *annotation = [[self.mapView selectedAnnotations] objectAtIndex:0];
    self.seletedEvent = annotation.event;
    [self performSegueWithIdentifier:@"mapEventHomeSegue" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"mapEventHomeSegue"]){
        CGEventDetailViewController *detailController = [segue destinationViewController];
        detailController.event = self.seletedEvent;
    }
}

@end
