//
//  test4ViewController.m
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "test4ViewController.h"
#import "test4View.h"

@interface test4ViewController ()

@end

@implementation test4ViewController

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
    _viewControllerId=VIEWCONTROLLER_TEST4;
}


-(void)loadView
{
    [super loadView];
    test4View *test=[[test4View alloc] initWithFrame:[self createViewFrame]];
    self.view=test;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(30, 180, 100, 50);
    [btn setTitle:@"test5" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(gotest5) forControlEvents:UIControlEventTouchUpInside];
    [test addSubview:btn];
}

-(void)gotest5
{
    Message *message = [[Message alloc] init];
    
    message.CommandID = MC_CREATE_POPFROMBOTTOM_VIEWCONTROLLER;
    message.receiveObjectID = VIEWCONTROLLER_TEST5;
    message.doCache=YES;
    [self sendMessage:message];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
