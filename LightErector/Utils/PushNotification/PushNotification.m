//
//  PushNotification.m
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "PushNotification.h"

static id pushNotification;

@interface PushNotification()
{
    
}
@end

@implementation PushNotification


-(id)init
{
    self = [super init];

    return self;
}

+(id)sharePushNotification
{
    if(pushNotification == nil)
        pushNotification = [[self alloc] init];
    return pushNotification;
}

-(void)applyForPushNotification:(NSDictionary *)launchingOption
{
    #if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            //可以添加自定义categories
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
        } else {
           [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
              }
    #else
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    #endif
    
}
-(void)registerDeviceToken:(NSData*)deviceToken
{
    
}
-(void)receivePushNotification:(NSDictionary*)userInfo
{
    if(self.observer != nil && [self.observer respondsToSelector:@selector(didReceivePushNotification:)])
    {
        [self.observer didReceivePushNotification:userInfo];
    }
}
-(void)setApplicationIconBadgeNumber:(int)applicationIconBadgeNumber
{
    [[UIApplication sharedApplication ] setApplicationIconBadgeNumber:applicationIconBadgeNumber];
}
-(int)applicationIconBadgeNumber
{
    return [UIApplication sharedApplication].applicationIconBadgeNumber;
}
@end
