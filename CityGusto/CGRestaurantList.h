//
//  CGRestaurantList.h
//  CityGusto
//
//  Created by Padraic Doyle on 4/4/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGRestaurantList : NSObject


@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *cityUrlId;
@property (nonatomic, strong) NSString *neighborhoodUrlId;

@property (nonatomic, strong) NSNumber *restaurantListId;

@property (nonatomic, strong) NSString *photoURL;

@property (nonatomic, strong) NSMutableArray *restaurants;

@end
