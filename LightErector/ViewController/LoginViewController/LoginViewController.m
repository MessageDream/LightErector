//
//  LoginViewController.m
//  LightErector
//
//  Created by Jayden Zhao on 9/24/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "LoginViewController.h"
#import "JPushNotification.h"

@interface LoginViewController ()
{
    CustomMessageBox *customMessageBox;
}
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)loadView
{
    LoginView *loginView = [[LoginView alloc] initWithFrame:[self createViewFrame]];
    loginView.eventObserver = self;
    self.view = loginView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    LoginView *loginView = (LoginView*)self.view;
    loginView.rememberStatus = user.rememberFlag;
    loginView.autoLoginStatus = user.autoLoginFlag;
    
    if(user.userLoginStatus == UserLoginStatus_Logout)
        return;
    
    if(user.rememberFlag)
    {
        loginView.txt_userName.text = user.userName;
        loginView.txt_password.text = user.password;
    }
    
    
    if(user.autoLoginFlag)
        [self performSelector:@selector(loginButton_onClick:) withObject:nil afterDelay:0.5];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)settingViewControllerId
{
    _viewControllerId = VIEWCONTROLLER_LOGIN;
}

#pragma mark - LoginViewDelegate
-(void)rememberCheckbox_onClick:(BOOL)isSelect
{
    user.rememberFlag = isSelect;
}

-(void)autoLoginCheckbox_onClick:(BOOL)isSelect
{
    user.autoLoginFlag = isSelect;
}

-(IBAction)loginButton_onClick:(id)sender
{
    [self.view endEditing:NO];
    BaseCustomMessageBox *baseCustomMessageBox = nil;
    
    NSString *userName = ((LoginView*)self.view).txt_userName.text;
    NSString *password = ((LoginView*)self.view).txt_password.text;
    
    if(userName==nil || userName.length == 0)
    {
        baseCustomMessageBox = [[BaseCustomMessageBox alloc] initWithText:NSLocalizedStringFromTable(@"AccountNumberIsNull",Res_String,@"") forBackgroundImage:[UIImage imageNamed:@"base_messagebox_background"]];
        
    }
    else if(password==nil || password.length == 0)
    {
        baseCustomMessageBox = [[BaseCustomMessageBox alloc] initWithText:NSLocalizedStringFromTable(@"PasswordIsNull",Res_String,@"") forBackgroundImage:[UIImage imageNamed:@"base_messagebox_background"]];
        
    }
    
    if(baseCustomMessageBox!=nil)
    {
        baseCustomMessageBox.animation = YES;
        baseCustomMessageBox.autoCloseTimer = 1;
        [self.view addSubview:baseCustomMessageBox];
        return;
    }
    
    user.observer = self;
    [user login:userName withPassword:password];
    [self lockView];
}

-(IBAction)findPasswordButton_onClick:(id)sender
{
    
}

#pragma mark - DataModuleDelegate
-(void)didDataModelNoticeSucess:(BaseDataModel*)baseDataModel forBusinessType:(enum BusinessType)businessID
{
    [super didDataModelNoticeSucess:baseDataModel forBusinessType:businessID];
    if(businessID == BUSINESS_LOGIN)
    {
//        //设置推送的对象为当前用户
//        [((JPushNotification*)[PushNotification sharePushNotification]) registerUserTags:nil andAlias:user.userName callbackSelector:nil target:nil];
        
        Message *msg=[[Message alloc] init];
        msg.receiveObjectID=VIEWCONTROLLER_TEST1;
        msg.commandID=MC_CREATE_SCROLLERFROMRIGHT_VIEWCONTROLLER;
        [self sendMessage:msg];
        [self sendShowTabBarMessage];
    }
}
@end
