//
//  UserSetting.m
//  LightErector
//
//  Created by Jayden Zhao on 10/28/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "UserSetting.h"
#define DEFAULTTIME @"10:05"
@implementation UserSetting
-(instancetype)init
{
    if (self=[super init]) {
        _taskReminde=YES;
        _remindTime=DEFAULTTIME;
        _ringName=@"ring2";
        _currentRemindTime=@"";
    }
    return self;
}

-(id)initWithDic:(NSDictionary *)dic
{
    if (self=[self init]) {
        _taskReminde=[[dic objectForKey:@"taskreminde"] boolValue];
        _remindTime=[dic objectForKey:@"remindtime"];
        _ringName=[dic objectForKey:@"ringname"] ;
        NSString *str=[dic objectForKey:@"currentremindtime"];
        _currentRemindTime= str==nil?@"":str;
    }
    return self;
}
-(NSDictionary *)toDic
{
    NSDictionary *dic=[NSDictionary dictionaryWithObjects:@[@(_taskReminde),_remindTime,_ringName,_currentRemindTime] forKeys:@[@"taskreminde",@"remindtime",@"ringname",@"currentremindtime"]];
    return dic;
}
@end
