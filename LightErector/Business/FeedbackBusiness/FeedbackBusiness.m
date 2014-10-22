//
//  FeedbackBusiness.m
//  LightErector
//
//  Created by Jayden Zhao on 10/22/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "FeedbackBusiness.h"

@implementation FeedbackBusiness
-(id)init
{
    self = [super initWithNtspHeader];
    self.businessId = BUSINESS_OTHER_FEEDBACK;
    self.baseBusinessHttpConnect.baseUrl=API_ADDRESS;
    self.baseBusinessHttpConnect.requestPath = [NSString stringWithFormat: @"/mobile/%@.php?action=opinion",ACTION_PATH];
    self.baseBusinessHttpConnect.resquestType = HTTP_REQUEST_POST;
    return self;
}
@end
