//
//  message.m
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "Message.h"

@implementation Message
@synthesize externData = _externData;
@synthesize commandID = _commandID;
@synthesize doCache = _doCache;
@synthesize receiveObjectID = _receiveObjectID;
@synthesize sendObjectID = _sendObjectID;


-(id)init
{
    self = [super init];
    _receiveObjectID = Module_NONE;
    _sendObjectID = Module_NONE;
    _doCache=NO;
    return self;
}

-(void)dealloc
{
    self.externData = nil;
}
@end
