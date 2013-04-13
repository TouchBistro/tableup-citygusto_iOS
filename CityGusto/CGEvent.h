//
//  CGEvent.h
//  CityGusto
//
//  Created by Padraic Doyle on 3/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGEvent : NSObject

@property (nonatomic, strong) NSString *eventId;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *venueName;
@property (nonatomic, strong) NSString *venueShortName;

@property (nonatomic, strong) NSString *dateString;

@property (nonatomic, strong) NSString *venueAddress1;
@property (nonatomic, strong) NSString *venueAddress2;
@property (nonatomic, strong) NSString *venueEncodedAddress;
@property (nonatomic, strong) NSString *venueCityName;
@property (nonatomic, strong) NSString *venueState;
@property (nonatomic, strong) NSString *venueZipcode;
@property (nonatomic, strong) NSString *venuePhotoURL;
@property (nonatomic, strong) NSString *venueWebsite;

@property (nonatomic, strong) NSString *venueId;
@property (nonatomic, strong) NSString *venueNeighborhoodName;
@property (nonatomic, strong) NSNumber *venueLatitude;
@property (nonatomic, strong) NSNumber *venueLongitude;
@property (nonatomic, strong) NSString *venuePhoneNumber;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *venueType;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSNumber *distance;



@end
