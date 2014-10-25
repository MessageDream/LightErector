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
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
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
}

-(void)registerUserTags:(NSSet *)tags andAlias:(NSString*)alias callbackSelector:(SEL) sel target:(id)observer
{
    [APService setTags:tags alias:alias callbackSelector:sel target:observer];
}
@end
