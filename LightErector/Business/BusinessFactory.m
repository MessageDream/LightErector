//
//  BusinessFactory.m
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "BusinessFactory.h"
#import "UserLoginBusiness.h"
#import "TodayTaskBusiness.h"

@implementation BusinessFactory

+(id)createBusiness:(enum BusinessType)type
{
    if(type == BUSINESS_NONE)
        return nil;
    else if (type==BUSINESS_LOGIN)
    {
        return [[UserLoginBusiness alloc] init];
    }else if (type==BUSINESS_GETTODAYTASK){
        return [[TodayTaskBusiness alloc] init];
    }

    return nil;
}
@end
