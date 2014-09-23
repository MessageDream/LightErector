//
//  HttpHead.m
//  HttpConnect
//
//  Created by Jayden Zhao on 13-3-31.
//  Copyright (c) 2013年 LightErector. All rights reserved.
//

#import "HttpHead.h"

@implementation HttpHead
@synthesize headName = _headName;
@synthesize headValue = _headValue;

- (id)init
{
    if (self = [super init]) {
        _headName = [[NSMutableString alloc] init];
        _headValue = [[NSMutableString alloc] init];
    }
    return self;
}

-(void)dealloc
{
    self.headValue = nil;
    self.headName = nil;
}
@end
