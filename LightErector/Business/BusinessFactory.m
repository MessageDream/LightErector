//
//  BusinessFactory.m
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "BusinessFactory.h"
#import "UserLoginBusiness.h"
#import "TaskRemindBusiness.h"
#import "GetOrderBusiness.h"
#import "GetOrderStatusBusiness.h"
#import "UpdateOrderStateBusiness.h"
#import "InstallErrorFeedbackBusiness.h"
#import "AcceptOrderBusiness.h"
#import "UploadCodeBusiness.h"
#import "UpdateSubTimeBusiness.h"
#import "UploadImageBusiness.h"
#import "UpdateUserInfoBusiness.h"
#import "VersionBusiness.h"

@implementation BusinessFactory

+(id)createBusiness:(enum BusinessType)type
{
    if(type == BUSINESS_NONE)
        return nil;
    else if (type==BUSINESS_LOGIN)
    {
        return [[UserLoginBusiness alloc] init];
    }else if (type==BUSINESS_GETTASKREMIND){
        return [[TaskRemindBusiness alloc] init];
    }else if (type==BUSINESS_GETTODAYTASKORDER
              ||type== BUSINESS_GETWAITFORRECEIVEORDER
              ||type== BUSINESS_GETWAITSUBORDER
              ||type== BUSINESS_GETUNTIMEDORDER
              ||type== BUSINESS_GETWAITFORINSTALLORDER
              ||type== BUSINESS_GETWAITFORFEEDBACKORDER
              ||type== BUSINESS_GETWAITFORSETTLEORDER){
        
         return [[GetOrderBusiness alloc] initWithBusinessId:type];
    }else if (type==BUSINESS_GETORDERSTATUS){
        return [[GetOrderStatusBusiness alloc] init];
    }else if (type==BUSINESS_UPDATEORDERSTATUS){
        return [[UpdateOrderStateBusiness alloc] init];
    }else if (type==BUSINESS_INSTALLERRORFEEDBACK){
        return [[InstallErrorFeedbackBusiness alloc] init];
    }else if (type==BUSINESS_ACCEPTORDER){
        return [[AcceptOrderBusiness alloc] init];
    }else if (type==BUSINESS_UPDATESUBTIME){
        return [[UpdateSubTimeBusiness alloc] init];
    }else if (type==BUSINESS_UPLOADCODE){
        return [[UploadCodeBusiness alloc] init];
    }else if (type==BUSINESS_UPLOADIMAGE){
        return [[UploadImageBusiness alloc] init];
    }else if(type==BUSINESS_UPDATEUSERINFO){
        return [[UpdateUserInfoBusiness alloc] init];
    }else if(type==BUSINESS_OTHER_CLIENTVERSION){
        return [[VersionBusiness alloc] init];
    }
    
    return nil;
}
@end
