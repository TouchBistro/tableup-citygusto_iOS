//
//  CGRestaurantParameter.h
//  CityGusto
//
//  Created by Padraic Doyle on 3/25/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGUser.h"
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CGRestaurantParameter : NSObject <CLLocationManagerDelegate>


@property (nonatomic, strong) NSNumber *max;
@property (nonatomic, strong) NSNumber *offset;

@property (nonatomic, strong) NSNumber *cityId;
@property (nonatomic, strong) NSNumber *neighborhoodId;

@property (nonatomic, strong) NSNumber *lat;
@property (nonatomic, strong) NSNumber *lon;

@property (nonatomic, strong) NSString *sortOrder;
@property (nonatomic, strong) NSString *eventSortOrder;
@property (nonatomic, strong) NSString *foodTruckSortOrder;
@property (nonatomic, strong) NSString *eventTrendingSortOrder;

@property (nonatomic, assign, getter=isDeliveryFilter) BOOL deliveryFilter;
@property (nonatomic, assign, getter=isKitchenOpenFilter) BOOL kitchenOpenFilter;
@property (nonatomic, assign, getter=isFoodTruckOpenFilter) BOOL foodTruckOpenFilter;

@property (nonatomic, assign, getter=isUsingCurrentLocation) BOOL useCurrentLocation;

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *access_token;

@property (nonatomic, strong) NSMutableArray *cuisines;
@property (nonatomic, strong) NSMutableArray *features;

@property (nonatomic, strong) NSMutableArray *foodTruckCuisines;

//@property (nonatomic, strong) NSMutableArray *allCuisines;
//@property (nonatomic, strong) NSMutableArray *allFeatures;

@property (nonatomic, strong) NSMutableArray *cuisinesForSelectedLocation;
@property (nonatomic, strong) NSMutableArray *featuresForSelectedLocationAndCuisines;

@property (nonatomic, strong) NSMutableArray *foodTruckCuisinesForSelectedLocation;

@property (nonatomic, strong) NSMutableDictionary *cities;
@property (nonatomic, strong) NSMutableDictionary *neighborhoods;

//event specfic
@property (nonatomic, strong) NSMutableArray *times;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSMutableArray *categories;
@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, strong) NSMutableArray *categoriesForSelectedLocation;
@property (nonatomic, strong) NSMutableArray *tagsForSelectedLocationAndCategories;

@property (nonatomic, strong) NSNumber *eventOffset;
@property (nonatomic, strong) NSNumber *eventTrendingOffset;
@property (nonatomic, strong) NSNumber *foodTruckOffset;

@property (nonatomic, strong) CGUser *loggedInUser;

- (NSMutableDictionary *) buildParameterMap;
- (NSMutableDictionary *) buildEventParameterMap;
- (NSMutableDictionary *) buildFoodTruckParameterMap;
- (NSMutableDictionary *) buildEventTrendingParameterMap;

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

-(void) getCurrentLocation;

+ (CGRestaurantParameter *)shared;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (assign, nonatomic) BOOL locationLoad;

@end
