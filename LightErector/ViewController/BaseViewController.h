//
//  BaseViewController.h
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModuleAndControllerID.h"
#import "Message.h"
#import "ResDefine.h"
#import "CustomActivityIndicatorView.h"
#import "TextFiledReturnEditingDelegate.h"
#import "DataModelDelegate.h"
#import "User.h"

#define PUSHNOTIFICATIONID @"PUSHNOTIFICATIONID"

@class BaseModule;
@interface BaseViewController : UIViewController<DataModelDelegate,TextFiledReturnEditingDelegate>
{
@protected
    enum ModuleAndControllerID _viewControllerId;
    User *user;
    CustomActivityIndicatorView *customActivityIndicatorView;
    int _lockViewCount;
@private
   CacheMode _cacheMode;

}
@property(nonatomic,readonly)enum ModuleAndControllerID viewControllerId;
@property(nonatomic,readonly)CacheMode cacheMode;;
@property(nonatomic,assign)BaseModule *parentModule;
@property(nonatomic,readonly)int lockViewCount;
@property(nonatomic,assign)UIInterfaceOrientation orientation;

-(void)destroyDataBeforeDealloc;
-(void)sendMessage:(Message*)message;
-(void)receiveMessage:(Message*)message;
-(void)lockView;
-(BOOL)lockViewAddCount;
-(BOOL)unlockViewSubtractCount;
-(void)settingViewControllerId;
-(CGRect)createViewFrame;
-(void)sendShowTabBarMessage;
-(void)sendHideTabBarMessage;
-(void)sendSwichTabBarMessageAtIndex:(NSInteger)index;
-(void)sendResetMessage;
-(void)showTip:(NSString *)text;
-(void)showTip:(NSString *)text atTop:(BOOL) isAtTop;
@end
