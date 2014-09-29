//
//  TodayTaskModel.m
//  LightErector
//
//  Created by Jayden Zhao on 9/28/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "TaskRemind.h"

@implementation TaskRemind
-(void)fetchTodayTask:(int)memId
{
    NSDictionary *dic=[NSDictionary dictionaryWithObject:@(memId) forKey:@"memberid"];
    [self creatBusinessWithId:BUSINESS_GETTASKREMIND andExecuteWithData:dic];
}
@end
