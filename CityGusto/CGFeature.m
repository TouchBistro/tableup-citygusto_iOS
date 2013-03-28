//
//  CGFeature.m
//  CityGusto
//
//  Created by Padraic Doyle on 3/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGFeature.h"

@implementation CGFeature

-(id) initWithName:(NSString *)name_ featureId:(NSString *) featureId_
{
    self = [super init];
    
    if (self){
        self.name = name_;
        self.featureId = featureId_;
    }
    
    return self;
}

@end
