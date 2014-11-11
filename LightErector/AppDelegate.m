//
//  AppDelegate.m
//  LightErector
//
//  Created by Jayden Zhao on 9/23/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "AppDelegate.h"
#import "RootModule.h"
#import "ModuleAndControllerID.h"
#import "JPushNotification.h"
#import "User.h"
#import "TaskRemind.h"
#import "EKEventUtils.h"


@interface AppDelegate()<BMKGeneralDelegate>
{
    __weak PushNotification *jpush;
}
@end
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];

    //建立根Node，然后建立第一个显示的UIViewController
    RootViewController *rootViewController=  [[RootViewController alloc] initWithLaunchOptions:launchOptions];
    self.rootModule = [[RootModule alloc] init];
    self.rootModule.window = self.window;
    self.rootModule.rootViewController = rootViewController;
    rootViewController.parentModule=self.rootModule;
    [self.rootModule createChildModule];
    
    self.window.rootViewController =rootViewController;
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    //百度地图
    _mapManager = [[BMKMapManager alloc]init];
    [_mapManager start:@"NisnmVIX7MCCSqGuBPRqb8V6"  generalDelegate:self];
    
        //注册极光推送
        jpush=[JPushNotification sharePushNotification];
        [jpush applyForPushNotification:launchOptions];
    
    
    //    //程序升级后首次运行
    //    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    //
    //    NSString *selfAppVerion = [[NSUserDefaults standardUserDefaults] valueForKey:@"CFBundleVersion"];
    //
    //    if(![appVersion isEqualToString:selfAppVerion])
    //    {
    //        [[NSUserDefaults standardUserDefaults] setValue:appVersion forKey:@"CFBundleVersion"];
    //        //首次运行
    //        Message *message = [[Message alloc] init];
    //        message.receiveObjectID = VIEWCONTROLLER_WELCOME;//VIEWCONTROLLER_TEST2,VIEWCONTROLLER_LOGIN
    //        message.commandID = MC_CREATE_NORML_VIEWCONTROLLER;
    //        message.externData=launchOptions;
    //        [self.nodeRoot receiveMessage:message];
    //    }
    //    else
    //    {
    //        //直接进入
    //        Message *message = [[Message alloc] init];
    //        message.receiveObjectID = VIEWCONTROLLER_LOGIN;
    //        message.commandID = MC_CREATE_NORML_VIEWCONTROLLER;
    //        message.externData=launchOptions;
    //        [self.nodeRoot receiveMessage:message];
    //    }
    
//    Message *message = [[Message alloc] init];
//    message.receiveObjectID = VIEWCONTROLLER_LOGIN;
//    message.commandID = MC_CREATE_NORML_VIEWCONTROLLER;
//    message.externData=launchOptions;
//    [self.rootModule receiveMessage:message];
    
    return YES;
}

-(void)onGetNetworkState:(int)iError
{
#ifdef DEBUG_LOG
    if (iError == 0)
    {
        NSLog(@"网络连接正常");
    }
    else
    {
        NSLog(@"网络错误:%d",iError);
    }
#endif
}
-(void)onGetPermissionState:(int)iError
{
#ifdef DEBUG_LOG
    if (iError == 0)
    {
        NSLog(@"授权成功");
    }
    else
    {
        NSLog(@"授权失败:%d",iError);
    }
#endif
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationWillResignActiveNotification object:nil userInfo:nil];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationWillEnterForegroundNotification object:nil userInfo:nil];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
     [jpush registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
     [jpush receivePushNotification:userInfo];
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
   
}

#ifdef __IPHONE_7_0
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
     [jpush receivePushNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNoData);
}

-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    User *user=[User shareUser];
    if (user.setting.taskReminde&&user.userid>0) {
        NSDate *date=[NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dstr=[dateFormatter stringFromDate:date];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *newDateStr=[NSString stringWithFormat:@"%@ %@",dstr,user.setting.remindTime];
        NSDate *newdate=[dateFormatter dateFromString:newDateStr];
        
        if (([date compare:newdate] == NSOrderedDescending)||([user.setting.currentRemindTime length]&&[newDateStr isEqualToString:user.setting.currentRemindTime])) {
            completionHandler(UIBackgroundFetchResultNewData);
            return;
        }
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        NSInteger result= [TaskRemind fetchTodayTask:user.userid];
        if (result>0) {
            UILocalNotification *notification=[[UILocalNotification alloc] init];
            if (notification!=nil)
            {
                notification.fireDate=newdate;
                notification.timeZone=[NSTimeZone defaultTimeZone];
                notification.soundName =user.setting.ringName;
                notification.alertBody =[NSString stringWithFormat:@"您今天有%d个灯饰安装任务，请及时安排时间。",result];
                notification.alertAction=@"查看";
                notification.applicationIconBadgeNumber = result;
                notification.hasAction=YES;
                
                [[UIApplication sharedApplication] scheduleLocalNotification:notification];
                user.setting.currentRemindTime=newDateStr;
                [user saveUserSetting];
            }
          completionHandler(UIBackgroundFetchResultNewData);
        }else{
            completionHandler(UIBackgroundFetchResultFailed);
        }
    }
}
#endif
@end

