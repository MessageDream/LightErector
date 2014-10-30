//
//  LoginViewController.m
//  LightErector
//
//  Created by Jayden Zhao on 9/24/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "LoginViewController.h"
#import "JPushNotification.h"
#import "FindPasswordFromPhoneView.h"

@interface LoginViewController ()<FindPasswordFromPhoneViewDelegate>
{
    CustomMessageBox *customMessageBox;
    FindPasswordFromPhoneView *findPasswordFromPhoneView;
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
    
    if(user.autoLoginFlag&&user.userName&&user.password)
        [self performSelector:@selector(loginButton_onClick:) withObject:nil afterDelay:0.0f];
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
    
    NSString *userName = ((LoginView*)self.view).txt_userName.text;
    NSString *password = ((LoginView*)self.view).txt_password.text;
    
    if(userName==nil || userName.length == 0)
    {
        [self showTip:NSLocalizedStringFromTable(@"AccountNumberIsNull",Res_String,@"") ];
        return;
        
    }
    else if(password==nil || password.length == 0)
    {
         [self showTip:NSLocalizedStringFromTable(@"PasswordIsNull",Res_String,@"") ];
        return;
    }
    
    user.observer = self;
    [user login:userName withPassword:password];
    [self lockView];
}

-(IBAction)findPasswordButton_onClick:(id)sender
{
    [self.view endEditing:NO];
    if(!findPasswordFromPhoneView)
    {
        findPasswordFromPhoneView = [[FindPasswordFromPhoneView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        findPasswordFromPhoneView.eventObserver = self;
        [self.view addSubview:findPasswordFromPhoneView];
    }
}

-(IBAction)findPasswordConfirmButton_onClick:(id)sender
{
   // [findPasswordFromPhoneView scrollToChangePwdView];
    user.observer=self;
    [user uploadUserName:findPasswordFromPhoneView.txt_userName.text andVeryCode:findPasswordFromPhoneView.txt_veryCode.text];
    [self lockView];
}

-(IBAction)findPasswordCancelButton_onClick:(id)sender
{
    [findPasswordFromPhoneView removeFromSuperview];
    findPasswordFromPhoneView=nil;
}

-(IBAction)findPasswordGetVerCode_onClick:(id)sender
{
    [findPasswordFromPhoneView.txt_veryCode becomeFirstResponder];
    user.observer=self;
    [user getVeryCode:findPasswordFromPhoneView.txt_userName.text];
    [self lockView];
}

-(IBAction)findPasswordChangePwd_onClick:(id)sender
{
    if (![findPasswordFromPhoneView.txt_password.text isEqualToString:findPasswordFromPhoneView.txt_confirmpassword.text]) {
        [self showTip:@"两次密码输入不一致"];
        return;
    }
    user.observer=self;
    [user changePwd:findPasswordFromPhoneView.txt_password.text];
    [self lockView];
}

-(void)receiveMessage:(Message *)message
{
    [super receiveMessage:message];
}

#pragma mark - DataModuleDelegate
-(void)didDataModelNoticeSucess:(BaseDataModel*)baseDataModel forBusinessType:(enum BusinessType)businessID
{
     [super didDataModelNoticeSucess:baseDataModel forBusinessType:businessID];
    if(businessID == BUSINESS_LOGIN)
    {
//        //设置推送的对象为当前用户
//        [((JPushNotification*)[PushNotification sharePushNotification]) registerUserTags:nil andAlias:user.userName callbackSelector:nil target:nil];
//        
        Message *msg=[[Message alloc] init];
        msg.receiveObjectID=VIEWCONTROLLER_TODAYTASK;
        msg.commandID=MC_CREATE_SCROLLERFROMRIGHT_VIEWCONTROLLER;
        [self sendMessage:msg];
        [self sendShowTabBarMessage];
//        [self sendSwichTabBarMessageAtIndex:0];
    }else if (businessID==BUSINESS_GETVERYCODE) {
        [self showTip:@"验证码已发送至您手机，请查收。"];
    }else if (businessID==BUSINESS_UPLOADNAMEANDCODE) {
        [findPasswordFromPhoneView scrollToChangePwdView];
    }else if (businessID==BUSINESS_CHANGEPWD) {
        [findPasswordFromPhoneView removeFromSuperview];
        findPasswordFromPhoneView=nil;
        [self showTip:@"密码修改成功，请重新登陆。"];
    }
}

-(void)dealloc
{
     customMessageBox=nil;
     findPasswordFromPhoneView=nil;
}
@end
