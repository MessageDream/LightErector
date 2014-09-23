//
//  BaseBusinessHttpConnect.h
//  G_NetLink
//
//  Created by Jayden Zhao on 14-3-20.
//  Copyright (c) 2014年 LightErector. All rights reserved.
//

#define HEADER_CONTENT_TYPE_NAME      @"Content-Type"
#define HEADER_CONTENT_TYPE_VALUE     @"application/json;charset=utf-8"

#define HEADER_CONTENT_LENGTH_NAME      @"Content-Length"
#define HEADER_CONTENT_LENGTH_VALUE     @"0"

#import "FileHttpConnect.h"

@interface BaseBusinessHttpConnect : FileHttpConnect

@property(nonatomic) int baseBussinessHttpConnectId;

- (void)sendWithParam:(NSDictionary *)param;
@end
