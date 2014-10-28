//
//  EKEventUtils.h
//  LightErector
//
//  Created by Jayden Zhao on 10/28/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

@interface EKEventUtils : NSObject
+(BOOL)authStatus;
+(void)requestAccessWithCompletion:(void (^)(BOOL granted, NSError *error)) competion;
@end
