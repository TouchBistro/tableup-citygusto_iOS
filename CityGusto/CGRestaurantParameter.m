//
//  CGRestaurantParameter.m
//  CityGusto
//
//  Created by Padraic Doyle on 3/25/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGCuisine.h"
#import "CGFeature.h"
#import "CGRestaurantParameter.h"
#import "CGCategory.h"
#import "CGTag.h"
#import <RestKit/RestKit.h>

@implementation CGRestaurantParameter

@synthesize max;
@synthesize offset;
@synthesize cityId;
@synthesize neighborhoodId;


@synthesize lat;
@synthesize lon;

@synthesize sortOrder;
@synthesize deliveryFilter;
@synthesize kitchenOpenFilter;

@synthesize username;
@synthesize access_token;

@synthesize cuisines;
@synthesize features;

@synthesize categories;
@synthesize tags;

@synthesize times;

//@synthesize allCuisines;
@synthesize cities;
@synthesize neighborhoods;

@synthesize cuisinesForSelectedLocation;
@synthesize featuresForSelectedLocationAndCuisines;

@synthesize categoriesForSelectedLocation;
@synthesize tagsForSelectedLocationAndCategories;

@synthesize date;
@synthesize eventSortOrder;

@synthesize loggedInUser;


+ (CGRestaurantParameter *)shared {
    static dispatch_once_t pred = 0;
    __strong static CGRestaurantParameter * _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
        
        _sharedObject.cuisines = [[NSMutableArray alloc] init];
        _sharedObject.features = [[NSMutableArray alloc] init];
        
        _sharedObject.categories = [[NSMutableArray alloc] init];
        _sharedObject.tags = [[NSMutableArray alloc] init];
        
        _sharedObject.categories = [[NSMutableArray alloc] init];
        _sharedObject.tags = [[NSMutableArray alloc] init];
        
        _sharedObject.times = [[NSMutableArray alloc] init];
        
        _sharedObject.cities = [[NSMutableDictionary alloc] init];
        _sharedObject.neighborhoods = [[NSMutableDictionary alloc] init];
        
        _sharedObject.cuisinesForSelectedLocation = [[NSMutableArray alloc] init];
        _sharedObject.featuresForSelectedLocationAndCuisines = [[NSMutableArray alloc] init];
        
        _sharedObject.categoriesForSelectedLocation = [[NSMutableArray alloc] init];
        _sharedObject.tagsForSelectedLocationAndCategories = [[NSMutableArray alloc] init];
        
        [_sharedObject.cities setObject:@"Somerville" forKey:@"1"];
        [_sharedObject.cities setObject:@"Brookline" forKey:@"2"];
        [_sharedObject.cities setObject:@"Cambridge" forKey:@"3"];
        [_sharedObject.cities setObject:@"Boston" forKey:@"4"];
        
        [_sharedObject.neighborhoods setObject:@"Kendall Square/MIT" forKey:@"1"];
        [_sharedObject.neighborhoods setObject:@"East Cambridge" forKey:@"2"];
        [_sharedObject.neighborhoods setObject:@"Central Square" forKey:@"3"];
        [_sharedObject.neighborhoods setObject:@"Inman Square" forKey:@"4"];
        [_sharedObject.neighborhoods setObject:@"Harvard Square" forKey:@"5"];
        [_sharedObject.neighborhoods setObject:@"Porter Square" forKey:@"6"];
        [_sharedObject.neighborhoods setObject:@"Huron Village" forKey:@"7"];
        [_sharedObject.neighborhoods setObject:@"North Cambridge" forKey:@"8"];
        [_sharedObject.neighborhoods setObject:@"Allston" forKey:@"9"];
        [_sharedObject.neighborhoods setObject:@"Brighton" forKey:@"10"];
        [_sharedObject.neighborhoods setObject:@"South End" forKey:@"11"];
        [_sharedObject.neighborhoods setObject:@"South Boston" forKey:@"12"];
        [_sharedObject.neighborhoods setObject:@"Fenway/Kenmore" forKey:@"13"];
        [_sharedObject.neighborhoods setObject:@"Chinatown" forKey:@"14"];
        [_sharedObject.neighborhoods setObject:@"Downtown" forKey:@"15"];
        [_sharedObject.neighborhoods setObject:@"Back Bay" forKey:@"16"];
        [_sharedObject.neighborhoods setObject:@"Beacon Hill" forKey:@"17"];
        [_sharedObject.neighborhoods setObject:@"North End" forKey:@"18"];
        [_sharedObject.neighborhoods setObject:@"Charlestown" forKey:@"19"];
        [_sharedObject.neighborhoods setObject:@"East Boston" forKey:@"20"];
        
    });
    
    return _sharedObject;
}

