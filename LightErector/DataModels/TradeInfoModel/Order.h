//
//  Order.h
//  LightErector
//
//  Created by Jayden Zhao on 9/28/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "BaseDataModel.h"

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
-(id)initWithDic:(NSDictionary *)dic;
@end
