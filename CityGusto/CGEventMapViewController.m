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
#import "CGRestaurantParameter.h"
#import "MBProgressHud.h"
#import <RestKit/RestKit.h>

@interface CGEventMapViewController ()

@end

@implementation CGEventMapViewController

@synthesize events;

#define METERS_PER_MILE 1609.344

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
    
    self.navItem.title = [CGRestaurantParameter shared].getLocationName;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {

}

- (void)viewDidAppear:(BOOL)animated {
    for (CGEvent *event in self.events) {
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[event.venueLatitude doubleValue] longitude:[event.venueLongitude doubleValue]];
        
        CGEventAnnotation *annotation = [[CGEventAnnotation alloc] initWithLocation:location.coordinate];
        annotation.title = event.name;
        annotation.event = event;
        [self.mapView addAnnotation:annotation];
    }
    
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in self.mapView.annotations){
        if (![annotation isKindOfClass:[MKUserLocation class]] ) {
            MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
            MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
            zoomRect = MKMapRectUnion(zoomRect, pointRect);
        }
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
    CGEvent *event = annotation.event;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:event.eventId, @"id", nil];
    
    [self startSpinner];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/events"
                                           parameters:params
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if (mappingResult){
                                                      self.seletedEvent = [[mappingResult array] objectAtIndex:0];
                                                      
                                                      [self stopSpinner];
                                                      [self performSegueWithIdentifier:@"mapEventHomeSegue" sender:self];
                                                  }
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                  message:@"There was an issue"
                                                                                                 delegate:nil
                                                                                        cancelButtonTitle:@"OK"
                                                                                        otherButtonTitles:nil];
                                                  [alert show];
                                                  NSLog(@"Hit error: %@", error);
                                              }];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"mapEventHomeSegue"]){
        CGEventDetailViewController *detailController = [segue destinationViewController];
        detailController.event = self.seletedEvent;
    }
}

- (void) startSpinner {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    hud.userInteractionEnabled = YES;
}

- (void) stopSpinner {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)zoomToFitMapAnnotations:(MKMapView*)aMapView
{
    if([aMapView.annotations count] == 0)
        return;
    
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    for(id <MKAnnotation> annotation in self.mapView.annotations)
    {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
        
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
    }
    
    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1; // Add a little extra space on the sides
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1; // Add a little extra space on the sides
    
    region = [aMapView regionThatFits:region];
    [self.mapView setRegion:region animated:YES];
}

@end
