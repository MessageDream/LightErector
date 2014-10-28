//
//  UserSetting.h
//  LightErector
//
//  Created by Jayden Zhao on 10/28/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSetting : NSObject
@property(nonatomic,assign)BOOL taskReminde;
@property(nonatomic,strong)NSString *ringName;
@property(nonatomic,strong)NSString *remindTime;
@property(nonatomic,strong)NSString *currentRemindTime;
-(id)initWithDic:(NSDictionary *)dic;
-(NSDictionary *)toDic;
@end
