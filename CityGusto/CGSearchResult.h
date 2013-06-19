//
//  CGSearchResult.h
//  CityGusto
//
//  Created by Padraic Doyle on 6/19/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGSearchResult : NSObject

@property (nonatomic, strong) NSNumber *resultId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSString *photoURL;

@end
