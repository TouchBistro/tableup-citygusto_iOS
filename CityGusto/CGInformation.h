//
//  CGInformation.h
//  CityGusto
//
//  Created by Padraic Doyle on 3/28/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGInformation : NSObject

@property (nonatomic, strong) NSString *header;
@property (nonatomic, strong) NSString *value;

- (id)initWithHeader:(NSString *)header_ value:(NSString *)value_;

@end
