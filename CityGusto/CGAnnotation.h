//
//  CGAnnotation.h
//  CityGusto
//
//  Created by Padraic Doyle on 3/27/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurant.h"
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CGAnnotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    NSString * title;
    NSString * subtitle;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) CGRestaurant *restaurant;

- (id)initWithLocation:(CLLocationCoordinate2D)coord;

@end
