//
//  CGTopListPosition.h
//  CityGusto
//
//  Created by Padraic Doyle on 3/28/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGTopListPosition : NSObject

@property (nonatomic, strong) NSString *listName;
@property (nonatomic, strong) NSString *neighborhoodName;
@property (nonatomic, strong) NSString *cityName;

@property (nonatomic, strong) NSNumber *listId;
@property (nonatomic, strong) NSNumber *position;

@end
