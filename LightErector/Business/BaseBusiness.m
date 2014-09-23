//
//  BaseBusiness.m
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "BaseBusiness.h"
#import "BaseBusinessHttpConnect.h"
#import "HttpErrorCodeManager.h"

@implementation BaseBusiness
@synthesize businessId = _businessId;
@synthesize businessErrorType = _businessErrorType;
@synthesize baseBusinessHttpConnect = _baseBusinessHttpConnect;
@synthesize errmsg = _errmsg;
@synthesize errCode = _errCode;

- (id)init
{
    if (self = [super init]) {
        self.baseBusinessHttpConnect = [[BaseBusinessHttpConnect alloc] init];
    }
    return self;
}



- (void)execute:(NSDictionary *)theParm
{
    if(theParm!=nil)//可能有无参数的情况
    {
        if (![NSJSONSerialization isValidJSONObject:theParm])
            return;
    }
    
    if (self.baseBusinessHttpConnect) {
        self.baseBusinessHttpConnect.observer = self;
        [self.baseBusinessHttpConnect sendWithParam:theParm];
    }
}

- (void)cancel
{
    if (self.baseBusinessHttpConnect) {
        [self.baseBusinessHttpConnect cancel];
    }
}

//简单解析为dic
- (NSDictionary *)parseBaseBusinessHttpConnectResponseData
{
    NSError * error;
    if (self.baseBusinessHttpConnect.respones.responesData) {
        return [NSJSONSerialization JSONObjectWithData:self.baseBusinessHttpConnect.respones.responesData options:NSJSONReadingMutableContainers error:&error];
    }else{
        return nil;
    }
}


//获取错误码
- (void)errorCodeFromResponse:(NSDictionary *)theResponseBody
{
    if (theResponseBody) {
        if ([theResponseBody isKindOfClass:[NSDictionary class]]) {
            _errCode = [[theResponseBody objectForKey:@"error_code"] integerValue];
            _errmsg = [theResponseBody objectForKey:@"error"];
        }
    }
    switch (_errCode) {
        case NO_ERROR:
            self.businessErrorType = REQUEST_NOERROR;
            break;
        case TIME_ERROR:
            self.businessErrorType = REQUEST_TIME_ERROR;
            break;
        case SYSTEM_ERROR:
            self.businessErrorType = REQUEST_SYSTEM_ERROR;
            break;
        case AUTH_ERROR:
            self.businessErrorType = REQUEST_AUTH_ERROR;
            break;
        case PARAM_ERROR:
            self.businessErrorType = REQUEST_PARAM_ERROR;
            break;
        default:
            break;
    }
}

-(void) willHttpConnectResquest:(BaseHttpConnect*)httpContent
{
}

-(void) httpConnectResponse:(BaseHttpConnect*)httpContent GetByteCount:(NSInteger)byteCount
{
}

-(void)didGetHttpConnectResponseHead:(NSDictionary*)allHead
{
    
}

-(void)httpConnectResponse:(BaseHttpConnect *)httpContent getByteCount:(NSInteger)byteCount
{
}

-(void)httpConnectResponse:(BaseHttpConnect *)httpContent uploadByteCount:(NSInteger)byteCount
{

}

-(void) didHttpConnectError:(enum HttpErrorCode)errorCode
{
    if (self.businessObserver)
    {
        _errmsg = [HttpErrorCodeManager getDesFromErrorCode:errorCode];
        [self.businessObserver didBusinessError:self];
    }
}

-(void) didHttpConnectFinish:(BaseHttpConnect *)httpContent
{
 
    
    NSDictionary * responseBodyDic = [self parseBaseBusinessHttpConnectResponseData];
    
    
#ifdef DEBUG_LOG
    NSLog(@"rece:%@",responseBodyDic);
#endif
    if (responseBodyDic) {
        [self errorCodeFromResponse:responseBodyDic];
        if(_errCode == REQUEST_NOERROR)
            
            
        {
            //不需要"errcode"和"errmsg"的数据，数据通过getNtspHeaderFromBaseBusinessHttpConnectResponseData取得
            [((NSMutableDictionary*)responseBodyDic) removeObjectForKey:@"error_code"];
            [((NSMutableDictionary*)responseBodyDic) removeObjectForKey:@"error"];
        }
        else if(_errCode >= TIME_ERROR || _errCode <= REQUEST_PARAM_ERROR)
        {
            [self.businessObserver didBusinessError:self];
            return;
        }
    }
    [self.businessObserver didBusinessSucess:self withData:responseBodyDic];
}


-(void)dealloc
{
    self.baseBusinessHttpConnect.observer = nil;
}
@end
