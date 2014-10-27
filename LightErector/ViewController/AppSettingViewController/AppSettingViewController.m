//
//  AppSettingViewController.m
//  LightErector
//
//  Created by Jayden Zhao on 10/27/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "AppSettingViewController.h"
#import "AppSettingView.h"

@interface AppSettingViewController ()<UITableViewDataSource,UITableViewDelegate,CustomTitleBar_ButtonDelegate>
{
    __weak UITableView *tableView;
}
@end

@implementation AppSettingViewController

-(void)settingViewControllerId
{
    _viewControllerId=VIEWCONTROLLER_SETTING;
}

-(void)loadView
{
    AppSettingView *view=[[AppSettingView alloc] initWithFrame:[self createViewFrame] tableViewStyle:UITableViewStyleGrouped];
    view.customTitleBar.buttonEventObserver=self;
    view.tableView.delegate=self;
    view.tableView.dataSource=self;
    tableView=view.tableView;
    self.view=view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    if (section==1) {
        return 2;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (user.taskReminde) {
        return 2;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.textLabel.textColor = [MainStyle mainTitleColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        cell.backgroundView=nil;
    }
    if (indexPath.section==0) {
        cell.textLabel.text = @"开启任务提醒功能";
        UISwitch *taskRemindSwitch=[[UISwitch alloc]init];
        [taskRemindSwitch setOnImage:[UIImage imageNamed:@"user_switch_on"]];
        [taskRemindSwitch setOffImage:[UIImage imageNamed:@"user_switch_off"]];
        taskRemindSwitch.on=user.taskReminde;
        [taskRemindSwitch addTarget:self action:@selector(switchAction:)forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = taskRemindSwitch;
        
    }else{
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text =@"设置任务提醒时间";
                break;
            case 1:
                cell.textLabel.text =@"设置任务提醒铃声";
                break;
            default:
                break;
        }
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)switchAction:(UISwitch *)sender
{
    if (sender.on) {
        user.taskReminde=YES;
    }else{
        user.taskReminde=NO;
    }
    [tableView reloadData];
    [user saveUserSetting];
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
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
