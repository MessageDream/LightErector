//
//  RootModule.m
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "RootModule.h"
#import "ModuleAndControllerID.h"
#import "BaseViewController.h"
#import "TestModule.h"


@interface RootModule()
{
    
}
-(void)allModuleClearValue;
@end

@implementation RootModule

-(id)init
{
    self = [super init];
    _ModuleId = Module_ROOT;
    _workRange.location = Module_ROOT;
    return self;
}
-(BOOL)createChildModule
{
    TestModule *testModule = [[TestModule alloc] init];
    testModule.rootViewController = self.rootViewController;
    testModule.parentModule = self;
    [testModule createChildModule];
    
    
    _childModule=[NSDictionary dictionaryWithObjects:@[testModule] forKeys:@[[NSString stringWithFormat:@"%d",testModule.ModuleId]]];
    
    return YES;
}
-(void)allModuleClearValue
{
    NSArray *BaseModuleArray = _childModule.allValues;
    for(int n=0;n<BaseModuleArray.count;n++)
    {
        BaseModule *Module = [BaseModuleArray objectAtIndex:n];
        [Module ModuleClearValue];
    }
}
-(BOOL)receiveMessage:(Message*)message
{
    if(![super receiveMessage:message])
        return NO;
    
    if(message.commandID == MC_CHILD_Module_CLEAR_VALUE)
        [self allModuleClearValue];
    else if(message.commandID == MC_SHOW_ROOT_TABBAR)
    {
        //[self.rootViewController hideTabBar:ShowHideFromLeft animated:YES];
    }
    else if(message.commandID == MC_HIDE_ROOT_TABBAR)
    {
        
    }
//    BaseModule *Module = [self checkChildModuleWorkRange:message.receiveObjectID];
//    
//    if(Module==nil)
//    {
//        BaseViewController *viewcontroller;
//        if(message.receiveObjectID == VIEWCONTROLLER_TEST2)
//        {
//            viewcontroller = [[test2ViewController alloc] initWithNibName:@"test2ViewController" bundle:nil];
//        }
//        else if(message.receiveObjectID == VIEWCONTROLLER_TEST3)
//        {
//            viewcontroller = [[testProductViewController alloc] initWithNibName:@"testProductViewController" bundle:nil];
//        }
//        if(viewcontroller != nil)
//            [self addViewControllToRootViewController:viewcontroller forMessage:message];
//    }
    
    return YES;
}
@end
