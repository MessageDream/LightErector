//
//  TodayTaskModel.m
//  LightErector
//
//  Created by Jayden Zhao on 9/28/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "TaskRemind.h"

@implementation TaskRemind
+(BOOL)fetchTodayTask:(int)memId
{
    NSDictionary *dic=[NSDictionary dictionaryWithObject:@(memId) forKey:@"memberid"];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"%@/mobile/%@.php?action=getAllAlarmTask",API_ADDRESS,ACTION_PATH]]];
    request.HTTPMethod=@"POST";
    NSError * error;
    
    NSMutableData *body=[[NSMutableData alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error]];
    //[NSJSONSerialization ]
    request.HTTPBody=body;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request
                                               returningResponse:nil error:&error];
    
  
    NSDictionary *dicResult= [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:&error];
    if (!error) {
        
        NSInteger result=[[dicResult objectForKey:@"result"] integerValue];
        if (result) {
            NSArray *arr=[dicResult objectForKey:@"alarmtask"];
            
            return YES;
        }else {
            return NO;
        }
        
    }
    return NO;
}
@end
