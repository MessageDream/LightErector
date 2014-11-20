//
//  InstallErrorFeedbackBusiness.m
//  LightErector
//
//  Created by Jayden on 14-10-6.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "InstallErrorFeedbackBusiness.h"

@implementation InstallErrorFeedbackBusiness
-(id)init
{
    if(self = [super init]){
        self.businessId = BUSINESS_INSTALLERRORFEEDBACK;
        self.baseBusinessHttpConnect.baseUrl=API_ADDRESS;
        self.baseBusinessHttpConnect.requestPath = [NSString stringWithFormat: @"/mobile/%@.php?action=tradeerror",ACTION_PATH];
        self.baseBusinessHttpConnect.resquestType = HTTP_REQUEST_POST;
    }
    return self;
}
@end
