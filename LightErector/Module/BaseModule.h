//
//  BaseModule.h
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModuleAndControllerID.h"
#import "Message.h"
#import "RootViewController.h"


@class BaseViewController;

@interface BaseModule : NSObject
{
@protected
    NSDictionary *_childModule;
    enum ModuleAndControllerID _ModuleId;
    NSRange _workRange;
    NSMutableDictionary *saveData;
    
}
@property(nonatomic,readonly)NSDictionary *childModule;
@property(nonatomic,readonly)enum ModuleAndControllerID ModuleId;
@property(nonatomic,readonly)NSRange workRange;
@property(nonatomic,assign)BaseModule *parentModule;
@property(nonatomic,assign)RootViewController *rootViewController;

-(BOOL)receiveMessage:(Message*)message;
-(void)sendMessage:(Message*)message;



-(void)addViewControllToRootViewController:(BaseViewController*)viewcontroller forMessage:(Message*)message;
-(BOOL)createChildModule;
-(BOOL)checkWorkRange:(enum ModuleAndControllerID)ID;
-(BaseModule*)checkChildModuleWorkRange:(enum ModuleAndControllerID)ID;
-(void)ModuleClearValue;
-(void)addModuleOfSaveData:(NSString*)key forValue:(id)value;
-(id)getModuleOfSaveDataAtKey:(NSString*)key;
@end
