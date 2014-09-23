//
//  HttpStautsCode.m
//  LightErector
//
//  Created by Jayden Zhao on 13-4-27.
//  Copyright (c) 2013年 LightErector. All rights reserved.
//

#import "HttpErrorCodeManager.h"
#import "ResDefine.h"

@implementation HttpErrorCodeManager

+(NSString*)getDesFromErrorCode:(HttpErrorCode)code
{
    if(code == HttpErrorCode_TimerOut)
        return NSLocalizedStringFromTable(@"HttpError2",Res_String,@"");
    else if(code == HttpErrorCode_WriteFileFail)
        return NSLocalizedStringFromTable(@"HttpError3",Res_String,@"");
    else if(code == HttpErrorCode_NetworkFail)
        return NSLocalizedStringFromTable(@"HttpError4",Res_String,@"");
    
    return NSLocalizedStringFromTable(@"HttpError1",Res_String,@"");
}
@end
