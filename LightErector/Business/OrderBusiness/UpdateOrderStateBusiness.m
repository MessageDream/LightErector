//
//  UpdateOrderStateBusiness.m
//  LightErector
//
//  Created by Jayden Zhao on 9/29/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "UpdateOrderStateBusiness.h"

@implementation UpdateOrderStateBusiness
-(id)init
{
    if(self = [super initWithNtspHeader]){
        self.businessId = BUSINESS_UPDATEORDERSTATUS;
        self.baseBusinessHttpConnect.baseUrl=API_ADDRESS;
        self.baseBusinessHttpConnect.requestPath = [NSString stringWithFormat: @"/mobile/%@.php?action=done",ACTION_PATH];
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
            _errmsg=@"更新订单状态失败";
            break;
        case NO_ERROR :
            self.businessErrorType = REQUEST_NOERROR;
            break;
        default:
            break;
    }
}
@end
