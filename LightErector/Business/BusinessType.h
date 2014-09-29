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
    
   
    BUSINESS_GETTODAYTASKORDER,        //1今日任务
    BUSINESS_GETWAITFORRECEIVEORDER,           // 2最新待接单订单
    BUSINESS_GETWAITSUBORDER,       // 3待预约订单
    BUSINESS_GETUNTIMEDORDER,       // 4已预约但未确定时间(再预约列表)
    BUSINESS_GETWAITFORINSTALLORDER,     //5待安装订单
    BUSINESS_GETWAITFORFEEDBACKORDER,    //6完成待反馈订单
    BUSINESS_GETWAITFORSETTLEORDER,

    BUSINESS_GETTASKREMIND,
    
    BUSINESS_OTHER_CLIENTVERSION=300,
    
    BUSINESS_DOWNLOADFILE = 9999,
    BUSINESS_NONE = 10000
};

#endif
