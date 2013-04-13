//
//  CGTag.h
//  CityGusto
//
//  Created by Padraic Doyle on 4/12/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGTag : NSObject

@property (nonatomic, strong) NSString *tagId;
@property (nonatomic, strong) NSString *name;


-(id) initWithName:(NSString *)name_ tagId:(NSString *) tagId_;

@end
