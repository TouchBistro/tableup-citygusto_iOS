//
//  CGLocalAnnotation.h
//  CityGusto
//
//  Created by Padraic Doyle on 4/26/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGLocal.h"
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CGLocalAnnotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    NSString * title;
    NSString * subtitle;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) CGLocal *local;

- (id)initWithLocation:(CLLocationCoordinate2D)coord;

@end
