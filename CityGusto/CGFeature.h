//
//  CGFeature.h
//  CityGusto
//
//  Created by Padraic Doyle on 3/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGFeature : NSObject

@property (nonatomic, strong) NSString *featureId;
@property (nonatomic, strong) NSString *name;

-(id) initWithName:(NSString *)name_ featureId:(NSString *) featureId_;

@end
