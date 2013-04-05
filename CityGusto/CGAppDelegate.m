//
//  CGAppDelegate.m
//  CityGusto
//
//  Created by Padraic Doyle on 3/10/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGAppDelegate.h"
#import "CGCreditCard.h"
#import "CGCuisine.h"
#import "CGFeature.h"
#import "CGMenu.h"
#import "CGPhoto.h"
#import "CGReviewLink.h"
#import "CGRestaurant.h"
#import "CGRestaurantParameter.h"
#import "CGTopListPosition.h"
#import "CGRestaurantListCategory.h"
#import "CGRestaurantList.h"
#import <RestKit/RestKit.h>

@implementation CGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    RKLogConfigureByName("RestKit/Network", RKLogLevelInfo);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelInfo);
    
    NSURL *baseURL = [NSURL URLWithString:@"http://localhost:8080"];
    AFHTTPClient* client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [client setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
    
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    RKObjectMapping *creditCardMapping = [RKObjectMapping mappingForClass:[CGCreditCard class]];
    [creditCardMapping addAttributeMappingsFromArray:@[ @"name" ]];
    
    RKObjectMapping *cuisineMapping = [RKObjectMapping mappingForClass:[CGCuisine class]];
    [cuisineMapping addAttributeMappingsFromArray:@[ @"name", @"cuisineId" ]];
    
    RKObjectMapping *featureMapping = [RKObjectMapping mappingForClass:[CGFeature class]];
    [featureMapping addAttributeMappingsFromArray:@[ @"name", @"featureId" ]];
    
    RKObjectMapping *menuMapping = [RKObjectMapping mappingForClass:[CGMenu class]];
    [menuMapping addAttributeMappingsFromArray:@[ @"name", @"menuURL" ]];
    
    RKObjectMapping *photoMapping = [RKObjectMapping mappingForClass:[CGPhoto class]];
    [photoMapping addAttributeMappingsFromArray:@[ @"caption", @"photoURL" ]];
    
    RKObjectMapping *reviewLinkMapping = [RKObjectMapping mappingForClass:[CGReviewLink class]];
    [reviewLinkMapping addAttributeMappingsFromArray:@[ @"text", @"link" ]];
    
    RKObjectMapping *topListMapping = [RKObjectMapping mappingForClass:[CGTopListPosition class]];
    [topListMapping addAttributeMappingsFromArray:@[ @"listName", @"neighborhoodName", @"cityName", @"listId", @"position" ]];
    
    RKObjectMapping* restaurantMapping = [RKObjectMapping mappingForClass:[CGRestaurant class] ];
    [restaurantMapping addAttributeMappingsFromDictionary:@{ @"id": @"restaurantId" }];
    [restaurantMapping addAttributeMappingsFromArray:@[ @"name", @"primaryPhotoURL"
     , @"primaryPhotoURL150x150"
     , @"sunIsClosed"
     , @"sunIsOpenAllDay"
     , @"sunOpenTime"
     , @"sunCloseTime"
     , @"monIsClosed"
     , @"monIsOpenAllDay"
     , @"monOpenTime"
     , @"monCloseTime"
     , @"tuesIsClosed"
     , @"tuesIsOpenAllDay"
     , @"tuesOpenTime"
     , @"tuesCloseTime"
     , @"wedIsClosed"
     , @"wedIsOpenAllDay"
     , @"wedOpenTime"
     , @"wedCloseTime"
     , @"thursIsClosed"
     , @"thursIsOpenAllDay"
     , @"thursOpenTime"
     , @"thursCloseTime"
     , @"friIsClosed"
     , @"friIsOpenAllDay"
     , @"friOpenTime"
     , @"friCloseTime"
     , @"satIsClosed"
     , @"satIsOpenAllDay"
     , @"satOpenTime"
     , @"satCloseTime"
     , @"numberOfTopFiveLists"
     , @"address1"
     , @"address2"
     , @"cityName"
     , @"state"
     , @"zipcode"
     , @"phoneNumber"
     , @"encodedAddress"
     , @"about"
     , @"price"
     , @"delivers"
     , @"deliveryInfo"
     , @"parkingInfo"
     , @"twitterUserName"
     , @"facebookURL"
     , @"latitude"
     , @"longitude"
     , @"open"
     , @"numberOfReviews"
     , @"numberOfRatings"
     , @"cumulativeRating"
     , @"numberOfLikes"
     , @"numberOfDislikes"
     , @"percentageLike"
     , @"numberOfStars"
     , @"numberOfDollarSigns"
     , @"citygustoURL"
     , @"ambianceName1"
     , @"ambianceName2"
     , @"ambianceName3"
     , @"ambianceNames"
     , @"featureNames"
     , @"creditcardNames"
     , @"cuisineNames"
     ]];
    
    
    [restaurantMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"creditCards" toKeyPath:@"creditCards" withMapping:creditCardMapping]];
    [restaurantMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"cuisines" toKeyPath:@"cuisines" withMapping:cuisineMapping]];
    [restaurantMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"features" toKeyPath:@"features" withMapping:featureMapping]];
    [restaurantMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"menus" toKeyPath:@"menus" withMapping:menuMapping]];
    [restaurantMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"photos" toKeyPath:@"photos" withMapping:photoMapping]];
    [restaurantMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"reviewLinks" toKeyPath:@"reviewLinks" withMapping:reviewLinkMapping]];
    [restaurantMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"restaurantListPositions" toKeyPath:@"restaurantListPositions" withMapping:topListMapping]];
    
    RKObjectMapping *restaurantListMapping = [RKObjectMapping mappingForClass:[CGRestaurantList class]];
    [restaurantListMapping addAttributeMappingsFromDictionary:@{ @"id": @"restaurantListId" }];
    [restaurantListMapping addAttributeMappingsFromArray:@[ @"name", @"cityUrlId", @"neighborhoodUrlId", @"photoURL" ]];
    [restaurantListMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"restaurants" toKeyPath:@"restaurants" withMapping:restaurantMapping]];
    
    RKObjectMapping *restaurantListCategoryMapping = [RKObjectMapping mappingForClass:[CGRestaurantListCategory class]];
    [restaurantListCategoryMapping addAttributeMappingsFromDictionary:@{ @"id": @"restaurantListCategoryId" }];
    [restaurantListCategoryMapping addAttributeMappingsFromArray:@[ @"name", @"neighborhoodName", @"cityName" ]];
    
    [restaurantListCategoryMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"restaurantLists" toKeyPath:@"restaurantLists" withMapping:restaurantListMapping]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:restaurantMapping pathPattern:nil keyPath:@"restaurants" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    [objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:cuisineMapping pathPattern:nil keyPath:@"cuisines" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
    [objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:featureMapping pathPattern:nil keyPath:@"features" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
    [objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:restaurantListCategoryMapping pathPattern:nil keyPath:@"restaurantListCategories" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
    
    //set default parameters
    CGRestaurantParameter *params = [CGRestaurantParameter shared];
    params.max = [[NSNumber alloc] initWithInt:25];
    params.offset = [[NSNumber alloc] initWithInt:0];
    
    params.deliveryFilter = NO;
    params.kitchenOpenFilter = NO;
    params.useCurrentLocation = NO;
    params.sortOrder = @"distance";
    
    [params changeLocation:[[NSNumber alloc] initWithInt:4] neighborhoodId:nil];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
