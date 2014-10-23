//
//  JPushNotification.m
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "JPushNotification.h"
#import "APService.h"

@implementation JPushNotification
-(void)applyForPushNotification:(NSDictionary *)launchingOption
{
    [APService registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound |UIRemoteNotificationTypeAlert categories:nil];
    [APService setupWithOption:launchingOption];
}

-(void)registerDeviceToken:(NSData*)deviceToken
{
     [APService registerDeviceToken:deviceToken];
}

-(void)receivePushNotification:(NSDictionary*)userInfo
{
    [super receivePushNotification:userInfo];
    [APService handleRemoteNotification:userInfo];
    NSLog(@"%@",userInfo);
}

-(void)registerUserTags:(NSSet *)tags andAlias:(NSString*)alias callbackSelector:(SEL) sel target:(id)observer
{
    [APService setTags:tags alias:alias callbackSelector:sel target:observer];
}
@end
