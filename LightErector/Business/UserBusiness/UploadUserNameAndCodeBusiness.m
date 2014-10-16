//
//  UploadUserNameAndCodeBusiness.m
//  LightErector
//
//  Created by Jayden Zhao on 10/16/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "UploadUserNameAndCodeBusiness.h"

@implementation UploadUserNameAndCodeBusiness
-(id)init
{
    self = [super initWithNtspHeader];
    self.businessId = BUSINESS_UPLOADNAMEANDCODE;
    self.baseBusinessHttpConnect.baseUrl=API_ADDRESS;
    self.baseBusinessHttpConnect.requestPath = [NSString stringWithFormat: @"/mobile/%@.php?action=findpwd",ACTION_PATH];
    self.baseBusinessHttpConnect.resquestType = HTTP_REQUEST_POST;
    return self;
}
@end
