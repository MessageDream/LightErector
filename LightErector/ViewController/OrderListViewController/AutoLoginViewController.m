//
//  AutoLoginViewController.m
//  LightErector
//
//  Created by Jayden Zhao on 10/30/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "AutoLoginViewController.h"
#import "TradeInfo.h"

@interface AutoLoginViewController ()
@end

@implementation AutoLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (user.userLoginStatus==UserLoginStatus_NoLogin) {
        user.observer=self;
        [user login:user.userName withPassword:user.password];
        [self lockView];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)afterLogin
{
    
}

-(void)didDataModelNoticeSucess:(BaseDataModel *)baseDataModel forBusinessType:(BusinessType)businessID
{
    [super didDataModelNoticeSucess:baseDataModel forBusinessType:businessID];
    if (businessID==BUSINESS_LOGIN) {
            [self afterLogin];
    }
}

-(void)didDataModelNoticeFail:(BaseDataModel *)baseDataModel forBusinessType:(BusinessType)businessID forErrorCode:(NSInteger)errorCode forErrorMsg:(NSString *)errorMsg
{
    [super didDataModelNoticeFail:baseDataModel forBusinessType:businessID forErrorCode:errorCode forErrorMsg:errorMsg];
    switch (businessID) {
        case BUSINESS_LOGIN:{
            Message *message = [[Message alloc] init];
            message.receiveObjectID =VIEWCONTROLLER_LOGIN;
            message.commandID = MC_CREATE_NORML_VIEWCONTROLLER;
            [self sendMessage:message];
        }
            break;
        default:
            break;
    }
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
