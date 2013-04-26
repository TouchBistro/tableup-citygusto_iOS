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
@property (nonatomic, strong) NSString *venueType;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSNumber *distance;

@property (nonatomic, strong) NSString *eventWebsiteDescription1;
@property (nonatomic, strong) NSString *eventWebsiteName1;
@property (nonatomic, strong) NSString *eventWebsiteDescription2;
@property (nonatomic, strong) NSString *eventWebsiteName2;
@property (nonatomic, strong) NSString *eventWebsiteDescription3;
@property (nonatomic, strong) NSString *eventWebsiteName3;
@property (nonatomic, strong) NSString *eventWebsiteDescription4;
@property (nonatomic, strong) NSString *eventWebsiteName4;
@property (nonatomic, strong) NSString *eventWebsiteDescription5;
@property (nonatomic, strong) NSString *eventWebsiteName5;
@property (nonatomic, strong) NSString *eventWebsiteDescription6;
@property (nonatomic, strong) NSString *eventWebsiteName6;
@property (nonatomic, strong) NSString *eventWebsiteDescription7;
@property (nonatomic, strong) NSString *eventWebsiteName7;
@property (nonatomic, strong) NSString *eventWebsiteDescription8;
@property (nonatomic, strong) NSString *eventWebsiteName8;
@property (nonatomic, strong) NSString *eventWebsiteDescription9;
@property (nonatomic, strong) NSString *eventWebsiteName9;
@property (nonatomic, strong) NSString *eventWebsiteDescription10;
@property (nonatomic, strong) NSString *eventWebsiteName10;

@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *ageRange;
@property (nonatomic, strong) NSString *eventCategoryString;
@property (nonatomic, strong) NSString *eventTagString;

@property (nonatomic, strong) NSString *eventContactName1;
@property (nonatomic, strong) NSString *eventContactPhone1;
@property (nonatomic, strong) NSString *eventContactEmail1;
@property (nonatomic, strong) NSString *eventContactName2;
@property (nonatomic, strong) NSString *eventContactPhone2;
@property (nonatomic, strong) NSString *eventContactEmail2;
@property (nonatomic, strong) NSString *eventContactName3;
@property (nonatomic, strong) NSString *eventContactPhone3;
@property (nonatomic, strong) NSString *eventContactEmail3;

@property (nonatomic, strong) NSString *ticketDate;
@property (nonatomic, strong) NSString *ticketTime;
@property (nonatomic, strong) NSString *ticketInfo;

@property (nonatomic, strong) NSString *facebookURL;
@property (nonatomic, strong) NSString *twitterUserName;

@property (nonatomic, strong) NSNumber *numberOfLikes;
@property (nonatomic, strong) NSNumber *numberOfDislikes;
@property (nonatomic, strong) NSNumber *percentageLike;
@property (nonatomic, strong) NSNumber *numberOfStars;
@property (nonatomic, strong) NSNumber *numberOfTopFiveLists;
@property (nonatomic, strong) NSNumber *numberOfRatings;

@property (nonatomic, strong) NSNumber *eventVenueId;
@property (nonatomic, strong) NSString *eventVenueName;
@property (nonatomic, strong) NSString *eventVenueAddress;
@property (nonatomic, strong) NSString *eventVenueType;
@property (nonatomic, strong) NSString *eventVenueCityName;
@property (nonatomic, strong) NSString *eventVenueNeighborhoodName;
@property (nonatomic, strong) NSString *eventVenueState;
@property (nonatomic, strong) NSString *eventVenueZipcode;
@property (nonatomic, strong) NSString *eventVenuePhoneNumber;
@property (nonatomic, strong) NSString *eventVenueWebsite;
@property (nonatomic, strong) NSString *eventVenuePrimaryPhotoURL;
@property (nonatomic, strong) NSString *eventVenueEncodedAddress;

@property (nonatomic, strong) NSString *nextOccurrenceDate;
@property (nonatomic, strong) NSString *nextOccurrenceStartTime;
@property (nonatomic, strong) NSString *nextOccurrenceEndTime;

@property (nonatomic, strong) NSString *occurrenceString;
@property (nonatomic, strong) NSString *citygustoURL;

@property (nonatomic, strong) NSMutableArray *occurrences;


@end
