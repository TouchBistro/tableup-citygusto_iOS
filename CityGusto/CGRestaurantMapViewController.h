//
//  CGRestaurantMapViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 3/25/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurant.h"
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CGRestaurantMapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) NSMutableArray *restaurants;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) CGRestaurant *selectedRestaurant;

@property (assign, nonatomic) BOOL showPosition;

- (IBAction)cancel:(id)sender;


@end
