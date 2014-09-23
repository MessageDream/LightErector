//
//  HttpStautsCode.h
//  LightErector
//
//  Created by Jayden Zhao on 13-4-27.
//  Copyright (c) 2013年 LightErector. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpErrorCode.h"
@interface HttpErrorCodeManager : NSObject
+(NSString*)getDesFromErrorCode:(HttpErrorCode)code;
@end
