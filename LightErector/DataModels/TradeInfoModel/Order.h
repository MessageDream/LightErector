//
//  Order.h
//  LightErector
//
//  Created by Jayden Zhao on 9/28/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "BaseDataModel.h"
typedef NS_ENUM(NSInteger, OrderType) {
    TodayTaskOrder=1,        //1今日任务
    WaitForReceiveOrder,           // 2最新待接单订单
    WaitSubOrder,       // 3待预约订单
    UnTimedOrder,       // 4已预约但未确定时间(再预约列表)
    WaitForInstallOrder,     //5待安装订单
    WaitForFeedBackOrder,    //6完成待反馈订单
    WaitForSettleOrder,      //7待结算订单列表
};

typedef NS_ENUM(NSInteger, InstallFlowStatus) {
    InitialStatus=1,        //1 初始状态
    UnValidateStatus,           // 2待验证
    UnFeedBackStatus,       // 3待反馈传图
    UnSettleStatus,       // 4待结算
    InstallFailStatus   //安装失败
};

@interface Order : BaseDataModel
@property (nonatomic,readonly)NSString  *tradeId;
@property (nonatomic,readonly)NSString  *tradeMemberid;
@property (nonatomic,readonly)NSString  *tmallname;
@property (nonatomic,readonly)NSString  *tradeLinkman;
@property (nonatomic,readonly)NSString  *typeProductname;
@property (nonatomic,readonly)NSString  *tradeMobile;
@property (nonatomic,readonly)NSString  *tradeAddress;
@property (nonatomic,readonly)NSString  *tradeAprices;
@property (nonatomic,readonly)NSString  *tradeContent;
@property (nonatomic,readonly)NSString  *tradeContent2;
@property (nonatomic,readonly)NSString  *tradeMasscontent;
@property (nonatomic,readonly)NSString  *tradeAcreated;
@property (nonatomic,readonly)NSString  *tradeKcreated;
@property (nonatomic,readonly)NSInteger tradeCompanyid;
@property (nonatomic,readonly)OrderType orderType;
@property (nonatomic,readonly)InstallFlowStatus installStatus;
-(id)initWithDic:(NSDictionary *)dic;
-(void)getOrderInstallStatus;
-(void)updateOrderStatusWithMemberId:(NSInteger)memId flowStatus:(InstallFlowStatus)installStatus;

-(void)installErrorFeedback:(NSString *)errinfo;

-(void)acceptOrderWithMemberId:(NSInteger)memId;
-(void)updateSubStatusWithMemberId:(NSInteger)memId isSpeek:(BOOL) speek  acreated:(NSDate*)acreated;
-(void)updateSubTime:(NSDate *)time withReason:(NSString *)reason withMemberId:(NSInteger)memId;
-(void)uploadCode:(NSString *)code;
-(void)uploadImage:(NSDictionary *)pics withMemberId:(NSInteger)memId;
@end
