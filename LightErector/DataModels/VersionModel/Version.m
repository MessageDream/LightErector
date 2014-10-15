//
//  Version.m
//  LightErector
//
//  Created by Jayden Zhao on 10/15/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "Version.h"

@implementation Version
-(void)getLastVersion
{
     NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
     NSDictionary *dic=[NSDictionary dictionaryWithObject:appVersion forKey:@"clientversion"];
    [self creatBusinessWithId:BUSINESS_OTHER_CLIENTVERSION andExecuteWithData:dic];
}

-(void)didBusinessSucess:(BaseBusiness *)business withData:(NSDictionary *)businessData
{
    
    NSDictionary *dic=[businessData objectForKey:@"version"];
    self.version=[dic objectForKey:@"version"];
    self.versionName=[dic objectForKey:@"versionname"];
    self.url=[dic objectForKey:@"url"];
    self.upgrade=[[dic objectForKey:@"upgrade"] isEqualToString:@"M"]?YES:NO;
    self.introduction=[dic objectForKey:@"introduction"];
    [super didBusinessSucess:business withData:businessData];
}
@end

