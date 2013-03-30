//
//  CGRestaurantParameter.h
//  CityGusto
//
//  Created by Padraic Doyle on 3/25/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGRestaurantParameter : NSObject


@property (nonatomic, strong) NSNumber *max;
@property (nonatomic, strong) NSNumber *offset;

@property (nonatomic, strong) NSNumber *cityId;
@property (nonatomic, strong) NSNumber *neighborhoodId;

@property (nonatomic, strong) NSNumber *lat;
@property (nonatomic, strong) NSNumber *lon;

@property (nonatomic, strong) NSString *sortOrder;

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

- (NSMutableDictionary *) buildParameterMap;

- (void) resetOffsets;
- (void) buildAllCuisines;
- (void) buildAllFeatures;

- (NSString *) getCityName;
- (NSString *) getNeighborhoodName;
- (NSString *) getLocationName;

- (void) changeLocation:(NSNumber *)cityId neighborhoodId:(NSNumber *)neighborhoodId;
- (void) fetchFeatures;


+ (CGRestaurantParameter *)shared;



@end
