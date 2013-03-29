//
//  CGInformation.m
//  CityGusto
//
//  Created by Padraic Doyle on 3/28/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGInformation.h"

@implementation CGInformation

- (id)initWithHeader:(NSString *)header_ value:(NSString *)value_
{
    self = [super init];
    if (self)
    {
        self.header = header_;
        self.value = value_;
    }
    return self;
}

@end