- (void) resetOffsets{
    self.offset = 0;
}

- (NSMutableDictionary *) buildParameterMap{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:cityId forKey:@"cityId"];
    
    if (neighborhoodId){
        [params setObject:neighborhoodId forKey:@"neighborhoodId"];
    }
    
    if (max){
        [params setObject:max forKey:@"max"];
    }else{
        [params setObject:@"25" forKey:@"max"];
    }
    
    if (offset){
        [params setObject:offset forKey:@"offset"];
    }else{
        [params setObject:@"0" forKey:@"offset"];
    }
    
    if (cuisines.count > 0){
        NSString *cuisineString = [[NSString alloc] init];
        
        for (CGCuisine *cuisine in cuisines) {
            cuisineString = [cuisineString stringByAppendingString:cuisine.cuisineId];
            cuisineString = [cuisineString stringByAppendingString:@","];
        }
        
        [params setObject:cuisineString forKey:@"cuisines"];
    }
    
    if (features.count > 0){
        NSString *featureString = [[NSString alloc] init];
        
        for (CGFeature *feature in features) {
            featureString = [featureString stringByAppendingString:feature.featureId];
            featureString = [featureString stringByAppendingString:@","];
        }
        
        [params setObject:featureString forKey:@"features"];
    }
    
    if (deliveryFilter == YES){
        [params setObject:@"true" forKey:@"deliveryFilter"];
        
    }else{
        [params setObject:@"false" forKey:@"deliveryFilter"];
    }
    
    if (kitchenOpenFilter == YES){
        [params setObject:@"true" forKey:@"kitchenOpenFilter"];
        
    }else{
        [params setObject:@"false" forKey:@"kitchenOpenFilter"];
    }
    
    if (sortOrder){
        [params setObject:sortOrder forKey:@"sortOrder"];
    }
    
    if (lat){
        [params setObject:lat forKey:@"lat"];
    }
    
    if (lon){
        [params setObject:lon forKey:@"lon"];
    }
    
    
    [params setObject:cityId forKey:@"cityId"];
    
    return params;
}

- (NSMutableDictionary *) buildEventParameterMap{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:cityId forKey:@"cityId"];
    
    if (neighborhoodId){
        [params setObject:neighborhoodId forKey:@"neighborhoodId"];
    }
    
    if (max){
        [params setObject:max forKey:@"max"];
    }else{
        [params setObject:@"25" forKey:@"max"];
    }
    
    if (offset){
        [params setObject:offset forKey:@"offset"];
    }else{
        [params setObject:@"0" forKey:@"offset"];
    }
    
    if (categories.count > 0){
        NSString *categoryString = [[NSString alloc] init];
        
        for (CGCategory *category in categories) {	
            categoryString = [categoryString stringByAppendingString:category.categoryId];
            categoryString = [categoryString stringByAppendingString:@","];
        }
        
        [params setObject:categoryString forKey:@"chosen_categories"];
    }
    
    if (features.count > 0){
        NSString *tagString = [[NSString alloc] init];
        
        for (CGTag *tag in tags) {
            tagString = [tagString stringByAppendingString:tag.tagId];
            tagString = [tagString stringByAppendingString:@","];
        }
        
        [params setObject:tagString forKey:@"chosen_tags"];
    }
    
    if (eventSortOrder){
        [params setObject:eventSortOrder forKey:@"sortOrder"];
    }
    
    if (lat){
        [params setObject:lat forKey:@"lat"];
    }
    
    if (lon){
        [params setObject:lon forKey:@"long"];
    }
    
    if (date){
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        
        NSString *dateString = [dateFormatter stringFromDate:date];
        NSLog(@"%@",dateString);
        
        [params setObject:dateString forKey:@"date"];
    }
    
    [params setObject:times forKey:@"time"];
    
    return params;
}

