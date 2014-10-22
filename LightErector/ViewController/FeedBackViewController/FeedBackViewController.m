//
//  FeedBackViewController.m
//  LightErector
//
//  Created by Jayden Zhao on 10/22/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "FeedBackViewController.h"
#import "FeedBackView.h"

@interface FeedBackViewController ()<FeedBackViewDelegate,CustomTitleBar_ButtonDelegate>
{
    FeedBackView *feedView;
}
@end

@implementation FeedBackViewController

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
    _viewControllerId=VIEWCONTROLLER_FEEDBACK;
}

-(void)loadView
{
    feedView=[[FeedBackView alloc] initWithFrame:[self createViewFrame]];
    feedView.customTitleBar.buttonEventObserver=self;
    feedView.observer=self;
    self.view=feedView;
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

-(void)leftButton_onClick:(id)sender
{
    Message *msg=[[Message alloc] init];
    msg.receiveObjectID=VIEWCONTROLLER_RETURN;
    msg.commandID=MC_CREATE_SCROLLERFROMLEFT_VIEWCONTROLLER;
    [self sendMessage:msg];
    
}

-(void)rightButton_onClick:(id)sender
{
    [feedView hideKeyboard];
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
    switch (businessID) {
        case BUSINESS_OTHER_FEEDBACK:
            [self showTip:@"反馈已提交，谢谢您的支持。"];
            break;
            
        default:
            break;
    }
}

-(void)feedBackWithTitle:(NSString *)title andContent:(NSString *)content
{
    user.observer=self;
    [user feedbackWithTitle:title andContent:content];
    [self lockView];
}
@end
