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
    }
    
    return nil;
}
@end