- (NSString *) getCityName{
    return [self.cities objectForKey:[self.cityId stringValue]];
}

- (NSString *) getNeighborhoodName{
    return self.neighborhoodId ? [self.neighborhoods objectForKey:[self.neighborhoodId stringValue]] : nil;
}

- (NSString *) getLocationName{
    NSString *locationName;
    if (self.isUsingCurrentLocation){
        locationName = @"Current Location";
    }else{
        locationName = self.getCityName;
        if (self.getNeighborhoodName){
            locationName = [locationName stringByAppendingString:@" - "];
            locationName = [locationName stringByAppendingString:self.getNeighborhoodName];
        }
    }
    
    return locationName;
}

- (void) changeLocation:(NSNumber *)cityId_ neighborhoodId:(NSNumber *)neighborhoodId_{
    if (cityId_){
        self.cityId = cityId_;
    }
    
    if (neighborhoodId_){
        self.neighborhoodId = neighborhoodId_;
    }
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/MattsMenus/mobile/native/cuisines"
                                           parameters:[[CGRestaurantParameter shared] buildParameterMap]
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if (mappingResult){
                                                      [self.cuisinesForSelectedLocation removeAllObjects];
                                                      [self.featuresForSelectedLocationAndCuisines removeAllObjects];
                                                      
                                                      [self.cuisinesForSelectedLocation addObjectsFromArray:[[mappingResult dictionary] objectForKey:@"cuisines"]];
                                                      [self.featuresForSelectedLocationAndCuisines addObjectsFromArray:[[mappingResult dictionary] objectForKey:@"features"]];
                                                  }
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                  message:@"There was an issue"
                                                                                                 delegate:nil
                                                                                        cancelButtonTitle:@"OK"
                                                                                        otherButtonTitles:nil];
                                                  [alert show];
                                                  NSLog(@"Hit error: %@", error);
                                              }];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/MattsMenus/mobile/native/categories"
                                           parameters:[[CGRestaurantParameter shared] buildEventParameterMap]
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if (mappingResult){
                                                      [self.categoriesForSelectedLocation removeAllObjects];
                                                      [self.tagsForSelectedLocationAndCategories removeAllObjects];
                                                      
                                                      [self.categoriesForSelectedLocation addObjectsFromArray:[[mappingResult dictionary] objectForKey:@"categories"]];
                                                      [self.tagsForSelectedLocationAndCategories addObjectsFromArray:[[mappingResult dictionary] objectForKey:@"tags"]];
                                                  }
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                  message:@"There was an issue"
                                                                                                 delegate:nil
                                                                                        cancelButtonTitle:@"OK"
                                                                                        otherButtonTitles:nil];
                                                  [alert show];
                                                  NSLog(@"Hit error: %@", error);
                                              }];
    
}

- (void) fetchFeatures{
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/MattsMenus/mobile/native/features"
                                           parameters:[[CGRestaurantParameter shared] buildParameterMap]
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if (mappingResult){
                                                      [self.featuresForSelectedLocationAndCuisines removeAllObjects];
                                                      [self.featuresForSelectedLocationAndCuisines addObjectsFromArray:[[mappingResult dictionary] objectForKey:@"features"]];
                                                  }
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                  message:@"There was an issue"
                                                                                                 delegate:nil
                                                                                        cancelButtonTitle:@"OK"
                                                                                        otherButtonTitles:nil];
                                                  [alert show];
                                                  NSLog(@"Hit error: %@", error);
                                              }];
    
}

- (void) fetchTags{
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/MattsMenus/mobile/native/tags"
                                           parameters:[[CGRestaurantParameter shared] buildEventParameterMap]
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if (mappingResult){
                                                      [self.tagsForSelectedLocationAndCategories removeAllObjects];
                                                      [self.tagsForSelectedLocationAndCategories addObjectsFromArray:[[mappingResult dictionary] objectForKey:@"tags"]];
                                                  }
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                  message:@"There was an issue"
                                                                                                 delegate:nil
                                                                                        cancelButtonTitle:@"OK"
                                                                                        otherButtonTitles:nil];
                                                  [alert show];
                                                  NSLog(@"Hit error: %@", error);
                                              }];
    
}

@end
