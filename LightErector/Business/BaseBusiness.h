//
//  BaseBusiness.h
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

typedef NS_ENUM(NSInteger, BusinessErrorType)
{
    //    201	接口处理超时。
    //    202	必需的参数为空。
    //    203	系统错误。
    //    204	参数错误。
    //    8001	令牌失效
    
    REQUEST_NOERROR=1,
    REQUEST_TIME_ERROR=201,
    REQUEST_PARAMNULL_ERROR=202,
    REQUEST_SYSTEM_ERROR=203,
    REQUEST_PARAM_ERROR=204,
    REQUEST_AUTH_ERROR=8001,
    
};

#import <Foundation/Foundation.h>
#import "HttpConnectDelegate.h"
#import "BaseBusinessHttpConnect.h"
#import "HttpConnectDefineData.h"
#import "BusinessType.h"

@class BaseBusiness;

@protocol DownLoadBusinessProtocl <NSObject>
-(void)didDownLoadFileOfByteCount:(BaseBusiness *)business forByteCount:(long long)byteCount forTotalByteCount:(long long)totalByteCount;
@end

@protocol BusinessProtocl <NSObject>

- (void)didBusinessSucess:(BaseBusiness *)business withData:(NSDictionary*)businessData;
- (void)didBusinessFail;
- (void)didBusinessError:(BaseBusiness *)business;
@end

@interface BaseBusiness : NSObject<HttpConnectDelegate>
{
@protected
    NSInteger _errCode;
    NSString *_errmsg;
    int _businessId;
    BusinessErrorType _businessErrorType;
    BaseBusinessHttpConnect *_baseBusinessHttpConnect;
    
}

@property(nonatomic) int businessId;
@property(nonatomic,assign) id<BusinessProtocl>businessObserver;
@property(nonatomic)BusinessErrorType businessErrorType;
@property(nonatomic,strong) BaseBusinessHttpConnect * baseBusinessHttpConnect;
@property(nonatomic,readonly)NSString *errmsg;
@property(nonatomic,readonly)NSInteger errCode;

- (id)initWithNtspHeader;
//执行网络请求
- (void)execute:(NSDictionary *)param;

//取消请求
- (void)cancel;

//解析返回数据
- (NSDictionary *)parseBaseBusinessHttpConnectResponseData;


//获取错误码
- (void)errorCodeFromResponse:(NSDictionary *)theResponseBody;
@end

