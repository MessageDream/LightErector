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
#import "LocalPushNotification.h"
#import "User.h"
#import "TaskRemind.h"
#import "EKEventUtils.h"


@interface AppDelegate()<BMKGeneralDelegate>
{
    __weak PushNotification *jpush;
    __weak PushNotification *localPush;
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
    
    //百度地图
    _mapManager = [[BMKMapManager alloc]init];
    [_mapManager start:@"pO83Gx1SwHwrVht30ZqyPTAj"  generalDelegate:self];
    
//        //注册极光推送
//        jpush=[JPushNotification sharePushNotification];
//        [jpush applyForPushNotification:launchOptions];
    //本地推送
    localPush=[LocalPushNotification sharePushNotification];
    [localPush applyForPushNotification:launchOptions];
    
//    if (![EKEventUtils authStatus]) {
//        [EKEventUtils requestAccessWithCompletion:^(BOOL granted, NSError *error) {
//        }];
//    }
//    EKEventStore *store=[[EKEventStore alloc] init];
//    NSPredicate *predicate = [store predicateForRemindersInCalendars:nil];
//    [store fetchRemindersMatchingPredicate:predicate completion:^(NSArray *reminders) {
//        EKReminder *item;
//        for (EKReminder *reminder in reminders) {
//            if ([reminder.title containsString:@"灯饰安装任务"]) {
//                item=reminder;
//                break;
//            }
//        }
//        NSError *reminderError;
//        if (!item) {
//            EKReminder *reminder=  [EKReminder reminderWithEventStore:store];
//            reminder.title=[NSString stringWithFormat:@"您今天有%d个灯饰安装任务，请及时安排时间。",result];
//            reminder.calendar=[store defaultCalendarForNewReminders];
//            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//            NSDate *date=[dateFormatter dateFromString:@"2014-10-28 15:02:00"];
//            EKAlarm *alrm=[EKAlarm alarmWithAbsoluteDate:date];
//            alrm.relativeOffset=60;
//            [reminder addAlarm:alrm];
//            [store saveReminder:reminder commit:YES error:&reminderError];
//            if (reminderError) {
//                return;
//            }
//            
//        }else if(item.completed)
//        {
//            [store removeReminder:item commit:YES error:&reminderError];
//            if (reminderError) {
//                return;
//            }
//            
//            item=  [EKReminder reminderWithEventStore:store];
//            item.title=[NSString stringWithFormat:@"您今天有%d个灯饰安装任务，请及时安排时间。",result];
//            item.calendar=[store defaultCalendarForNewReminders];
//            [item addAlarm:[EKAlarm alarmWithAbsoluteDate:[NSDate date]]];
//            [store saveReminder:item commit:YES error:&reminderError];
//            if (reminderError) {
//                return;
//            }
//        }
//        
//    }];
//
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
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

-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    User *user=[User shareUser];
    if (user.setting.taskReminde&&user.userid>0) {
        NSDate *date=[NSDate new];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dstr=[dateFormatter stringFromDate:date];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *newDateStr=[NSString stringWithFormat:@"%@ %@",dstr,user.setting.remindTime];
        NSDate *newdate=[dateFormatter dateFromString:newDateStr];
        
        if ([user.setting.currentRemindTime length]&&[newDateStr isEqualToString:user.setting.currentRemindTime]) {
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
                notification.applicationIconBadgeNumber = 1;
                notification.hasAction=YES;
                NSDictionary* info = [NSDictionary dictionaryWithObject:@"dengshifuios" forKey:@"dengshifu"];
                notification.userInfo = info;
                
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

-(NSString *)voiceFilePathFromBundle:(NSString *)fileName
{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *filePath = [mainBundle pathForResource:fileName ofType:@"wav"];
    return filePath;
}
@end

