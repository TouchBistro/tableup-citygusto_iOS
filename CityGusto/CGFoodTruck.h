//
//  CGFoodTruck.h
//  CityGusto
//
//  Created by Padraic Doyle on 5/22/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGFoodTruck : NSObject

@property (nonatomic, strong) NSNumber *foodTruckId;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *primaryPhotoURL;
@property (nonatomic, strong) NSNumber *numberOfDollarSigns;

@property (nonatomic, assign, getter=isOpen) BOOL open;

@property (nonatomic, strong) NSNumber *numberOfStars;

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

@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *distance;


@end
