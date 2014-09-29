//
//  TodayTaskBusiness.m
//  LightErector
//
//  Created by Jayden Zhao on 9/28/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "TaskRemindBusiness.h"

@implementation TaskRemindBusiness
-(id)init
{
    self = [super initWithNtspHeader];
    self.businessId = BUSINESS_GETTASKREMIND;
    self.baseBusinessHttpConnect.baseUrl=API_ADDRESS;
    self.baseBusinessHttpConnect.requestPath = @"/mobile/service_test.php?action=getAllAlarmTask";
    self.baseBusinessHttpConnect.resquestType = HTTP_REQUEST_POST;
    return self;
}
@end