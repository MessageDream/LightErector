//
//  HttpConnectRespones.m
//  HttpConnect
//
//  Created by Jayden Zhao on 13-3-31.
//  Copyright (c) 2013年 LightErector. All rights reserved.
//

#import "HttpConnectRespones.h"

@implementation HttpConnectRespones
@synthesize responesHead = _responesHead;
@synthesize responesData = _responesData;

-(void)dealloc
{
    self.responesHead = nil;
    self.responesData = nil;
}
@end
