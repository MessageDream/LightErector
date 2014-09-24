//
//  UserBusiness.m
//  LightErector
//
//  Created by Jayden Zhao on 9/24/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "UserLoginBusiness.h"

@implementation UserLoginBusiness

-(id)init
{
    self = [super initWithNtspHeader];
    self.businessId = BUSINESS_LOGIN;
    self.baseBusinessHttpConnect.baseUrl=API_ADDRESS;
    self.baseBusinessHttpConnect.requestPath = @"/mobile/service_test.php?action=checklogin";
    self.baseBusinessHttpConnect.resquestType = HTTP_REQUEST_POST;
    return self;
}
@end
