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

@synthesize allCuisines;
@synthesize cities;
@synthesize neighborhoods;


+ (CGRestaurantParameter *)shared {
    static dispatch_once_t pred = 0;
    __strong static CGRestaurantParameter * _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
        
        _sharedObject.allCuisines = [[NSMutableArray alloc] init];
        _sharedObject.allFeatures = [[NSMutableArray alloc] init];
        
        _sharedObject.cuisines = [[NSMutableArray alloc] init];
        _sharedObject.features = [[NSMutableArray alloc] init];
        
        _sharedObject.cities = [[NSMutableDictionary alloc] init];
        _sharedObject.neighborhoods = [[NSMutableDictionary alloc] init];
        
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

- (void) buildAllCuisines{
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Afghani" cuisineId:@"3"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"African" cuisineId:@"4"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Albanian" cuisineId:@"5"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"American New" cuisineId:@"6"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"American Traditional" cuisineId:@"7"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Asian" cuisineId:@"8"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Australian" cuisineId:@"9"]];
    
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Bagels/Donuts" cuisineId:@"10"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Bakery" cuisineId:@"11"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Bangladeshi" cuisineId:@"12"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Bar Bites" cuisineId:@"13"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Bar Food" cuisineId:@"14"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Barbecue" cuisineId:@"15"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Belgian" cuisineId:@"133"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Bengali" cuisineId:@"16"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Bolivian" cuisineId:@"142"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Brazilian" cuisineId:@"17"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Breakfast" cuisineId:@"18"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Brunch" cuisineId:@"19"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Bubble Tea" cuisineId:@"20"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Burgers" cuisineId:@"21"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Burmese" cuisineId:@"22"]];
    
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Cajun" cuisineId:@"23"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Calzones" cuisineId:@"24"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Cambodian" cuisineId:@"25"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Cantonese" cuisineId:@"134"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Caribbean" cuisineId:@"26"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Charcuterie" cuisineId:@"136"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Chicken Fingers" cuisineId:@"140"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Chilean" cuisineId:@"27"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Chinese" cuisineId:@"28"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Coffee/Tea" cuisineId:@"29"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Colombian" cuisineId:@"30"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Comfort Food" cuisineId:@"31"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Continental" cuisineId:@"32"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Creole" cuisineId:@"33"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Crepes" cuisineId:@"34"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Cuban" cuisineId:@"35"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Cupcakes" cuisineId:@"36"]];
    
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Delicatessen" cuisineId:@"37"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Desserts" cuisineId:@"38"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Dim Sum" cuisineId:@"39"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Drinks Only" cuisineId:@"40"]];
    
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Eastern European" cuisineId:@"41"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Eclectic" cuisineId:@"42"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Egyptian" cuisineId:@"43"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"English" cuisineId:@"44"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Ethiopian" cuisineId:@"45"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"European" cuisineId:@"46"]];
    
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Fast Food" cuisineId:@"47"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Flatbread Pizza" cuisineId:@"48"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Fondue" cuisineId:@"49"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"French" cuisineId:@"50"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Fried Chicken" cuisineId:@"51"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Frozen Yogurt" cuisineId:@"52"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Fusion" cuisineId:@"53"]];
    
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Gastropub" cuisineId:@"54"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Gelato" cuisineId:@"55"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"German" cuisineId:@"56"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Greek" cuisineId:@"57"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Guatemalan" cuisineId:@"58"]];
    
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Haitian" cuisineId:@"59"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Himalayan" cuisineId:@"60"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Hot Dogs" cuisineId:@"61"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Hot Pot" cuisineId:@"62"]];
    
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Ice Cream" cuisineId:@"63"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Indian" cuisineId:@"64"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Indonesian" cuisineId:@"65"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"International" cuisineId:@"66"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Irish" cuisineId:@"67"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Israeli" cuisineId:@"68"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Italian" cuisineId:@"69"]];
    
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Japanese" cuisineId:@"70"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Jewish" cuisineId:@"71"]];
    
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Korean" cuisineId:@"72"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Kosher" cuisineId:@"73"]];
    
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Latin American" cuisineId:@"74"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Lebanese" cuisineId:@"75"]];
    
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Malaysian" cuisineId:@"76"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Mandarin" cuisineId:@"77"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Mediterranean" cuisineId:@"78"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Mexican" cuisineId:@"79"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Middle Eastern" cuisineId:@"80"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Modern European" cuisineId:@"81"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Moroccan" cuisineId:@"82"]];
    
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Nepalese" cuisineId:@"83"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"New England" cuisineId:@"84"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"North African" cuisineId:@"85"]];
    
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Pakistani" cuisineId:@"86"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Pan-Asian" cuisineId:@"87"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Paninis" cuisineId:@"88"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Pasta" cuisineId:@"89"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Persian" cuisineId:@"90"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Peruvian" cuisineId:@"91"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Pickles" cuisineId:@"139"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Pizza" cuisineId:@"92"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Polish" cuisineId:@"93"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Polynesian" cuisineId:@"94"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Portuguese" cuisineId:@"95"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Pot Pies" cuisineId:@"96"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Pub Fare" cuisineId:@"97"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Puerto Rican" cuisineId:@"141"]];
    
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Roast Beef" cuisineId:@"99"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Roll Ups" cuisineId:@"99"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Rotisserie" cuisineId:@"138"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Rotisserie" cuisineId:@"100"]];
    
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Salads" cuisineId:@"101"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Salvadorian" cuisineId:@"102"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Sandwiches" cuisineId:@"103"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Sardinian" cuisineId:@"104"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Seafood" cuisineId:@"105"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Shabu Shabu" cuisineId:@"106"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Sichuan" cuisineId:@"107"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Small Plates" cuisineId:@"108"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Smoothies/Juice Bar" cuisineId:@"109"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Soups" cuisineId:@"110"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"South American" cuisineId:@"111"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Southern" cuisineId:@"112"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Southwest" cuisineId:@"113"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Spanish" cuisineId:@"114"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Steakhouse" cuisineId:@"115"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Subs" cuisineId:@"116"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Sushi" cuisineId:@"117"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Szechuan" cuisineId:@"135"]];
    
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Taiwanese" cuisineId:@"118"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Tapas" cuisineId:@"119"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Tex-Mex" cuisineId:@"120"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Thai" cuisineId:@"121"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Tibetan" cuisineId:@"122"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Tunisian" cuisineId:@"123"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Turkish" cuisineId:@"124"]];
    
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Vegan" cuisineId:@"125"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Vegetarian" cuisineId:@"126"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Venezuelan" cuisineId:@"127"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Vietnamese" cuisineId:@"128"]];
    
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Waffles" cuisineId:@"137"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Wings" cuisineId:@"129"]];
    [self.allCuisines addObject:[[CGCuisine alloc] initWithName:@"Wraps" cuisineId:@"130"]];
}

