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

-(void)didDataModuleNoticeSucess:(BaseDataModule*)baseDataModule forBusinessType:( BusinessType)businessID
{
    [self unlockViewSubtractCount];
#ifdef DEBUG_LOG
    NSLog(@"%d",(int)businessID);
    NSLog(@"sucess");
#endif
}
-(void)didDataModuleNoticeFail:(BaseDataModule*)baseDataModule forBusinessType:( BusinessType)businessID forErrorCode:(NSInteger)errorCode forErrorMsg:(NSString*)errorMsg
{
    [self unlockViewSubtractCount];
#ifdef DEBUG_LOG
    NSLog(@"%d",(int)businessID);
#endif
    NSString *error = @"";
    if(errorMsg==nil)
        return;
    error = [error stringByAppendingString:errorMsg];
    
        BaseCustomMessageBox *baseCustomMessageBox = [[BaseCustomMessageBox alloc] initWithText:error forBackgroundImage:[UIImage imageNamed:NSLocalizedStringFromTable(@"base_Messagebox_background",Res_Image,@"")]];
        baseCustomMessageBox.animation = YES;
        baseCustomMessageBox.autoCloseTimer = 1;
    
        [self.view addSubview:baseCustomMessageBox];
#ifdef DEBUG_LOG
    NSLog(@"%@",error);
#endif
    
}
-(void)createUIActivityIndicatorView
{
    customActivityIndicatorView = [[CustomActivityIndicatorView alloc]initWithFrame:self.view.bounds];
    customActivityIndicatorView.alpha = 0.9;
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
    
    if (_orientation==UIDeviceOrientationPortrait||_orientation==UIDeviceOrientationPortraitUpsideDown)  {
        frame.size.width = [UIScreen mainScreen].applicationFrame.size.width-40;
        frame.size.height = [UIScreen mainScreen].applicationFrame.size.height-90;
    }else{
        frame.size.width = [UIScreen mainScreen].applicationFrame.size.height-90;
        frame.size.height = [UIScreen mainScreen].applicationFrame.size.width-40;
    }
    
    //    if([[[UIDevice currentDevice] systemVersion] floatValue]>=7)
    //        frame.origin.y = [UIScreen mainScreen].applicationFrame.origin.y;
    return frame;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
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
@end