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
    self = [super init];
    self.businessId = BUSINESS_OTHER_CLIENTVERSION;
    self.baseBusinessHttpConnect.baseUrl=API_ADDRESS;
    self.baseBusinessHttpConnect.requestPath = [NSString stringWithFormat: @"/mobile/%@.php?action=checkversion",ACTION_PATH];
    self.baseBusinessHttpConnect.resquestType = HTTP_REQUEST_POST;
    return self;
}
@end
