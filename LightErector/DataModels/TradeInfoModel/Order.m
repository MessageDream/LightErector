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
        if ([dic objectForKey:@"TradeAprices"]) {
           _tradeAprices=[NSString stringWithFormat:@"%d",[[dic objectForKey:@"TradeAprices"] intValue]];
        }
       
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
    NSDictionary *dic=[NSDictionary dictionaryWithObjects:@[self.tradeId,errinfo] forKeys:@[@"tradeid",@"errorinfo"]];
    [self creatBusinessWithId:BUSINESS_INSTALLERRORFEEDBACK andExecuteWithData:dic];
}

-(void)acceptOrderWithMemberId:(NSInteger)memId
{
    NSDictionary *dic=[NSDictionary dictionaryWithObjects:@[@(memId),self.tradeId] forKeys:@[@"memberid",@"tradeid"]];
    [self creatBusinessWithId:BUSINESS_ACCEPTORDER andExecuteWithData:dic];
}

-(void)updateSubStatusWithMemberId:(NSInteger)memId isSpeek:(BOOL)speek acreated:(NSString*)acreated
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObjects:@[@(memId),self.tradeId] forKeys:@[@"memberid",@"tradeid"]];
    
    _orderType=WaitSubOrder;
    if (!speek) {
         [dic setObject:@(1) forKey:@"nospeak"];
    }if (acreated) {
        [dic setObject:acreated forKey:@"acreated"];
        _orderType=WaitForInstallOrder;
    }
    [self creatBusinessWithId:BUSINESS_ACCEPTORDER andExecuteWithData:dic];
}

-(void)updateSubTime:(NSDate *)time withReason:(NSString *)reason withMemberId:(NSInteger)memId
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:time];
    
    _tradeAcreated=destDateString;
    NSDictionary *dic=[NSDictionary dictionaryWithObjects:@[@(memId),self.tradeId,destDateString,reason] forKeys:@[@"memberid",@"tradeid",@"acreated",@"upcontent"]];
    [self creatBusinessWithId:BUSINESS_UPDATESUBTIME andExecuteWithData:dic];
}



-(void)uploadCode:(NSString *)code
{
    NSDictionary *dic=[NSDictionary dictionaryWithObjects:@[self.tradeId,@([code intValue])] forKeys:@[@"tradeid",@"verify"]];
    [self creatBusinessWithId:BUSINESS_UPLOADCODE andExecuteWithData:dic];

}


-(void)uploadImage:(NSDictionary *)pics withMemberId:(NSInteger)memId
{
    NSDictionary *dic=[NSDictionary dictionaryWithObjects:@[@(memId),self.tradeId,[NSDate date],([pics allValues][0])] forKeys:@[@"memberid",@"tradeid",@"created",([pics allKeys][0])]];
    [self creatBusinessWithId:BUSINESS_UPLOADIMAGE andExecuteWithData:dic];
}

-(void)didBusinessSucess:(BaseBusiness *)business withData:(NSDictionary *)businessData
{
     switch (business.businessId) {
        case BUSINESS_GETORDERSTATUS:
             _installStatus=[[businessData objectForKey:@"status"] intValue];
            break;
        case BUSINESS_UPDATEORDERSTATUS:
            break;
        case BUSINESS_ACCEPTORDER:
             break;
         case BUSINESS_UPDATESUBTIME:
             break;
        default:
            break;
    }
    [super didBusinessSucess:business withData:businessData];
}
@end
