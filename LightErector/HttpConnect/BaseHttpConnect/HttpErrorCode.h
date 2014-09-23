//
//  HttpErrorCode.h
//  LightErector
//
//  Created by Jayden Zhao on 13-4-27.
//  Copyright (c) 2013年 LightErector. All rights reserved.
//

#ifndef HttpErrorCode_h
#define HttpErrorCode_h

typedef NS_ENUM(NSUInteger, HttpErrorCode){
    HttpErrorCode_NetworkFail = -1004,
    HttpErrorCode_None = 200,
    HttpErrorCode_TimerOut = 10,
    HttpErrorCode_WriteFileFail,
};

#endif
