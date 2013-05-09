//
//  CGEventAnnotation.m
//  CityGusto
//
//  Created by Padraic Doyle on 5/8/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGEventAnnotation.h"

@implementation CGEventAnnotation

@synthesize coordinate;
@synthesize title;

- (id)initWithLocation:(CLLocationCoordinate2D)coord {
    self = [super init];
    if (self) {
        coordinate = coord;
    }
    return self;
}

@end
