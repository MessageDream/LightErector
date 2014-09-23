//
//  DataModuleDelegate.h
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessType.h"
@class BaseDataModule;

@protocol DataModuleDelegate <NSObject>
-(void)didDataModuleNoticeSucess:(BaseDataModule*)baseDataModule forBusinessType:( BusinessType)businessID;
-(void)didDataModuleNoticeFail:(BaseDataModule*)baseDataModule forBusinessType:(BusinessType)businessID forErrorCode:(NSInteger)errorCode forErrorMsg:(NSString*)errorMsg;
@end


@protocol DataModuleTransferFileDelegate <NSObject>
-(void)didDataModuleNoticeDownLoadFileing:(BaseDataModule*)baseDataModule forByteCount:(long long)byteCount forTotalByteCount:(long long)totalByteCount;
@end