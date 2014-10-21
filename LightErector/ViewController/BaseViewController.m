//
//  BaseViewController.m
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//
#import "BaseUIView.h"
#import "TitleBarView.h"
#import "BaseViewController.h"
#import "ViewControllerPathManager.h"
#import "BaseModule.h"
#import "BaseCustomMessageBox.h"
#import "ImageUtils.h"
#import "MainStyle.h"

@interface BaseViewController ()
{
}
-(void)unlockView;
-(void)createUIActivityIndicatorView;
@end

@implementation BaseViewController
@synthesize viewControllerId = _viewControllerId;
@synthesize lockViewCount = _lockViewCount;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _orientation = [UIApplication sharedApplication].statusBarOrientation;
    }
    return self;
}

-(id)init
{
    if (self=[super init]) {
        _orientation = [UIApplication sharedApplication].statusBarOrientation;
    }
    return self;
}

-(void)sendMessage:(Message*)message
{
    message.sendObjectID=self.viewControllerId;//设置发送者的id
    
    if(self.parentModule == nil)
        return;
    
    if(message.receiveObjectID == VIEWCONTROLLER_RETURN)
    {
        NSNumber *ID = [ViewControllerPathManager popId];
        if(ID!=nil){
            BaseViewController *controller=[ViewControllerPathManager peekCache];
            if (controller!=nil&&controller.viewControllerId==[ID intValue]) {
                controller=[ViewControllerPathManager popCache];
                [self.parentModule addViewControllToRootViewController:controller forMessage:message];
                return;
            }
            message.receiveObjectID = [ID intValue];
        }else{
            return;
        }
    }else {
        if (message.doCache) {
            _doCache=message.doCache;
            [ViewControllerPathManager pushCache:self];
        }
        [ViewControllerPathManager pushId:[NSNumber numberWithInt:message.sendObjectID ]];
    }
    
    [self.parentModule receiveMessage:message];
}

-(void)receiveMessage:(Message*)message
{
    //如果消息是直接由Module或者RootController发出的则清空缓存
    if (message.sendObjectID==VIEWCONTROLLER_NONE||message.sendObjectID==Module_NONE||message.sendObjectID==Module_ROOT) {
        [ViewControllerPathManager clearCache];
        [ViewControllerPathManager clearIds];
    }
}

-(void)didDataModelNoticeSucess:(BaseDataModel*)baseDataModel forBusinessType:( BusinessType)businessID
{
    [self unlockViewSubtractCount];
#ifdef DEBUG_LOG
    NSLog(@"%d",(int)businessID);
    NSLog(@"sucess");
#endif
}
-(void)didDataModelNoticeFail:(BaseDataModel*)baseDataModel forBusinessType:( BusinessType)businessID forErrorCode:(NSInteger)errorCode forErrorMsg:(NSString*)errorMsg
{
    [self unlockViewSubtractCount];
#ifdef DEBUG_LOG
    NSLog(@"%d",(int)businessID);
#endif
    NSString *error = @"";
    if(errorMsg==nil)
        return;
    error = [error stringByAppendingString:errorMsg];
    [self showTip:error];
#ifdef DEBUG_LOG
    NSLog(@"%@",error);
#endif
    
}
-(void)createUIActivityIndicatorView
{
    customActivityIndicatorView = [[CustomActivityIndicatorView alloc]initWithFrame:self.view.bounds];
    customActivityIndicatorView.alpha = 0.5;
    customActivityIndicatorView.color=[UIColor blackColor];
    [self.view addSubview:customActivityIndicatorView];
}
-(void)settingViewControllerId
{
    _viewControllerId = VIEWCONTROLLER_NONE;
}


-(void)lockView
{
    _lockViewCount++;
    if(![customActivityIndicatorView isAnimating])
    {
        self.view.userInteractionEnabled = NO;
        [self.view bringSubviewToFront:customActivityIndicatorView];
        [customActivityIndicatorView startAnimating];
    }
}
-(BOOL)lockViewAddCount
{
    if([customActivityIndicatorView isAnimating])
    {
        _lockViewCount++;
        return YES;
    }
    return NO;
}
-(void)unlockView
{
    self.view.userInteractionEnabled = YES;
    customActivityIndicatorView.showText = nil;
    [customActivityIndicatorView stopAnimating];
}
-(BOOL)unlockViewSubtractCount
{
    if(![customActivityIndicatorView isAnimating])
        return NO;
    
    _lockViewCount--;
    if(_lockViewCount<0)
        _lockViewCount = 0;
    if(_lockViewCount == 0)
        [self unlockView];
    return YES;
}
-(CGRect)createViewFrame
{
    CGRect frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.width = [UIScreen mainScreen].applicationFrame.size.width;
    frame.size.height = [UIScreen mainScreen].applicationFrame.size.height;
    
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=7)
        frame.origin.y = [UIScreen mainScreen].applicationFrame.origin.y;
    return frame;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    user=[User shareUser];
    [self settingViewControllerId];
    //    [ViewControllerPathManager addViewControllerID:[NSNumber numberWithInt:_viewControllerId]];
    _lockViewCount = 0;
    [self createUIActivityIndicatorView];
    
}
-(IBAction)textFiledReturnEditing:(id)sender
{
    [sender resignFirstResponder];
}
-(void)destroyDataBeforeDealloc
{
    
}

-(void)sendShowTabBarMessage
{
    Message *message = [[Message alloc] init];
    message.commandID = MC_SHOW_ROOT_TABBAR;
    message.receiveObjectID=Module_ROOT;
    [self sendMessage:message];
}
-(void)sendHideTabBarMessage
{
    Message *message = [[Message alloc] init];
    message.receiveObjectID=Module_ROOT;
    message.commandID = MC_HIDE_ROOT_TABBAR;
    [self sendMessage:message];
}

-(void)sendSwichTabBarMessageAtIndex:(NSInteger)index
{
    Message *message = [[Message alloc] init];
    message.receiveObjectID=Module_ROOT;
    message.commandID = MC_SWICH_ROOT_TABBAR;
    message.externData=@(index);
    [self sendMessage:message];
}

-(void)sendResetMessage
{
    Message *message = [[Message alloc] init];
    message.receiveObjectID=Module_ROOT;
    message.commandID = MC_RESET_ROOT;
    [self sendMessage:message];
}

-(void)dealloc
{
    if([self.view isKindOfClass:[TitleBarView class]])
        ((TitleBarView*)self.view).customTitleBar.buttonEventObserver = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showTip:(NSString *)text
{
    [self showTip:text atTop:NO];
}

-(void)showTip:(NSString *)text atTop:(BOOL) isAtTop
{
    UIImage *image=[ImageUtils createImageWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.8] andSize:CGSizeMake(200.0f, 50.0f)];
    BaseCustomMessageBox *baseCustomMessageBox = [[BaseCustomMessageBox alloc] initWithText:text forBackgroundImage:image];
    if (isAtTop) {
      CGRect rect= baseCustomMessageBox.frame;
        rect.origin.y=self.view.frame.origin.y+50;
        baseCustomMessageBox.frame=rect;
    }
    baseCustomMessageBox.tag=MESSAGEBOXTAG;
    baseCustomMessageBox.animation = YES;
    baseCustomMessageBox.autoCloseTimer = 2;
    [self.view addSubview:baseCustomMessageBox];
}
@end
