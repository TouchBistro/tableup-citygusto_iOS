//
//  CGAppDelegate.h
//  CityGusto
//
//  Created by Padraic Doyle on 3/10/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface CGAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FBSession *session;

@end
