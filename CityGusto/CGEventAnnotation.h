//
//  CGEventAnnotation.h
//  CityGusto
//
//  Created by Padraic Doyle on 5/8/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGEvent.h"
#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>

@interface CGEventAnnotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    NSString * title;
    NSString * subtitle;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) CGEvent *event;

- (id)initWithLocation:(CLLocationCoordinate2D)coord;

@end
