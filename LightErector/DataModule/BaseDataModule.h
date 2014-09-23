//
//  BaseDataModule.h
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModuleDelegate.h"

#import "BaseBusiness.h"
@interface BaseDataModule : NSObject<BusinessProtocl>
{
@protected
    BaseBusiness *baseBusiness;
}
@property(nonatomic,assign)id<DataModuleDelegate> observer;
- (void)creatBusinessWithId:(NSInteger)businessId andExecuteWithData:(NSDictionary *)dic;
- (void)creatBusinessWithId:(NSInteger)businessId andObserver:(id<BusinessProtocl>)observer andExecuteWithData:(NSDictionary *)dic;
;
@end
