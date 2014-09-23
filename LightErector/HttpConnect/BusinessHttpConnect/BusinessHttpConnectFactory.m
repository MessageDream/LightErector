//
//  BusinessHttpConnectFactory.m
//  LightErector
//
//  Created by Jayden Zhao on 13-4-8.
//  Copyright (c) 2013年 LightErector. All rights reserved.
//

#import "BusinessHttpConnectFactory.h"

@implementation BusinessHttpConnectFactory

+(id)createBusinessHttpConnect:(enum BusinessHttpConnectType)type
{
    if(type == BUSINESS_HTTPCONNECT_NONE)
        return nil;
    return nil;
}
@end
