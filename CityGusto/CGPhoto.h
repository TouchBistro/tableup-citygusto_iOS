//
//  CGPhoto.h
//  CityGusto
//
//  Created by Padraic Doyle on 3/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGPhoto : NSObject

@property (nonatomic, strong) NSNumber *photoId;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSString *photoURL;

@end
