//
//  CGRestaurant.h
//  CityGusto
//
//  Created by Padraic Doyle on 3/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CGRestaurant : NSObject

@property (nonatomic, strong) NSNumber *restaurantId;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *primaryPhotoURL;
@property (nonatomic, strong) NSString *primaryPhotoURL150x150;

@property (nonatomic, assign, getter=isSunIsClosed) BOOL sunIsClosed;
@property (nonatomic, assign, getter=isSunIsOpenAllDay) BOOL sunIsOpenAllDay;
@property (nonatomic, strong) NSString *sunOpenTime;
@property (nonatomic, strong) NSString *sunCloseTime;

@property (nonatomic, assign, getter=isMonIsClosed) BOOL monIsClosed;
@property (nonatomic, assign, getter=isMunIsOpenAllDay) BOOL monIsOpenAllDay;
@property (nonatomic, strong) NSString *monOpenTime;
@property (nonatomic, strong) NSString *monCloseTime;

@property (nonatomic, assign, getter=isTuesIsClosed) BOOL tuesIsClosed;
@property (nonatomic, assign, getter=isTuesIsOpenAllDay) BOOL tuesIsOpenAllDay;
@property (nonatomic, strong) NSString *tuesOpenTime;
@property (nonatomic, strong) NSString *tuesCloseTime;

@property (nonatomic, assign, getter=isWedIsClosed) BOOL wedIsClosed;
@property (nonatomic, assign, getter=isWedIsOpenAllDay) BOOL wedIsOpenAllDay;
@property (nonatomic, strong) NSString *wedOpenTime;
@property (nonatomic, strong) NSString *wedCloseTime;

@property (nonatomic, assign, getter=isThursIsClosed) BOOL thursIsClosed;
@property (nonatomic, assign, getter=isThursIsOpenAllDay) BOOL thursIsOpenAllDay;
@property (nonatomic, strong) NSString *thursOpenTime;
@property (nonatomic, strong) NSString *thursCloseTime;

@property (nonatomic, assign, getter=isFriIsClosed) BOOL friIsClosed;
@property (nonatomic, assign, getter=isFriIsOpenAllDay) BOOL friIsOpenAllDay;
@property (nonatomic, strong) NSString *friOpenTime;
@property (nonatomic, strong) NSString *friCloseTime;

@property (nonatomic, assign, getter=isSatIsClosed) BOOL satIsClosed;
@property (nonatomic, assign, getter=isSatIsOpenAllDay) BOOL satIsOpenAllDay;
@property (nonatomic, strong) NSString *satOpenTime;
@property (nonatomic, strong) NSString *satCloseTime;

@property (nonatomic, strong) NSNumber *numberOfTopFiveLists;

@property (nonatomic, strong) NSString *address1;
@property (nonatomic, strong) NSString *address2;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zipcode;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *encodedAddress;
@property (nonatomic, strong) NSString *about;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *delivers;
@property (nonatomic, strong) NSString *deliveryInfo;
@property (nonatomic, strong) NSString *parkingInfo;
@property (nonatomic, strong) NSString *twitterUserName;
@property (nonatomic, strong) NSString *facebookURL;

@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *distance;

@property (nonatomic, assign, getter=isOpen) BOOL open;
@property (nonatomic, assign, getter=isFoodTruck) BOOL foodTruck;

@property (nonatomic, strong) NSNumber *numberOfReviews;
@property (nonatomic, strong) NSNumber *numberOfRatings;
@property (nonatomic, strong) NSNumber *cumulativeRating;
@property (nonatomic, strong) NSNumber *numberOfLikes;
@property (nonatomic, strong) NSNumber *numberOfDislikes;
@property (nonatomic, strong) NSNumber *percentageLike;
@property (nonatomic, strong) NSNumber *numberOfStars;
@property (nonatomic, strong) NSNumber *numberOfDollarSigns;

@property (nonatomic, strong) NSString *citygustoURL;
@property (nonatomic, strong) NSString *ambianceName1;
@property (nonatomic, strong) NSString *ambianceName2;
@property (nonatomic, strong) NSString *ambianceName3;
@property (nonatomic, strong) NSString *ambianceNames;
@property (nonatomic, strong) NSString *featureNames;
@property (nonatomic, strong) NSString *creditcardNames;
@property (nonatomic, strong) NSString *cuisineNames;
@property (nonatomic, strong) NSString *website;


@property (nonatomic, strong) NSMutableArray *creditCards;
@property (nonatomic, strong) NSMutableArray *cuisines;
@property (nonatomic, strong) NSMutableArray *features;
@property (nonatomic, strong) NSMutableArray *menus;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *events;

@property (nonatomic, strong) NSMutableArray *restaurantListPositions;
@property (nonatomic, strong) NSMutableArray *reviewLinks;

@property (nonatomic, strong) UIImage *image;

@end