-(void) buildAllFeatures {
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"A/V Equipment" featureId:@"1"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Air Hockey" featureId:@"2"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Arcade Games" featureId:@"3"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Art Collection" featureId:@"4"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Art Gallery" featureId:@"5"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"ATM" featureId:@"6"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Award Winning" featureId:@"7"]];
    
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Bar Games" featureId:@"8"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Bar/Lounge" featureId:@"9"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Beer & Wine" featureId:@"10"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Beer Club" featureId:@"11"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Beer Garden" featureId:@"12"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Beer Pairing" featureId:@"13"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Beer Pong" featureId:@"14"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Beer Tastings" featureId:@"15"]];
    
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Billiards" featureId:@"16"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Bistro" featureId:@"17"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Board Games" featureId:@"18"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Booster Seats" featureId:@"19"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Bottle Service" featureId:@"20"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Bowling" featureId:@"21"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Braille Menus" featureId:@"22"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Breakfast All Day" featureId:@"23"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Brewpub" featureId:@"24"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Brick Oven" featureId:@"25"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Bubble Hockey" featureId:@"167"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Buffet" featureId:@"26"]];
    
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Cabanas" featureId:@"27"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Call Ahead Seating" featureId:@"28"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Car Service" featureId:@"29"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Catering" featureId:@"30"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Celebrity Chef" featureId:@"31"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Chef's Table" featureId:@"32"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Chocolate Bar" featureId:@"33"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Cigar Bar" featureId:@"34"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Coat Check" featureId:@"35"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Comedy" featureId:@"36"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Cooking Classes" featureId:@"37"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Cornhole" featureId:@"38"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Corporate Accounts" featureId:@"39"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Counter Seating" featureId:@"40"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Cover Charge" featureId:@"41"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Craft Beer" featureId:@"165"]];
    
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Dance Lessons" featureId:@"42"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Dancing" featureId:@"43"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Darts" featureId:@"44"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Deck" featureId:@"46"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Dine-In" featureId:@"47"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Diner" featureId:@"48"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"DJ" featureId:@"49"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Dress Code" featureId:@"50"]];
    
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Early Bird Specials" featureId:@"51"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Enoteca" featureId:@"52"]];
    
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Family Style" featureId:@"53"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Faneuil Hall" featureId:@"54"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Fire Pit" featureId:@"55"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Fireplace" featureId:@"56"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Fish Tank" featureId:@"57"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Food Stand" featureId:@"166"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Food Truck" featureId:@"161"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Foosball" featureId:@"58"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Formal Tea" featureId:@"59"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Fountain" featureId:@"60"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Free Popcorn" featureId:@"61"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Full Bar" featureId:@"62"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Functions" featureId:@"63"]];
    
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Game Served" featureId:@"64"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Gay Bar" featureId:@"65"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Gift Cards" featureId:@"66"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Gluten Free Options" featureId:@"67"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Great View" featureId:@"68"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Green Certified" featureId:@"69"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Guest List" featureId:@"70"]];
    
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Halal" featureId:@"71"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Happy Hour Specials" featureId:@"72"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Heated Patio" featureId:@"129"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Heated Rooftop" featureId:@"73"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"High Chairs" featureId:@"74"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Hookah Bar" featureId:@"75"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Hotel Bar" featureId:@"76"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Hotel Dining" featureId:@"77"]];
    
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"International Sports" featureId:@"78"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Internet Access" featureId:@"79"]];
    
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Jukebox" featureId:@"80"]];
    
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Karaoke" featureId:@"81"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Keno" featureId:@"82"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Kids Menu" featureId:@"83"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Kids Play Area" featureId:@"84"]];
    
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Large Parties" featureId:@"85"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Large Print Menus" featureId:@"86"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Large Reservations" featureId:@"87"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Live Entertainment" featureId:@"88"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Live Music" featureId:@"89"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Lottery" featureId:@"160"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Loyalty Program" featureId:@"90"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Lunch Specials" featureId:@"91"]];
    
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Mall Dining" featureId:@"92"]];
    
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Near Aquarium" featureId:@"93"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Near Fenway Park" featureId:@"94"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Near TD Garden" featureId:@"95"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Notable Beer List" featureId:@"96"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Notable Spirits List" featureId:@"97"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Notable Tequila List" featureId:@"98"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Notable Vodka List" featureId:@"99"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Notable Whiskey List" featureId:@"100"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Notable Wine List" featureId:@"101"]];
    
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"On Site Parking" featureId:@"102"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Open Kitchen" featureId:@"103"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Open Mic" featureId:@"104"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Organic" featureId:@"105"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Outdoor Garden" featureId:@"106"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Outdoor Seating" featureId:@"107"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Outdoor Televisions" featureId:@"108"]];
    
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Patio" featureId:@"109"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"People Watching" featureId:@"110"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Personal Wines" featureId:@"111"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Photo Booth" featureId:@"112"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Piano Bar" featureId:@"113"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Pig Roast" featureId:@"168"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Pitchers" featureId:@"114"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Pizza Slices" featureId:@"115"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Pop-a-Shot" featureId:@"116"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Pop-Up Restaurant" featureId:@"132"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Private Rooms" featureId:@"117"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Prix Fixe Menu" featureId:@"118"]];
    
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Raw Bar" featureId:@"119"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Reservations" featureId:@"120"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Retail Butcher" featureId:@"121"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Retail Fish Market" featureId:@"162"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Retail Wine Store" featureId:@"122"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Retractable Roof" featureId:@"123"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Roof Deck" featureId:@"124"]];
    
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Sake Bar" featureId:@"125"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Salad Bar" featureId:@"126"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Self Serve Keg" featureId:@"127"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Seniors Menu" featureId:@"128"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Shuffle Board" featureId:@"130"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Shuttle Service" featureId:@"131"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Smoking Permitted" featureId:@"133"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Sports Bar" featureId:@"134"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Sports Memorabilia" featureId:@"135"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Student Discounts" featureId:@"136"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Sushi Bar" featureId:@"137"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Sushi Classe" featureId:@"138"]];
    
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Takeout" featureId:@"139"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Takeout Window" featureId:@"140"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Tapas" featureId:@"141"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Tasting Dinners" featureId:@"142"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Tasting Menu" featureId:@"143"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Televisions" featureId:@"144"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Terrace" featureId:@"145"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Theater District" featureId:@"146"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Trivia" featureId:@"147"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"TV Sports Packages" featureId:@"148"]];
    
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Valet Parking" featureId:@"149"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Validates Parking" featureId:@"150"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Video Bar" featureId:@"151"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Video Games" featureId:@"152"]];
    
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Waterfront" featureId:@"153"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Wheelchair Access" featureId:@"154"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Whiskey Club" featureId:@"164"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Wine Bar" featureId:@"156"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Wine Cellar" featureId:@"157"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Wine Pairing" featureId:@"158"]];
    [self.allFeatures addObject:[[CGFeature alloc] initWithName:@"Wine Tastings" featureId:@"159"]];
}

@end
