//
//  TradeInfoModel.h
//  LightErector
//
//  Created by Jayden Zhao on 9/28/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "BaseDataModel.h"

@interface TradeInfo : BaseDataModel
{
@protected
     NSMutableArray *_todayTaskOrders;
     NSMutableArray *_waitForReceiveOrders;
     NSMutableArray *_waitSubOrders;
     NSMutableArray *_unTimedOrders;
     NSMutableArray *_waitForInstallOrders;
     NSMutableArray *_waitForFeedBackOrders;
     NSMutableArray *_waitForSettleOrders;
}
@property(nonatomic,readonly)NSArray *todayTaskOrders;
@property(nonatomic,readonly)NSArray *waitForReceiveOrders;
@property(nonatomic,readonly)NSArray *waitSubOrders;
@property(nonatomic,readonly)NSArray *unTimedOrders;
@property(nonatomic,readonly)NSArray *waitForInstallOrders;
@property(nonatomic,readonly)NSArray *waitForFeedBackOrders;
@property(nonatomic,readonly)NSArray *waitForSettleOrders;
@property(nonatomic,readonly,assign)int pagecount;
@property(nonatomic,readonly,assign)int recordcount;
@property(nonatomic,readonly,assign)int totalCount;
@property(nonatomic,readonly,assign)int totalPrice;
+(TradeInfo*)shareTrade;
-(void)getTodayTaskOrdersById:(int)memId withPageIndex:(int)pageindex forPagesize:(int)pagesize;
-(void)getWaitForReceiveOrdersById:(int)memId withPageIndex:(int)pageindex forPagesize:(int)pagesize;
-(void)getWaitSubOrdersById:(int)memId withPageIndex:(int)pageindex forPagesize:(int)pagesize;
-(void)getUnTimedOrdersById:(int)memId withPageIndex:(int)pageindex forPagesize:(int)pagesize;
-(void)getWaitForInstallOrdersById:(int)memId withPageIndex:(int)pageindex forPagesize:(int)pagesize;
-(void)getWaitForFeedBackOrdersById:(int)memId withPageIndex:(int)pageindex forPagesize:(int)pagesize;
-(void)getWaitForSettleOrdersById:(int)memId withPageIndex:(int)pageindex forPagesize:(int)pagesize;
@end
