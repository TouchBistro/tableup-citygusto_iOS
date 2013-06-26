//
//  CGListUser.h
//  CityGusto
//
//  Created by Padraic Doyle on 6/26/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGListUser : NSObject

@property (nonatomic, strong) NSNumber *userId;

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *firstname;
@property (nonatomic, strong) NSString *lastname;

@end
