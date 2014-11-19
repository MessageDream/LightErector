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
@property(nonatomic,readonly,strong)NSArray *todayTaskOrders;
@property(nonatomic,readonly,strong)NSArray *waitForReceiveOrders;
@property(nonatomic,readonly,strong)NSArray *waitSubOrders;
@property(nonatomic,readonly,strong)NSArray *unTimedOrders;
@property(nonatomic,readonly,strong)NSArray *waitForInstallOrders;
@property(nonatomic,readonly,strong)NSArray *waitForFeedBackOrders;
@property(nonatomic,readonly,strong)NSArray *waitForSettleOrders;
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
