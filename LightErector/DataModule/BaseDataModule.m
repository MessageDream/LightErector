//
//  BaseDataModule.m
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "BaseDataModule.h"
#import "BusinessFactory.h"

@implementation BaseDataModule

- (void)creatBusinessWithId:(NSInteger)businessId andExecuteWithData:(NSDictionary *)dic
{
    [self creatBusinessWithId:businessId andObserver:self andExecuteWithData:dic];
}

- (void)creatBusinessWithId:(NSInteger)businessId andObserver:(id<BusinessProtocl>)observer andExecuteWithData:(NSDictionary *)dic
{
    baseBusiness = [BusinessFactory createBusiness:businessId];
    baseBusiness.businessObserver = observer;
    [baseBusiness execute:dic];
}
-(void)parseData:(NSData *)data{
    
}

#pragma mark - BusinessProtocl
- (void)didBusinessSucess:(BaseBusiness *)business withData:(NSDictionary *)businessData
{
    [self.observer didDataModuleNoticeSucess:self forBusinessType:business.businessId];
    
    if(baseBusiness.baseBusinessHttpConnect.stauts==HttpContentStauts_DidStop || baseBusiness.baseBusinessHttpConnect.stauts == HttpContentStauts_DidFinishRespones)
        baseBusiness = nil;
}
- (void)didBusinessFail 
{
    [self.observer didDataModuleNoticeFail:self forBusinessType:baseBusiness.businessId forErrorCode:-1 forErrorMsg:nil];
    
    if(baseBusiness.baseBusinessHttpConnect.stauts==HttpContentStauts_DidStop || baseBusiness.baseBusinessHttpConnect.stauts == HttpContentStauts_DidFinishRespones)
        baseBusiness = nil;
}
- (void)didBusinessError:(BaseBusiness *)business
{
    [self.observer didDataModuleNoticeFail:self forBusinessType:business.businessId forErrorCode:business.errCode forErrorMsg:business.errmsg];
    
    if(baseBusiness.baseBusinessHttpConnect.stauts==HttpContentStauts_DidStop || baseBusiness.baseBusinessHttpConnect.stauts == HttpContentStauts_DidFinishRespones)
        baseBusiness = nil;
}
-(void)dealloc
{
    if(baseBusiness!=nil)
    {
        baseBusiness.businessObserver = nil;
        [baseBusiness cancel];
    }
}
@end
