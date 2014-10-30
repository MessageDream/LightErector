//
//  RootViewController.m
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "RootViewController.h"
#import "RootView.h"
#import "CustomTabBar.h"
#import "CustomTabBarItem.h"

#define PushAnimationDuration  0.35

@interface RootViewController () <CustomTabBarDelegate>
{
    BOOL visible;
    CustomTabBar *tabBar;
    RootView *tabBarView;
    CGFloat tabBarHeight;
    BOOL tabBarStatus;
    BOOL isFirstShow;
    NSDictionary *_launchOptions;
}
@end

@implementation RootViewController

#pragma mark - Initialization
-(id)init
{
    if (self=[super init]) {
        isFirstShow=true;
    }
    return self;
}

-(instancetype)initWithLaunchOptions:(NSDictionary *)launchOptions
{
    if (self=[self init]) {
        _launchOptions=launchOptions;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    tabBarView = [[RootView alloc] initWithFrame:[self createViewFrame]];
    tabBar= tabBarView.tabBar;
    tabBar.delegate=self;
    tabBarHeight=tabBar.frame.size.height;
    self.view = tabBarView;
}

-(void)viewDidLoad
{
    [super viewDidLoad];

    if(user.userLoginStatus==UserLoginStatus_NoLogin&&user.userName&&user.password&&[user.userName length]&&[user.password length]&&user.autoLoginFlag){
        
        if ([_launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]) {
            [self swichTabAtIndex:1];
        }else {
            Message *message = [[Message alloc] init];
            message.receiveObjectID =VIEWCONTROLLER_TODAYTASK;
            message.commandID = MC_CREATE_NORML_VIEWCONTROLLER;
            [self sendMessage:message];
        }
         [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    }else{
        Message *message = [[Message alloc] init];
        message.receiveObjectID =VIEWCONTROLLER_LOGIN;
        message.commandID = MC_CREATE_NORML_VIEWCONTROLLER;
        [self sendMessage:message];
    }
}


#pragma mark - CustomTabBarDelegate
- (void)tabBar:(CustomTabBar *)tabBar tabBecameEnabledAtIndex:(int)index tab:(CustomTabBarItem *)tabItem
{
    Message *message = [[Message alloc] init];
    message.commandID =MC_CREATE_NORML_VIEWCONTROLLER;
    switch (index) {
        case 0:
            message.receiveObjectID = VIEWCONTROLLER_TODAYTASK;
            break;
        case 1:
            message.receiveObjectID = VIEWCONTROLLER_ORDERCATEGORYLIST;
            break;
        case 2:
            message.receiveObjectID = VIEWCONTROLLER_UNSETTLED;
            break;
        case 3:
            message.receiveObjectID = VIEWCONTROLLER_USERCENTER;
            break;
        default:
            return;
    }
    [self sendMessage:message];
     //tabBar.layer.zPosition=10;
}

- (void)tabBar:(CustomTabBar *)tabBar tabBecameDisabledAtIndex:(int)index tab:(CustomTabBarItem *)tabItem
{
    
}

- (void)showTabBarWithAnimated:(BOOL)animated
{
    if (!tabBarStatus) {
        if (animated) {
            [UIView beginAnimations:@"Animation" context:nil];
            [UIView setAnimationDuration:PushAnimationDuration];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDelegate:self];
            CGRect frame = tabBar.frame ;
            frame.origin.y=CGRectGetHeight(self.view.bounds) - tabBarHeight;
            tabBar.frame  = frame;
            [UIView commitAnimations];
            
        }else{
            CGRect frame = tabBar.frame ;
            frame.origin.y=CGRectGetHeight(self.view.bounds) - tabBarHeight;
            tabBar.frame  = frame;
        }
        tabBarStatus=YES;
    }
}

- (void)hideTabBarWithAnimated:(BOOL)animated
{
    if (tabBarStatus) {
        if (animated) {
            [UIView beginAnimations:@"Animation" context:nil];
            [UIView setAnimationDuration:PushAnimationDuration];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDelegate:self];
            
            CGRect frame = tabBar.frame ;
            frame.origin.y=CGRectGetHeight(self.view.bounds);
            tabBar.frame  = frame;
            [UIView commitAnimations];
        }else{
            CGRect frame = tabBar.frame ;
            frame.origin.y=CGRectGetHeight(self.view.bounds);
            tabBar.frame  = frame;
        }
        tabBarStatus=NO;
    }
}

- (void)swichTabAtIndex:(NSInteger)index
{
    [tabBar swtichTab:tabBar.tabItems[index]];
}

-(void)reset
{
    tabBar.delegate=nil;
    [tabBar swtichTab:tabBar.tabItems[0]];
    tabBar.delegate=self;
}
#pragma mark - Required Protocol Method

@end
