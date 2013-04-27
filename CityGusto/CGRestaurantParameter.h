//
//  CGRestaurantParameter.h
//  CityGusto
//
//  Created by Padraic Doyle on 3/25/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGUser.h"
#import <Foundation/Foundation.h>

@interface CGRestaurantParameter : NSObject


@property (nonatomic, strong) NSNumber *max;
@property (nonatomic, strong) NSNumber *offset;

@property (nonatomic, strong) NSNumber *cityId;
@property (nonatomic, strong) NSNumber *neighborhoodId;

@property (nonatomic, strong) NSNumber *lat;
@property (nonatomic, strong) NSNumber *lon;

@property (nonatomic, strong) NSString *sortOrder;
@property (nonatomic, strong) NSString *eventSortOrder;

@property (nonatomic, assign, getter=isDeliveryFilter) BOOL deliveryFilter;
@property (nonatomic, assign, getter=isKitchenOpenFilter) BOOL kitchenOpenFilter;

@property (nonatomic, assign, getter=isUsingCurrentLocation) BOOL useCurrentLocation;

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *access_token;

@property (nonatomic, strong) NSMutableArray *cuisines;
@property (nonatomic, strong) NSMutableArray *features;

//@property (nonatomic, strong) NSMutableArray *allCuisines;
//@property (nonatomic, strong) NSMutableArray *allFeatures;

@property (nonatomic, strong) NSMutableArray *cuisinesForSelectedLocation;
@property (nonatomic, strong) NSMutableArray *featuresForSelectedLocationAndCuisines;

@property (nonatomic, strong) NSMutableDictionary *cities;
@property (nonatomic, strong) NSMutableDictionary *neighborhoods;

//event specfic
@property (nonatomic, strong) NSMutableArray *times;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSMutableArray *categories;
@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, strong) NSMutableArray *categoriesForSelectedLocation;
@property (nonatomic, strong) NSMutableArray *tagsForSelectedLocationAndCategories;

@property (nonatomic, strong) CGUser *loggedInUser;

- (NSMutableDictionary *) buildParameterMap;
- (NSMutableDictionary *) buildEventParameterMap;

- (void) resetOffsets;
- (void) buildAllCuisines;
- (void) buildAllFeatures;

- (NSString *) getCityName;
- (NSString *) getNeighborhoodName;
- (NSString *) getLocationName;

//- (void) changeLocation:(NSNumber *)cityId neighborhoodId:(NSNumber *)neighborhoodId;
- (void) changeLocation;

- (void) fetchFeatures;
- (void) fetchTags;

+ (CGRestaurantParameter *)shared;


@end
