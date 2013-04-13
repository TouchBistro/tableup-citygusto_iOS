//
//  CGTag.m
//  CityGusto
//
//  Created by Padraic Doyle on 4/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGTag.h"

@implementation CGTag

-(id) initWithName:(NSString *)name_ tagId:(NSString *)tagId_
{
    self = [super init];
    
    if (self){
        self.name = name_;
        self.tagId = tagId_;
        
    }
    
    return self;
}

@end
