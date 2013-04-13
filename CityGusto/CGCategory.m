//
//  CGCategory.m
//  CityGusto
//
//  Created by Padraic Doyle on 4/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGCategory.h"

@implementation CGCategory

-(id) initWithName:(NSString *)name_ categoryId:(NSString *)categoryId_
{
    self = [super init];
    
    if (self){
        self.name = name_;
        self.categoryId = categoryId_;
        
    }
    
    return self;
}

@end
