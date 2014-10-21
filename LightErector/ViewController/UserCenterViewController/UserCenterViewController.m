//
//  UserCenterViewController.m
//  LightErector
//
//  Created by Jayden Zhao on 10/15/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "UserCenterViewController.h"
#import "UserCenterView.h"

@interface UserCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation UserCenterViewController

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
    _viewControllerId=VIEWCONTROLLER_USERCENTER;
}

-(void)loadView
{
    CGRect frame=[self createViewFrame];
    frame.size.height=frame.size.height-DefaultTabBarHeight;
    UserCenterView *userCenterView=[[UserCenterView alloc] initWithFrame:frame tableViewStyle:UITableViewStyleGrouped];
    userCenterView.tableView.delegate=self;
    userCenterView.tableView.dataSource=self;
    self.view=userCenterView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38.0f;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ide=@"cellide";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ide];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ide];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.backgroundColor=[UIColor clearColor];
        cell.textLabel.textColor=[MainStyle mainTitleColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section==0) {
        
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text=@"信息修改";
                cell.imageView.image=[UIImage imageNamed:@"change"];
                break;
            case 1:
                cell.textLabel.text=@"软件设置";
                cell.imageView.image=[UIImage imageNamed:@"setting"];
                break;
            case 2:
                cell.textLabel.text=@"系统公告";
                cell.imageView.image=[UIImage imageNamed:@"mail"];
                break;
        }

    }else{
        switch (indexPath.row) {

            case 0:
                 cell.textLabel.text=@"意见反馈";
                cell.imageView.image=[UIImage imageNamed:@"feedback"];
                break;
            case 1:
                cell.textLabel.text=@"关于灯师傅";
                cell.imageView.image=[UIImage imageNamed:@"info"];
                break;
            case 2:
                cell.textLabel.text=@"注销登录";
                cell.imageView.image=[UIImage imageNamed:@"login"];
                break;
        }
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        switch (indexPath.row) {
            case 0:{
                Message *msg=[[Message alloc] init];
                msg.receiveObjectID=VIEWCONTROLLER_CHAGEUSERINFO;
                msg.commandID=MC_CREATE_SCROLLERFROMRIGHT_VIEWCONTROLLER;
                [self sendMessage:msg];
            }
                break;
            case 1:
               
                break;
            case 2:
                
                break;
        }
        
    }else{
        switch (indexPath.row) {
                
            case 0:
                
                break;
            case 1:
                
                break;
            case 2:{
                user.userLoginStatus = UserLoginStatus_Logout;
                [self sendResetMessage];
                Message *msg=[[Message alloc] init];
                msg.receiveObjectID=VIEWCONTROLLER_LOGIN;
                msg.commandID=MC_CREATE_FLIPFROMLEFT_VIEWCONTROLLER;
                [self sendMessage:msg];
            }
            break;
        }
    }

}


@end
