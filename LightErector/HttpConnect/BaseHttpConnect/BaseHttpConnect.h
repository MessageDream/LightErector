//
//  BaseHttpConnect.h
//  HttpConnect
//
//  Created by Jayden Zhao on 13-3-31.
//  Copyright (c) 2013年 LightErector. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "HttpHead.h"
#import "HttpConnectRespones.h"
#import "HttpConnectDelegate.h"
#import "HttpErrorCode.h"

#define HTTP_REQUEST_GET  @"GET"
#define HTTP_REQUEST_POST @"POST"
#define CONNECT_DEFAULT_TIMEOUT     30
#define NO_TIMEOUT     -1

#define kFormMltipart @"FormMltipart"
#define kNetCachePolicy  NSURLRequestReloadIgnoringLocalAndRemoteCacheData
#define kNetMaxQueue 0

typedef NS_ENUM(NSUInteger,FormMltipartType){
    FormMltipartTypeFilePath=0,
    FormMltipartTypeData=1,
    FormMltipartTypeNormal=2,
};


typedef NS_ENUM(NSUInteger , HttpContentStauts){
    HttpContentStauts_DidStart = 1,
    HttpContentStauts_DidStop,
    HttpContentStauts_WillStart,
    HttpContentStauts_WillStop,
    HttpContentStauts_WillRespones,
    HttpContentStauts_DidRespones,
    HttpContentStauts_DidFinishRespones,
};

@interface FormMltipart : NSObject
@property(nonatomic,copy)NSString *formName;
@property(nonatomic,copy)NSString *formMimeType;
@property(nonatomic,copy)NSString *formFileName;
@property(nonatomic) FormMltipartType type;
@property(nonatomic,strong)id data;
@end

@interface BaseHttpConnect : NSObject
{
    int _timeOut;
    NSString *_baseUrl;
    NSString *_requestPath;
    NSMutableArray *_resquestHeads;
    NSDictionary *_body;
    NSString *_resquestType;
    HttpConnectRespones *_respones;
    AFHTTPRequestOperation *_requestOperation;
    NSURLConnection *_connection;
    HttpContentStauts _stauts;
    NSInteger _errorCode;
    void (^_success)(AFHTTPRequestOperation *operation, id responseObject);
    void (^_failure)(AFHTTPRequestOperation *operation, NSError *error);
    void (^_downloadProcess)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead);
    void (^_uploadProcess)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite);
}
@property int timeOut;
@property(readonly) NSInteger errorCode;
@property (nonatomic,readonly) HttpContentStauts stauts;
@property(nonatomic,copy)NSString *baseUrl;
@property(nonatomic,copy)NSString *requestPath;
@property(nonatomic,readonly)NSMutableArray *resquestHeads;//HttpHead Type
@property(nonatomic,strong)NSDictionary * body;
@property(nonatomic,copy)NSString *resquestType;
@property(nonatomic,readonly)HttpConnectRespones *respones;
@property(nonatomic,readonly)AFHTTPRequestOperation *requestOperation;
@property(nonatomic,assign)id<HttpConnectDelegate> observer;

-(void)send;
-(void)cancel;
- (void)closeConnect;
@end
