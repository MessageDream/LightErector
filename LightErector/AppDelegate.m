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

@interface AppDelegate()
{
    PushNotification *jpush;
}
@end
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    RootViewController *rootViewController=  [[RootViewController alloc] init];

    self.window.rootViewController =rootViewController;
    [self.window makeKeyAndVisible];
    
//    //注册极光推送
//    jpush=[JPushNotification sharePushNotification];
//    [jpush applyForPushNotification:launchOptions];
    
    //建立根Node，然后建立第一个显示的UIViewController
    self.rootModule = [[RootModule alloc] init];
    self.rootModule.window = self.window;
    self.rootModule.rootViewController = rootViewController;
    rootViewController.parentModule=self.rootModule;
    [self.rootModule createChildModule];
    
    
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
    
    Message *message = [[Message alloc] init];
    message.receiveObjectID = VIEWCONTROLLER_LOGIN;
    message.commandID = MC_CREATE_NORML_VIEWCONTROLLER;
    message.externData=launchOptions;
    [self.rootModule receiveMessage:message];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION_WillResignActive" object:nil userInfo:nil];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION_WillEnterForeground" object:nil userInfo:nil];
    
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
    
   // [jpush registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
   // [jpush receivePushNotification:userInfo];
}

#ifdef __IPHONE_7_0
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
   // [jpush receivePushNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNoData);
}
#endif
@end

