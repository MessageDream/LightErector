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

-(void)getOrderInstallStatus
{
     NSDictionary *dic=[NSDictionary dictionaryWithObject:self.tradeId forKey:@"tradeid"];
     [self creatBusinessWithId:BUSINESS_GETORDERSTATUS andExecuteWithData:dic];
}

-(void)updateOrderStatusWithMemberId:(NSInteger)memId flowStatus:(InstallFlowStatus)installStatus;
{
 NSDictionary *dic=[NSDictionary dictionaryWithObjects:@[@(memId),@(installStatus),self.tradeId,self.tradeMobile] forKeys:@[@"memberid",@"typeid",@"tradeid",@"cusmobile"]];
    [self creatBusinessWithId:BUSINESS_UPDATEORDERSTATUS andExecuteWithData:dic];
}


-(void)installErrorFeedback:(NSString *)errinfo
{
    NSDictionary *dic=[NSDictionary dictionaryWithObjects:@[self.tradeId,errinfo] forKeys:@[@"errorinfo",@"tradeid"]];
    [self creatBusinessWithId:BUSINESS_INSTALLERRORFEEDBACK andExecuteWithData:dic];
}

-(void)acceptOrderWithMemberId:(NSInteger)memId
{
    NSDictionary *dic=[NSDictionary dictionaryWithObjects:@[@(memId),self.tradeId] forKeys:@[@"memberid",@"tradeid"]];
    [self creatBusinessWithId:BUSINESS_ACCEPTORDER andExecuteWithData:dic];
}

-(void)updateSubStatusWithMemberId:(NSInteger)memId isSpeek:(BOOL)speek acreated:(NSDate*)acreated
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObjects:@[@(memId),self.tradeId] forKeys:@[@"memberid",@"tradeid"]];
    
    if (!speek) {
         [dic setObject:@(1) forKey:@"nospeak"];
    }if (acreated) {
        [dic setObject:acreated forKey:@"acreated"];
    }
    [self creatBusinessWithId:BUSINESS_ACCEPTORDER andExecuteWithData:dic];
}

-(void)updateSubTime:(NSDate *)time withReason:(NSString *)reason withMemberId:(NSInteger)memId
{
    NSDictionary *dic=[NSDictionary dictionaryWithObjects:@[@(memId),self.tradeId,time,reason] forKeys:@[@"memberid",@"tradeid",@"acreated",@"upcontent"]];
    [self creatBusinessWithId:BUSINESS_UPDATESUBTIME andExecuteWithData:dic];
}


//BUSINESS_UPLOADIMAGE,
-(void)uploadCode:(NSString *)code
{
    NSDictionary *dic=[NSDictionary dictionaryWithObjects:@[self.tradeId,@([code intValue])] forKeys:@[@"tradeid",@"verify"]];
    [self creatBusinessWithId:BUSINESS_UPLOADCODE andExecuteWithData:dic];

}

-(void)uploadImage:(NSData *)file withType:(NSInteger)type withMemberId:(NSInteger)memId
{
    NSDictionary *dic=[NSDictionary dictionaryWithObjects:@[@(memId),self.tradeId,[NSDate date],@(type),file] forKeys:@[@"memberid",@"tradeid",@"created",@"typeid",@"file"]];
    [self creatBusinessWithId:BUSINESS_UPDATESUBTIME andExecuteWithData:dic];
}

-(void)didBusinessSucess:(BaseBusiness *)business withData:(NSDictionary *)businessData
{
     switch (business.businessId) {
        case BUSINESS_GETORDERSTATUS:
             _installStatus=[[businessData objectForKey:@"result"] intValue];
            break;
        case BUSINESS_UPDATEORDERSTATUS:
            break;
        default:
            break;
    }
    [super didBusinessSucess:business withData:businessData];
}
@end
