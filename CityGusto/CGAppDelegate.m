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
#import "CGEvent.h"
#import "CGCategory.h"
#import "CGTag.h"
#import "CGUser.h"
#import "CGRestaurantFavoriteList.h"
#import "CGLocal.h"
#import <RestKit/RestKit.h>
#import <CoreLocation/CoreLocation.h>

@implementation CGAppDelegate

@synthesize session = _session;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    RKLogConfigureByName("RestKit/Network", RKLogLevelInfo);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelInfo);
    
//    NSURL *baseURL = [NSURL URLWithString:@"http://localhost:8080"];
    NSURL *baseURL = [NSURL URLWithString:@"http://citygusto.com"];
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
     , @"website"
     , @"distance"
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
    
    RKObjectMapping *eventMapping = [RKObjectMapping mappingForClass:[CGEvent class]];
    [eventMapping addAttributeMappingsFromDictionary:@{ @"id": @"eventId" }];
    [eventMapping addAttributeMappingsFromArray:@[ @"name"
     , @"venueName"
     , @"venueShortName"
     , @"dateString"
     , @"venueAddress1"
     , @"venueAddress2"
     , @"venueEncodedAddress"
     , @"venueCityName"
     , @"venueState"
     , @"venueZipcode"
     , @"venuePhotoURL"
     , @"venueWebsite"
     , @"venueNeighborhoodName"
     , @"venueLatitude"
     , @"venueLongitude"
     , @"venueId"
     , @"venuePhoneNumber"
     , @"description"
     , @"venueType"
     , @"startTime"
     , @"endTime"
     , @"distance"
     , @"eventWebsiteDescription1"
     , @"eventWebsiteName1"
     , @"eventWebsiteDescription2"
     , @"eventWebsiteName2"
     , @"eventWebsiteDescription3"
     , @"eventWebsiteName3"
     , @"eventWebsiteDescription4"
     , @"eventWebsiteName4"
     , @"eventWebsiteDescription5"
     , @"eventWebsiteName5"
     , @"eventWebsiteDescription6"
     , @"eventWebsiteName6"
     , @"eventWebsiteDescription7"
     , @"eventWebsiteName7"
     , @"eventWebsiteDescription8"
     , @"eventWebsiteName8"
     , @"eventWebsiteDescription9"
     , @"eventWebsiteName9"
     , @"eventWebsiteDescription10"
     , @"eventWebsiteName10"     
     , @"eventContactName1"
     , @"eventContactPhone1"
     , @"eventContactEmail1"
     , @"eventContactName2"
     , @"eventContactPhone2"
     , @"eventContactEmail2"
     , @"eventContactName3"
     , @"eventContactPhone3"
     , @"eventContactEmail3"     
     , @"eventVenueId"
     , @"eventVenueName"
     , @"eventVenueAddress"
     , @"eventVenueType"
     , @"eventVenueCityName"
     , @"eventVenueNeighborhoodName"
     , @"eventVenueState"
     , @"eventVenueZipcode"
     , @"eventVenuePhoneNumber"
     , @"eventVenueWebsite"
     , @"eventVenuePrimaryPhotoURL"
     , @"eventVenueEncodedAddress"
     , @"price"
     , @"ageRange"
     , @"eventCategoryString"
     , @"eventTagString"
     , @"ticketDate"
     , @"ticketTime"
     , @"ticketInfo"
     , @"facebookURL"
     , @"twitterUserName"
     , @"numberOfLikes"
     , @"numberOfDislikes"
     , @"percentageLike"
     , @"numberOfStars"
     , @"numberOfTopFiveLists"
     , @"numberOfRatings"
     , @"nextOccurrenceDate"
     , @"nextOccurrenceStartTime"
     , @"nextOccurrenceEndTime"
     , @"occurrenceString"
     , @"citygustoURL"
     , @"occurrences"
     ]];
    
    RKObjectMapping *localMapping = [RKObjectMapping mappingForClass:[CGLocal class]];
    [localMapping addAttributeMappingsFromDictionary:@{ @"id": @"localId" }];
    [localMapping addAttributeMappingsFromArray:@[ @"name"
     , @"website"
     , @"primaryPhotoURL"
     , @"primaryPhotoURL150x150"
     , @"address1"
     , @"address2"
     , @"cityName"
     , @"neighborhoodName"
     , @"state"
     , @"zipcode"
     , @"phoneNumber"
     , @"encodedAddress"
     , @"about"
     , @"delivers"
     , @"deliveryInfo"
     , @"parkingInfo"
     , @"twitterUserName"
     , @"facebookURL"
     , @"latitude"
     , @"venueName"
     , @"longitude"
     , @"citygustoURL"
     , @"categoryNames"
     ]];
    
    RKObjectMapping *categoryMapping = [RKObjectMapping mappingForClass:[CGCategory class]];
    [categoryMapping addAttributeMappingsFromArray:@[ @"name", @"categoryId" ]];
    
    RKObjectMapping *tagMapping = [RKObjectMapping mappingForClass:[CGTag class]];
    [tagMapping addAttributeMappingsFromArray:@[ @"name", @"tagId" ]];
    
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[CGUser class]];
    [userMapping addAttributeMappingsFromDictionary:@{ @"id": @"userId" }];
    [userMapping addAttributeMappingsFromArray:@[ @"username" ]];
    
    RKObjectMapping *restaurantFavoriteListMapping = [RKObjectMapping mappingForClass:[CGRestaurantFavoriteList class]];
    [restaurantFavoriteListMapping addAttributeMappingsFromDictionary:@{ @"id": @"restaurantFavoriteListId" }];
    [restaurantFavoriteListMapping addAttributeMappingsFromArray:@[ @"name" ]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:restaurantMapping pathPattern:nil keyPath:@"restaurants" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    [objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:cuisineMapping pathPattern:nil keyPath:@"cuisines" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
    [objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:featureMapping pathPattern:nil keyPath:@"features" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
    [objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:categoryMapping
                                                                                 pathPattern:nil
                                                                                     keyPath:@"categories"
                                                                                 statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
    
    [objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:tagMapping
                                                                                 pathPattern:nil
                                                                                     keyPath:@"tags"
                                                                                 statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
    
    [objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:restaurantListCategoryMapping pathPattern:nil keyPath:@"restaurantListCategories" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
    [objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:eventMapping
                                                                                 pathPattern:nil
                                                                                     keyPath:@"events"
                                                                                 statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
    
    [objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:userMapping
                                                                                 pathPattern:nil
                                                                                     keyPath:@"users"
                                                                                 statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
    
    [objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:restaurantFavoriteListMapping
                                                                                 pathPattern:nil
                                                                                     keyPath:@"restaurantFavoriteLists"
                                                                                 statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
    
    [objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:localMapping
                                                                                 pathPattern:nil
                                                                                     keyPath:@"locals"
                                                                                 statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
    
    //set default parameters
    CGRestaurantParameter *params = [CGRestaurantParameter shared];
    params.max = [[NSNumber alloc] initWithInt:25];
    params.offset = [[NSNumber alloc] initWithInt:0];
    
    params.deliveryFilter = NO;
    params.kitchenOpenFilter = NO;
    params.useCurrentLocation = NO;
    params.sortOrder = @"distance";
    params.date = [[NSDate alloc] init];
    [params.times addObject:[NSNumber numberWithInt:1]];
    [params.times addObject:[NSNumber numberWithInt:2]];
    [params.times addObject:[NSNumber numberWithInt:3]];
    [params.times addObject:[NSNumber numberWithInt:4]];
    
//    params.useCurrentLocation = true;
//    params.lon = [NSNumber numberWithDouble:-71.06966];
//    params.lat = [NSNumber numberWithDouble:42.35657];
    
    params.cityId = [NSNumber numberWithInt:4];
    params.neighborhoodId = nil;
    [params changeLocation];
    
    UIImage *image = [[UIImage imageNamed:@"headerButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 16, 0, 16)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
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
    [FBSession.activeSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [FBSession.activeSession close];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    return [FBSession.activeSession handleOpenURL:url];
}


@end
