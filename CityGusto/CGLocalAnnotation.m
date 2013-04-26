//
//  CGLocalAnnotation.m
//  CityGusto
//
//  Created by Padraic Doyle on 4/26/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGLocalAnnotation.h"

@implementation CGLocalAnnotation

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
