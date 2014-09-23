//
//  BusinessHttpConnectWithNtspHeader.m
//  LightErector
//
//  Created by Jayden Zhao on 13-4-8.
//  Copyright (c) 2013年 LightErector. All rights reserved.
//

#import "BusinessHttpConnectWithNtspHeader.h"
#import "NtspHeader.h"

@implementation BusinessHttpConnectWithNtspHeader

-(id)init
{
    if(self=[super init]){
        self.ntspHeader=[NtspHeader shareHeader];
    }
    return self;
}


//创建消息体
- (void)createBaseBussinessHttpBody:(NSDictionary *)theParam
{
    NSMutableDictionary * baseBusinessHttpParamDic;
    if(theParam!=nil)
        baseBusinessHttpParamDic = [[NSMutableDictionary alloc] initWithDictionary:theParam];
    else
        baseBusinessHttpParamDic = [[NSMutableDictionary alloc] init];
    if (self.ntspHeader != nil){
        [baseBusinessHttpParamDic setObject:[self.ntspHeader toDicValue] forKey:@"ntspheader"];
    }
    self.body=baseBusinessHttpParamDic;
    
    //    NSMutableDictionary * baseBusinessHttpParamDic;
    //    if(theParam!=nil)
    //        baseBusinessHttpParamDic = [[NSMutableDictionary alloc] initWithDictionary:theParam];
    //    else
    //        baseBusinessHttpParamDic = [[NSMutableDictionary alloc] init];
    //
    //    if ([self.resquestType isEqualToString:HTTP_REQUEST_POST]) {
    //        if (self.ntspHeader != nil){
    //            [baseBusinessHttpParamDic setObject:[self.ntspHeader toDicValue] forKey:@"ntspheader"];
    //        }
    //        self.body=baseBusinessHttpParamDic;
    //    }else if([self.resquestType isEqualToString:HTTP_REQUEST_GET]){
    //        [self setUrlParam:baseBusinessHttpParamDic];
    //    }
}
@end
