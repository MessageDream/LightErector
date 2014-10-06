//
//  GetOrderStatusBusiness.m
//  LightErector
//
//  Created by Jayden on 14-10-5.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "GetOrderStatusBusiness.h"

@implementation GetOrderStatusBusiness
-(id)init
{
    if(self = [super initWithNtspHeader]){
        self.businessId = BUSINESS_GETORDERSTATUS;
        self.baseBusinessHttpConnect.baseUrl=API_ADDRESS;
        self.baseBusinessHttpConnect.requestPath = [NSString stringWithFormat: @"/mobile/%@.php?action=findstatus",ACTION_PATH];
        self.baseBusinessHttpConnect.resquestType = HTTP_REQUEST_POST;
    }
    return self;
}

- (void)errorCodeFromResponse:(NSDictionary *)theResponseBody
{
    if (theResponseBody) {
        if ([theResponseBody isKindOfClass:[NSDictionary class]]) {
            //附加部分，具体根据接口判断
                _errCode=[[theResponseBody objectForKey:@"result"] intValue];
        }
    }
    switch (_errCode) {
        case 0:
            self.businessErrorType = REQUEST_USER_ERROR;
            _errmsg=@"查询订单状态失败";
            break;
        case NO_ERROR :
            self.businessErrorType = REQUEST_NOERROR;
            break;
        default:
            break;
    }
}
@end
