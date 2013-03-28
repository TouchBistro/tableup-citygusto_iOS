//
//  CGCuisine.m
//  CityGusto
//
//  Created by Padraic Doyle on 3/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGCuisine.h"

@implementation CGCuisine

-(id) initWithName:(NSString *)name_ cuisineId:(NSString *) cuisineId_
{
    self = [super init];
    
    if (self){
        self.name = name_;
        self.cuisineId = cuisineId_;
        
    }
    
    return self;
}

@end
