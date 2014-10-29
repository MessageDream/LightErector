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
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
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
