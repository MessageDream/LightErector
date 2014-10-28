//
//  EKEventUtils.m
//  LightErector
//
//  Created by Jayden Zhao on 10/28/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "EKEventUtils.h"

@implementation EKEventUtils
+(BOOL)authStatus
{
    EKAuthorizationStatus status=[EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    return status==EKAuthorizationStatusAuthorized;
}
+(void)requestAccessWithCompletion:(void (^)(BOOL granted, NSError *error))competion
{
        EKEventStore *store=[[EKEventStore alloc] init];
        [store requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error) {
            competion(granted,error);
        }];
}
@end
