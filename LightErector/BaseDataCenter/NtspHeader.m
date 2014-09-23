//
//  NtspHeader.m
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "NtspHeader.h"

@implementation NtspHeader

- (id)init
{
    if (self = [super init]) {
        self.apikey = API_KEY;
        self.version = API_VERSION;
        self.errcode = 0;
        self.errmsg = @"";
    }
    return  self;
}

- (NSDictionary *)toDicValue
{
    NSMutableDictionary * ntspHeaderDictionary = [[NSMutableDictionary alloc] init];
    if (self.apikey) {
        [ntspHeaderDictionary setValue:self.apikey forKey:@"apikey"];
    }
    if (self.version) {
        [ntspHeaderDictionary setValue:self.version forKey:@"version"];
    }
    if (self.sessionid) {
        [ntspHeaderDictionary setValue:self.sessionid forKey:@"sessionid"];
    }
    
    if ([ntspHeaderDictionary count] == 0) {
        return nil;
    }else{
        return ntspHeaderDictionary;
    }
}

- (void)initWithJson:(NSDictionary*)jsonDic
{
    self.apikey = [jsonDic objectForKey:@"apikey"];
    self.version = [jsonDic objectForKey:@"verson"];
    self.sessionid = [jsonDic objectForKey:@"sessionid"];
}

@end
