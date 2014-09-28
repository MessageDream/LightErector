//
//  BusinessType.h
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#ifndef BusinessType_h
#define BusinessType_h

typedef NS_ENUM(NSInteger, BusinessType)
{
    BUSINESS_LOGIN = 0,
    BUSINESS_LOGOUT,
    BUSINESS_COMMITFEEDBACK,
    BUSINESS_GETUSERINFO,
    BUSINESS_UPDATEUSERINFO,
    
    BUSINESS_GETTODAYTASK,

    
    BUSINESS_OTHER_CLIENTVERSION=300,
    
    BUSINESS_DOWNLOADFILE = 9999,
    BUSINESS_NONE = 10000
};

#endif
