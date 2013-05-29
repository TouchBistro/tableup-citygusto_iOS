//
//  CGEventMapViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 5/8/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//
#import "CGEvent.h"
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

@interface CGEventMapViewController : UIViewController<MKMapViewDelegate>

@property (nonatomic, strong) NSMutableArray *events;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) CGEvent *seletedEvent;

@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@end
