//
//  BaseDataModel.m
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "BaseDataModel.h"
#import "BusinessFactory.h"

@implementation BaseDataModel

- (void)creatBusinessWithId:(NSInteger)businessId andExecuteWithData:(NSDictionary *)dic
{
    [self creatBusinessWithId:businessId andObserver:self andExecuteWithData:dic];
}

- (void)creatBusinessWithId:(NSInteger)businessId andObserver:(id<BusinessProtocol>)observer andExecuteWithData:(NSDictionary *)dic
{
    baseBusiness = [BusinessFactory createBusiness:businessId];
    baseBusiness.businessObserver = observer;
    [baseBusiness execute:dic];
}
-(void)parseData:(NSData *)data{
    
}

#pragma mark - BusinessProtocol
- (void)didBusinessSucess:(BaseBusiness *)business withData:(NSDictionary *)businessData
{
    if (!self.observer||![self.observer respondsToSelector:@selector(didDataModelNoticeSucess:forBusinessType:)]) {
        return;
    }
    [self.observer didDataModelNoticeSucess:self forBusinessType:business.businessId];
    
    if(baseBusiness.baseBusinessHttpConnect.stauts==HttpContentStauts_DidStop || baseBusiness.baseBusinessHttpConnect.stauts == HttpContentStauts_DidFinishRespones)
        baseBusiness = nil;
}
- (void)didBusinessFail 
{
    if (!self.observer||![self.observer respondsToSelector:@selector(didDataModelNoticeFail:forBusinessType:forErrorCode:forErrorMsg:)]) {
        return;
    }
    [self.observer didDataModelNoticeFail:self forBusinessType:baseBusiness.businessId forErrorCode:-1 forErrorMsg:nil];
    
    if(baseBusiness.baseBusinessHttpConnect.stauts==HttpContentStauts_DidStop || baseBusiness.baseBusinessHttpConnect.stauts == HttpContentStauts_DidFinishRespones)
        baseBusiness = nil;
}
- (void)didBusinessError:(BaseBusiness *)business
{
    if (!self.observer||![self.observer respondsToSelector:@selector(didDataModelNoticeFail:forBusinessType:forErrorCode:forErrorMsg:)]) {
        return;
    }
    [self.observer didDataModelNoticeFail:self forBusinessType:business.businessId forErrorCode:business.errCode forErrorMsg:business.errmsg];
    
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
