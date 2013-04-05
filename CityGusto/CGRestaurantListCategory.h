//
//  CGRestaurantListCategory.h
//  CityGusto
//
//  Created by Padraic Doyle on 4/4/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGRestaurantListCategory : NSObject

@property (nonatomic, strong) NSNumber *restaurantListCategoryId;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *neighborhoodName;

@property (nonatomic, strong) NSMutableArray *restaurantLists;

@end
