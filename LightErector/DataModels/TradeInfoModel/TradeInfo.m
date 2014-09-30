//
//  TradeInfoModel.m
//  LightErector
//
//  Created by Jayden Zhao on 9/28/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "TradeInfo.h"
#import "Order.h"

@implementation TradeInfo
@synthesize todayTaskOrders=_todayTaskOrders;
@synthesize waitForReceiveOrders=_waitForReceiveOrders;
@synthesize waitSubOrders=_waitSubOrders;
@synthesize unTimedOrders=_unTimedOrders;
@synthesize waitForSettleOrders=_waitForSettleOrders;
@synthesize waitForInstallOrders=_waitForInstallOrders;
@synthesize waitForFeedBackOrders=_waitForFeedBackOrders;

+(TradeInfo*)shareTrade
{
    static TradeInfo *trade;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        trade =  [[TradeInfo alloc] init];
    });
    
    return trade;
}

-(void)getOrdersById:(NSInteger)memId andType:(OrderType)type withPageIndex:(NSInteger)pageindex forPagesize:(NSInteger)pagesize;
{
    NSDictionary *dic=[NSDictionary dictionaryWithObjects:@[@(memId),@(type),@(pageindex),@(pagesize)] forKeys:@[@"memberid",@"typeid",@"page",@"pagenum"]];
    BusinessType bsinessType;
    switch (type) {
        case TodayTaskOrder:
            bsinessType=BUSINESS_GETTODAYTASKORDER;
            break;
        case WaitForReceiveOrder:
            bsinessType=BUSINESS_GETWAITFORRECEIVEORDER;
            break;
        case WaitSubOrder:
            bsinessType=BUSINESS_GETWAITSUBORDER;
            break;
        case UnTimedOrder:
            bsinessType=BUSINESS_GETUNTIMEDORDER;
            break;
        case WaitForInstallOrder:
            bsinessType=BUSINESS_GETWAITFORINSTALLORDER;
            break;
        case WaitForFeedBackOrder:
            bsinessType=BUSINESS_GETWAITFORFEEDBACKORDER;
            break;
        case WaitForSettleOrder:
            bsinessType=BUSINESS_GETWAITFORSETTLEORDER;
            break;
        default:
            bsinessType=BUSINESS_GETTODAYTASKORDER;
            break;
    }
    [self creatBusinessWithId:bsinessType andExecuteWithData:dic];
}

-(void)getTodayTaskOrdersById:(NSInteger)memId withPageIndex:(NSInteger)pageindex forPagesize:(NSInteger)pagesize
{
    [self getOrdersById:memId andType:TodayTaskOrder withPageIndex:pageindex forPagesize:pagesize];
}

-(void)getWaitForReceiveOrdersById:(NSInteger)memId withPageIndex:(NSInteger)pageindex forPagesize:(NSInteger)pagesize
{
    [self getOrdersById:memId andType:WaitForReceiveOrder withPageIndex:pageindex forPagesize:pagesize];
}

-(void)getWaitSubOrdersById:(NSInteger)memId withPageIndex:(NSInteger)pageindex forPagesize:(NSInteger)pagesize
{
    [self getOrdersById:memId andType:WaitSubOrder withPageIndex:pageindex forPagesize:pagesize];
}

-(void)getUnTimedOrdersById:(NSInteger)memId withPageIndex:(NSInteger)pageindex forPagesize:(NSInteger)pagesize
{
    [self getOrdersById:memId andType:UnTimedOrder withPageIndex:pageindex forPagesize:pagesize];
}

-(void)getWaitForInstallOrdersById:(NSInteger)memId withPageIndex:(NSInteger)pageindex forPagesize:(NSInteger)pagesize
{
    [self getOrdersById:memId andType:WaitForInstallOrder withPageIndex:pageindex forPagesize:pagesize];
}

-(void)getWaitForFeedBackOrdersById:(NSInteger)memId withPageIndex:(NSInteger)pageindex forPagesize:(NSInteger)pagesize
{
    [self getOrdersById:memId andType:WaitForFeedBackOrder withPageIndex:pageindex forPagesize:pagesize];
}

-(void)getWaitForSettleOrdersById:(NSInteger)memId withPageIndex:(NSInteger)pageindex forPagesize:(NSInteger)pagesize
{
    [self getOrdersById:memId andType:WaitForSettleOrder withPageIndex:pageindex forPagesize:pagesize];
}

-(void)didBusinessSucess:(BaseBusiness *)business withData:(NSDictionary *)businessData
{
    NSArray *trades=[businessData objectForKey:@"tradeinfo"];
    if (trades) {
        switch (business.businessId) {
            case BUSINESS_GETTODAYTASKORDER:
                if (_todayTaskOrders==nil) {
                    _todayTaskOrders=[[NSMutableArray alloc] init];
                }
                [self wrapData:_todayTaskOrders WithData:trades];
                break;
            case BUSINESS_GETWAITFORRECEIVEORDER:
                if (_waitForReceiveOrders==nil) {
                    _waitForReceiveOrders=[[NSMutableArray alloc] init];
                }
                [self wrapData:_waitForReceiveOrders WithData:trades];
                break;
            case BUSINESS_GETWAITSUBORDER:
                if (_waitSubOrders==nil) {
                    _waitSubOrders=[[NSMutableArray alloc] init];
                }
                [self wrapData:_waitSubOrders WithData:trades];
                break;
            case BUSINESS_GETUNTIMEDORDER:
                if (_unTimedOrders==nil) {
                    _unTimedOrders=[[NSMutableArray alloc] init];
                }
                [self wrapData:_unTimedOrders WithData:trades];
                break;
            case BUSINESS_GETWAITFORINSTALLORDER:
                if (_waitForInstallOrders==nil) {
                    _waitForInstallOrders=[[NSMutableArray alloc] init];
                }
                [self wrapData:_waitForInstallOrders WithData:trades];
                break;
            case BUSINESS_GETWAITFORFEEDBACKORDER:
                if (_waitForFeedBackOrders==nil) {
                    _waitForFeedBackOrders=[[NSMutableArray alloc] init];
                }
                [self wrapData:_waitForFeedBackOrders WithData:trades];
                break;
            case BUSINESS_GETWAITFORSETTLEORDER:
                if (_waitForSettleOrders==nil) {
                    _waitForSettleOrders=[[NSMutableArray alloc] init];
                }
                [self wrapData:_waitForSettleOrders WithData:trades];
                break;
            default:
                break;
        }
    }
    [super didBusinessSucess:business withData:businessData];
}

-(void)wrapData:(NSMutableArray *)array WithData:(NSArray *)data
{
    [array removeAllObjects];
    for (NSDictionary *item in data) {
        Order *order=[[Order alloc] initWithDic:item];
        [array addObject:order];
    }
    
}

-(void)dealloc
{
    _todayTaskOrders=nil;
    _waitForReceiveOrders=nil;
    _waitSubOrders=nil;
    _unTimedOrders=nil;
    _waitForSettleOrders=nil;
    _waitForInstallOrders=nil;
    _waitForFeedBackOrders=nil;
}
@end
