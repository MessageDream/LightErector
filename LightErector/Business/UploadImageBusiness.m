//
//  UploadImageBusiness.m
//  LightErector
//
//  Created by Jayden on 14-10-6.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "UploadImageBusiness.h"

@implementation UploadImageBusiness
-(id)init
{
    if(self = [super initWithNtspHeader]){
        [self.baseBusinessHttpConnect.resquestHeads setValue:HEADER_CONTENT_TYPE_Form_VALUE forKey:HEADER_CONTENT_TYPE_NAME];
        self.businessId = BUSINESS_UPLOADIMAGE;
        self.baseBusinessHttpConnect.baseUrl=API_ADDRESS;
        self.baseBusinessHttpConnect.requestPath = [NSString stringWithFormat: @"/mobile/%@.php?action=upload",ACTION_PATH];
        self.baseBusinessHttpConnect.resquestType = HTTP_REQUEST_POST;
    }
    return self;
}
@end
