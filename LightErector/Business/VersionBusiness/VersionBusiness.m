//
//  VersionBusiness.m
//  LightErector
//
//  Created by Jayden Zhao on 9/24/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "VersionBusiness.h"

@implementation VersionBusiness
-(id)init
{
    self = [super initWithNtspHeader];
    self.businessId = BUSINESS_LOGIN;
    self.baseBusinessHttpConnect.baseUrl=API_ADDRESS;
    self.baseBusinessHttpConnect.requestPath = @"/mobile/service.php?action=checkversion";
    self.baseBusinessHttpConnect.resquestType = HTTP_REQUEST_POST;
    return self;
}
@end
