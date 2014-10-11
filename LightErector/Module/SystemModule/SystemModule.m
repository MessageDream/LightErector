//
//  SystemModule.m
//  LightErector
//
//  Created by Jayden Zhao on 9/24/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "SystemModule.h"
#import "LoginViewController.h"
#import "TodayTaskViewController.h"
#import "OrderCategoryViewController.h"
#import "UnSettlementViewController.h"

@implementation SystemModule
-(id)init
{
    if(self = [super init]){
        _moduleId = Module_SYSTEM;
        _workRange.location = Module_SYSTEM;
    }
    return self;
}


-(BOOL)receiveMessage:(Message*)message
{
    if(![super receiveMessage:message])
        return NO;
    
    BaseViewController *viewcontroller;
    if(message.receiveObjectID == VIEWCONTROLLER_LOGIN){
        viewcontroller = [[LoginViewController alloc] init];
    }else if (message.receiveObjectID==VIEWCONTROLLER_TODAYTASK){
        viewcontroller=[[TodayTaskViewController alloc] init];
    }else if (message.receiveObjectID==VIEWCONTROLLER_ORDERCATEGORYLIST){
        viewcontroller=[[OrderCategoryViewController alloc] init];
    }else if (message.receiveObjectID==VIEWCONTROLLER_UNSETTLED){
        viewcontroller=[[UnSettlementViewController alloc] init];
    }

    if(viewcontroller != nil)
        [self addViewControllToRootViewController:viewcontroller forMessage:message];
    
    return YES;
}
@end
