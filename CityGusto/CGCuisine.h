//
//  CGCuisine.h
//  CityGusto
//
//  Created by Padraic Doyle on 3/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGCuisine : NSObject

@property (nonatomic, strong) NSString *cuisineId;
@property (nonatomic, strong) NSString *name;


-(id) initWithName:(NSString *)name_ cuisineId:(NSString *) cuisineId_;

@end
