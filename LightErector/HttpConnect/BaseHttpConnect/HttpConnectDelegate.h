//
//  HttpConnectDelegate.h
//  HttpConnect
//
//  Created by Jayden Zhao on 13-3-31.
//  Copyright (c) 2013年 LightErector. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpErrorCode.h"
@class BaseHttpConnect;

@protocol HttpConnectDelegate <NSObject>
-(void) willHttpConnectResquest:(BaseHttpConnect*)httpContent;
-(void) didGetHttpConnectResponseHead:(NSDictionary*)allHead;
-(void) httpConnectResponse:(BaseHttpConnect*)httpContent getByteCount:(NSInteger)byteCount;
-(void) httpConnectResponse:(BaseHttpConnect*)httpContent uploadByteCount:(NSInteger)byteCount;
-(void) didHttpConnectError:(HttpErrorCode)errorCode;
-(void) didHttpConnectFinish:(BaseHttpConnect *)httpContent;
@end
