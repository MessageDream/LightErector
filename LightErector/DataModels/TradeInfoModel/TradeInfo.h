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
    NSMutableArray *_orders;
}
@property(nonatomic,readonly)NSArray *orders;
@property(nonatomic,readonly,assign)int pagecount;
@property(nonatomic,readonly,assign)int recordcount;
-(void)getOrdersById:(int)menId withPageIndex:(int)pageindex forpagesize:(int)pagesize;
@end
