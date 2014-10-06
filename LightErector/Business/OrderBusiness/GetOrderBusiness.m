//
//  GetOrderBusiness.m
//  LightErector
//
//  Created by Jayden Zhao on 9/29/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "GetOrderBusiness.h"

@implementation GetOrderBusiness
-(id)initWithBusinessId:(BusinessType)businessid
{
    if(self = [super initWithNtspHeader]){
    self.businessId = businessid;
    self.baseBusinessHttpConnect.baseUrl=API_ADDRESS;
    self.baseBusinessHttpConnect.requestPath = [NSString stringWithFormat: @"/mobile/%@.php?action=list",ACTION_PATH];
    self.baseBusinessHttpConnect.resquestType = HTTP_REQUEST_POST;
    }
    return self;
}
@end
