//
//  LocalPushNotification.h
//  LightErector
//
//  Created by Jayden Zhao on 10/28/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "PushNotification.h"

@interface LocalPushNotification : PushNotification
-(void)applyForPushNotification:(NSDictionary *)launchingOption;
@end
