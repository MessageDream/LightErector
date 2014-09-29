//
//  Order.m
//  LightErector
//
//  Created by Jayden Zhao on 9/28/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "Order.h"

@implementation Order
-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        _tradeId=[dic objectForKey:@"TradeId"];
        _tradeMemberid=[dic objectForKey:@"TradeMemberid"];
        _tmallname=[dic objectForKey:@"Tmallname"];
        _tradeLinkman=[dic objectForKey:@"TradeLinkman"];
        _typeProductname=[dic objectForKey:@"TypeProductname"];
        _tradeMobile=[dic objectForKey:@"TradeMobile"];
        _tradeAddress=[dic objectForKey:@"TradeAddress"];
        _tradeAprices=[dic objectForKey:@"TradeAprices"];
        _tradeContent=[dic objectForKey:@"TradeContent"];
        _tradeContent2=[dic objectForKey:@"TradeContent2"];
        _tradeMasscontent=[dic objectForKey:@"TradeMasscontent"];
        _tradeAcreated=[dic objectForKey:@"TradeAcreated"];
        _tradeKcreated=[dic objectForKey:@"TradeKcreated"];
        _tradeCompanyid=[[dic objectForKey:@"TradeCompanyid"] intValue];
        _orderType=[[dic objectForKey:@"orderType"] intValue];
        
    }
    return self;
}
@end
