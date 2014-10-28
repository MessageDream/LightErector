//
//  TodayTaskModel.h
//  LightErector
//
//  Created by Jayden Zhao on 9/28/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "BaseDataModel.h"

@interface TaskRemind : BaseDataModel
+(NSInteger)fetchTodayTask:(int)memId;
@end
