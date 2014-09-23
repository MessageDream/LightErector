//
//  test5ViewController.m
//  NavDemo
//
//  Created by Jayden Zhao on 9/5/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "test5ViewController.h"
#import "test5View.h"

@interface test5ViewController ()

@end

@implementation test5ViewController

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
    _viewControllerId=VIEWCONTROLLER_TEST5;
}

-(void)loadView
{
    [super loadView];
    test5View *test =[[test5View alloc] initWithFrame:[self createViewFrame]];
    self.view=test;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(30, 20, 100, 50);
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    [test addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame=CGRectMake(30, 180, 100, 50);
    [btn1 setTitle:@"gotest6" forState:UIControlStateNormal];
    
    [btn1 addTarget:self action:@selector(gotest6) forControlEvents:UIControlEventTouchUpInside];
    [test addSubview:btn1];
}

-(void)goback
{
    Message *message = [[Message alloc] init];
    
    message.CommandID = MC_CREATE_CLOSEPOPFROMTOP_VIEWCONTROLLER;
    message.receiveObjectID = VIEWCONTROLLER_RETURN;
    [self sendMessage:message];
}



-(void)gotest6
{
    Message *message = [[Message alloc] init];
    
    message.CommandID = MC_CREATE_SCROLLERFROMRIGHT_VIEWCONTROLLER;
    message.receiveObjectID = VIEWCONTROLLER_TEST6;
    [self sendMessage:message];
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

@end
