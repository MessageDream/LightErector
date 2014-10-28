//
//  TodayTaskModel.m
//  LightErector
//
//  Created by Jayden Zhao on 9/28/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "TaskRemind.h"
#import <EventKit/EventKit.h>

@implementation TaskRemind
+(NSInteger)fetchTodayTask:(int)memId
{
    NSDictionary *dic=[NSDictionary dictionaryWithObject:@(memId) forKey:@"memberid"];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@/mobile/%@.php?action=getAllAlarmTask",API_ADDRESS,ACTION_PATH]]];
    request.HTTPMethod=@"POST";
    NSError * error;
    
    NSMutableData *body=[[NSMutableData alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error]];
    request.HTTPBody=body;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request
                                               returningResponse:nil error:&error];
    
    NSDictionary *dicResult= [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:&error];
    if (!error) {
#ifdef DEBUG_LOG
        NSLog(@"%@",dicResult);
#endif
        NSInteger result=[[dicResult objectForKey:@"result"] integerValue];
        if (result) {
            NSArray *arr=[dicResult objectForKey:@"alarmtask"];
            if (arr.count) {
             return arr.count;
            }
            return 0;
        }else {
            return 0;
        }
        
    }
    return 0;
}
@end
