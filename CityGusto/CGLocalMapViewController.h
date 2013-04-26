//
//  CGLocalMapViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 4/26/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGLocal.h"
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CGLocalMapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) CGLocal *local;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
