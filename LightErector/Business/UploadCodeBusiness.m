//
//  UploadCodeBusiness.m
//  LightErector
//
//  Created by Jayden on 14-10-6.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "UploadCodeBusiness.h"

@implementation UploadCodeBusiness
-(id)init
{
    if(self = [super initWithNtspHeader]){
        self.businessId = BUSINESS_UPLOADCODE;
        self.baseBusinessHttpConnect.baseUrl=API_ADDRESS;
        self.baseBusinessHttpConnect.requestPath = [NSString stringWithFormat: @"/mobile/%@.php?action=alldone",ACTION_PATH];
        self.baseBusinessHttpConnect.resquestType = HTTP_REQUEST_POST;
    }
    return self;
}
@end
