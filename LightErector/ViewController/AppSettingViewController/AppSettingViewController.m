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
    __weak UITableView *_tableView;
    NSArray *soundsArray;
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
    _tableView=view.tableView;
    self.view=view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    soundsArray=@[@{@"name":@"05.m4r",@"des":@"顶峰"},
                  @{@"name":@"06.m4r",@"des":@"辐射"},
                  @{@"name":@"24.m4r",@"des":@"星座"},
                  @{@"name":@"26.m4r",@"des":@"照明"},
                  @{@"name":@"27.m4r",@"des":@"钟声"},
                  @{@"name":@"14.m4r",@"des":@"默认-流水"},
                  @{@"name":@"08.m4r",@"des":@"缓慢上升"},
                  @{@"name":@"21.m4r",@"des":@"悉心期盼"},
                  @{@"name":@"22.m4r",@"des":@"新闻快讯"},
                  @{@"name":@"criminal.m4r",@"des":@"criminal"},
                  @{@"name":@"What_are_words.m4r",@"des":@"What are words"},
                  @{@"name":@"I_need_a_doctor.m4r",@"des":@"I need a doctor"}];
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
    if (user.setting.taskReminde) {
        return 2;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 38.0f;
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
        //cell.backgroundColor=[UIColor clearColor];
        cell.detailTextLabel.textColor=[MainStyle mainGreenColor];
        cell.backgroundView=nil;
    }
    if (indexPath.section==0) {
        cell.textLabel.text = @"开启任务提醒功能";
        UISwitch *taskRemindSwitch=[[UISwitch alloc]init];
        [taskRemindSwitch setOnImage:[UIImage imageNamed:@"user_switch_on"]];
        [taskRemindSwitch setOffImage:[UIImage imageNamed:@"user_switch_off"]];
        taskRemindSwitch.on=user.setting.taskReminde;
        [taskRemindSwitch addTarget:self action:@selector(switchAction:)forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = taskRemindSwitch;
        
    }else{
        switch (indexPath.row) {
            case 0:{
                cell.textLabel.text =@"设置任务提醒时间";
                cell.detailTextLabel.text=user.setting.remindTime;
            }
                break;
            case 1:{
                cell.textLabel.text =@"设置任务提醒铃声";
                for(NSDictionary *dic in soundsArray){
                    NSString *name=[dic objectForKey:@"name"];
                    if ([user.setting.ringName isEqualToString:name]) {
                        cell.detailTextLabel.text=[dic objectForKey:@"des"];
                        break;
                    }
                }
            }
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
        if([UIApplication sharedApplication].backgroundRefreshStatus!=UIBackgroundRefreshStatusAvailable){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"未开启后台应用程序刷新功能，请到系统的[设置]-[通用]-[后台应用程序刷新]中打开后台应用程序刷新，并允许灯师傅使用后台应用程序刷新功能"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil,nil];
            [alert show];
            sender.on=NO;
            return;
        }
        user.setting.taskReminde=YES;
    }else{
        user.setting.taskReminde=NO;
    }
    [_tableView reloadData];
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
