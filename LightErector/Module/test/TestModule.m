//
//  TestModule.m
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "TestModule.h"
#import "ModuleAndControllerID.h"
#import "BaseViewController.h"
#import "test1ViewController.h"
#import "test2ViewController.h"
#import "test3ViewController.h"
#import "test4ViewController.h"
#import "test5ViewController.h"
#import "test6ViewController.h"


@implementation TestModule

-(id)init
{
    self = [super init];
    _ModuleId = Module_TEST;
    _workRange.location = Module_TEST;
    return self;
}

-(BOOL)receiveMessage:(Message*)message
{
    if(![super receiveMessage:message])
        return NO;
    
    BOOL viewControllerFlag = YES;
    
    
    if(viewControllerFlag)
    {
        BaseViewController *viewcontroller;
        if(message.receiveObjectID == VIEWCONTROLLER_TEST1)
        {
            viewcontroller = [[test1ViewController alloc] init];
        }else  if(message.receiveObjectID == VIEWCONTROLLER_TEST2)
        {
            viewcontroller = [[test2ViewController alloc]init];
        }else  if(message.receiveObjectID == VIEWCONTROLLER_TEST3)
        {
            viewcontroller = [[test3ViewController alloc]init];
        }else  if(message.receiveObjectID == VIEWCONTROLLER_TEST4)
        {
            viewcontroller = [[test4ViewController alloc]init];
        }else  if(message.receiveObjectID == VIEWCONTROLLER_TEST5)
        {
            viewcontroller = [[test5ViewController alloc]init];
        }else  if(message.receiveObjectID == VIEWCONTROLLER_TEST6)
        {
            viewcontroller = [[test6ViewController alloc]init];
        }

        
        if(viewcontroller != nil)
            [self addViewControllToRootViewController:viewcontroller forMessage:message];
    }
    
    return YES;
}
@end
