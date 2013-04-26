//
//  CGLocal.h
//  CityGusto
//
//  Created by Padraic Doyle on 4/26/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGLocal : NSObject

@property (nonatomic, strong) NSNumber *localId;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *website;

@property (nonatomic, strong) NSString *primaryPhotoURL;
@property (nonatomic, strong) NSString *primaryPhotoURL150x150;

@property (nonatomic, strong) NSString *address1;
@property (nonatomic, strong) NSString *address2;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *neighborhoodName;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zipcode;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *encodedAddress;

@property (nonatomic, strong) NSString *about;
@property (nonatomic, strong) NSString *delivers;
@property (nonatomic, strong) NSString *deliveryInfo;
@property (nonatomic, strong) NSString *parkingInfo;
@property (nonatomic, strong) NSString *twitterUserName;
@property (nonatomic, strong) NSString *facebookURL;

@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;

@property (nonatomic, strong) NSString *citygustoURL;

@property (nonatomic, strong) NSString *categoryNames;

@end
