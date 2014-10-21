//
//  SystemNoticeViewController.m
//  LightErector
//
//  Created by Jayden Zhao on 10/21/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "SystemNoticeViewController.h"
#import "SystemNoticeView.h"

@interface SystemNoticeViewController ()<UIWebViewDelegate,CustomTitleBar_ButtonDelegate>
{
    SystemNoticeView *view;
}
@end

@implementation SystemNoticeViewController

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
    _viewControllerId=VIEWCONTROLLER_SYSTEMNOTICE;
}

-(void)loadView
{
    view=[[SystemNoticeView alloc]initWithFrame:[self createViewFrame]];
    view.customTitleBar.buttonEventObserver=self;
    view.webView.delegate=self;
    view.url=SYSTEMNOTICE_URL;
    self.view=view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [view startLoading];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self lockView];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self unlockView];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
      [self unlockView];
}

@end
