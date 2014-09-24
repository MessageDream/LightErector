//
//  PushNotification.h
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//


@protocol PushNotificationDelegate <NSObject>
@optional
-(void)didReceivePushNotification:(NSDictionary*)userInfo;
@end

@interface PushNotification : NSObject
{

}
@property(nonatomic) int applicationIconBadgeNumber;
@property(nonatomic,assign)id<PushNotificationDelegate> observer;
+(PushNotification*)sharePushNotification;
//根据不同的第三方推送包进行该方法的重写,重写后不调用父类的该方法。
-(void)applyForPushNotification:(NSDictionary *)launchingOption;
//根据不同的第三方推送包进行该方法的重写,重写后不调用父类的该方法。
-(void)registerDeviceToken:(NSData*)deviceToken;
//根据不同的第三方推送包进行该方法的重写。
-(void)receivePushNotification:(NSDictionary*)userInfo;
@end
