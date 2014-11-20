//
//  ChangePwdBusiness.m
//  LightErector
//
//  Created by Jayden Zhao on 10/16/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "ChangePwdBusiness.h"

@implementation ChangePwdBusiness
-(id)init
{
    self = [super init];
    self.businessId = BUSINESS_CHANGEPWD;
    self.baseBusinessHttpConnect.baseUrl=API_ADDRESS;
    self.baseBusinessHttpConnect.requestPath = [NSString stringWithFormat: @"/mobile/%@.php?action=updatepwd",ACTION_PATH];
    self.baseBusinessHttpConnect.resquestType = HTTP_REQUEST_POST;
    return self;
}
@end
