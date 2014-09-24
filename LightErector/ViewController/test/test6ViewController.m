//
//  test6ViewController.m
//  LightErector
//
//  Created by Jayden Zhao on 9/9/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "test6ViewController.h"
#import "test6View.h"

@implementation test6ViewController
-(void)settingViewControllerId
{
    _viewControllerId=VIEWCONTROLLER_TEST6;
}


-(void)loadView
{
    [super loadView];
    CGRect frame=[self createViewFrame];
    frame.size.height=  frame.size.height-50;
    test6View *test=[[test6View alloc] initWithFrame:frame];
    self.view=test;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(30, 180, 100, 50);
    [btn setTitle:@"goback" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    [test addSubview:btn];
}

-(void)goback
{
    Message *message = [[Message alloc] init];
    
    message.CommandID = MC_CREATE_SCROLLERFROMRIGHT_VIEWCONTROLLER;
    message.receiveObjectID = VIEWCONTROLLER_RETURN;
    [self sendMessage:message];
}

@end
