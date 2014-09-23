//
//  BaseBusinessHttpConnect.m
//  G_NetLink
//
//  Created by Jayden Zhao on 14-3-20.
//  Copyright (c) 2014年 LightErector. All rights reserved.
//

#import "BaseBusinessHttpConnect.h"

@implementation BaseBusinessHttpConnect

- (void)createBaseBussinessHeads
{
    HttpHead * headerContentType = [[HttpHead alloc] init];
    HttpHead * headerContentEncoding = [[HttpHead alloc] init];
    
    headerContentType.headName = HEADER_CONTENT_TYPE_NAME;
    headerContentType.headValue = HEADER_CONTENT_TYPE_VALUE;
    
    headerContentEncoding.headName = HEADER_CONTENT_LENGTH_NAME;
    headerContentEncoding.headValue = HEADER_CONTENT_LENGTH_VALUE;
    
    [self.resquestHeads addObject:headerContentType];
    [self.resquestHeads addObject:headerContentEncoding];
}

////创建消息体
//- (void)createBaseBussinessHttpBody:(NSDictionary *)theParam
//{
//    NSError *theError;
//    NSMutableDictionary * BaseBusinessHttpBodyDic;
//    if(theParam!=nil)
//        BaseBusinessHttpBodyDic = [[NSMutableDictionary alloc] initWithDictionary:theParam];
//    else
//        BaseBusinessHttpBodyDic = [[NSMutableDictionary alloc] init];
//    
//    if ([self.resquestType isEqualToString:HTTP_REQUEST_POST]) {
//        if ([body isKindOfClass:[NSMutableData class]]) {
//            [(NSMutableData *)body appendData:[NSJSONSerialization dataWithJSONObject:BaseBusinessHttpBodyDic options:NSJSONWritingPrettyPrinted error:&theError]];
//        }
//    }
//}

- (void)sendWithParam:(NSDictionary *)theParam
{
    [self createBaseBussinessHeads];
    self.body=theParam;
   // [self createBaseBussinessHttpBody:theParam];
    //test
#ifdef DEBUG_LOG
    //NSString *str = [[NSString alloc] initWithData:self.body encoding:NSUTF8StringEncoding];
    NSLog(@"send:%@\n%@",self.requestPath, self.body );
#endif
    [super send];
}


@end
