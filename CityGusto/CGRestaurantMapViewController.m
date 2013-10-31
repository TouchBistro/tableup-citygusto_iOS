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
#import "CGRestaurantParameter.h"
#import "CGAnnotation.h"
#import "MBProgressHud.h"
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <RestKit/RestKit.h>

#define METERS_PER_MILE 1609.344

@interface CGRestaurantMapViewController ()

@end

@implementation CGRestaurantMapViewController

@synthesize restaurants;
@synthesize mapView;
@synthesize selectedRestaurant;

-(id)init {
    if (self = [super init])  {
        self.showPosition = NO;
        self.showFoodTrucks = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    self.mapView.delegate = self;
    self.navItem.title = [CGRestaurantParameter shared].getLocationName;
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
}

- (void)viewDidAppear:(BOOL)animated {
    NSInteger index = 0;
    for (CGRestaurant *restaurant in restaurants) {
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[restaurant.latitude doubleValue] longitude:[restaurant.longitude doubleValue]];
        
        CGAnnotation *annotation = [[CGAnnotation alloc] initWithLocation:location.coordinate];
        
        if (self.showPosition){
            NSString *title = [NSString stringWithFormat:@"#)%1$d %2$@", index + 1, restaurant.name];
            annotation.title = title;
        }else{
            annotation.title = restaurant.name;
        }
        
        annotation.restaurant = restaurant;
        
        [self.mapView addAnnotation:annotation];
        
        index++;
    }
    
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in mapView.annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    [mapView setVisibleMapRect:zoomRect animated:YES];
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
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.selectedRestaurant.restaurantId, @"id", nil];
    
    if (self.showFoodTrucks){
        [self startSpinner];
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/foodtrucks"
                                               parameters:params
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      if (mappingResult){
                                                          self.selectedRestaurant = [[mappingResult array] objectAtIndex:0];
                                                          
                                                          [self stopSpinner];
                                                          [self performSegueWithIdentifier:@"mapHomeSegue" sender:self];
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
        
    }else{
        [self startSpinner];
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/mobile/native/restaurants"
                                               parameters:params
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      if (mappingResult){
                                                          self.selectedRestaurant = [[mappingResult array] objectAtIndex:0];
                                                          
                                                          [self stopSpinner];
                                                          [self performSegueWithIdentifier:@"mapHomeSegue" sender:self];
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
    
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"mapHomeSegue"]){
        CGRestaurantHomeViewController *homeController = [segue destinationViewController];
        homeController.restaurant = self.selectedRestaurant;
    }
}

- (void) startSpinner {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading Restaurants & Bars";
    hud.userInteractionEnabled = YES;
}

- (void) stopSpinner {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
