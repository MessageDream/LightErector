//
//  ChangeUserInfoViewController.m
//  LightErector
//
//  Created by Jayden Zhao on 10/21/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "ChangeUserInfoViewController.h"
#import "ChangeUserInfoView.h"

@interface ChangeUserInfoViewController ()<ChangeUserInfoViewDelegate,CustomTitleBar_ButtonDelegate>
{
ChangeUserInfoView *view;
}
@end

@implementation ChangeUserInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)settingViewControllerId
{
    _viewControllerId=VIEWCONTROLLER_CHAGEUSERINFO;
}


-(void)loadView
{
    view=[[ChangeUserInfoView alloc] initWithFrame:[self createViewFrame]];
    view.customTitleBar.buttonEventObserver=self;
    view.observer=self;
    self.view=view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    view.address.text=user.userInfo.address;
      view.telephone.text=user.userInfo.telephone;
      view.mobilephone.text=user.userInfo.mobilephone;
      view.email.text=user.userInfo.email;
      view.qq.text=user.userInfo.qq;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)submit_change_onclick:(id)sender
{
    user.userInfo.address= view.address.text;
    user.userInfo.telephone=view.telephone.text;
    user.userInfo.mobilephone=view.mobilephone.text;
    user.userInfo.email=view.email.text;
    user.userInfo.qq=view.qq.text;
    
    user.observer=self;
    [user updateInfo];
    [self lockView];
}

-(void)leftButton_onClick:(id)sender
{
    Message *msg=[[Message alloc] init];
    msg.receiveObjectID=VIEWCONTROLLER_RETURN;
    msg.commandID=MC_CREATE_SCROLLERFROMLEFT_VIEWCONTROLLER;
    [self sendMessage:msg];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)didDataModelNoticeSucess:(BaseDataModel *)baseDataModel forBusinessType:(BusinessType)businessID
{
    [super didDataModelNoticeSucess:baseDataModel forBusinessType:businessID];
    if (businessID==BUSINESS_UPDATEUSERINFO) {
        [self showTip:@"信息修改成功！"];
    }
}

-(void)dealloc
{
    view=nil;
}
@end
