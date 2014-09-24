//
//  test1ViewController.m
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "test1ViewController.h"
#import "test1View.h"

@interface test1ViewController ()

@end

@implementation test1ViewController

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
    _viewControllerId=VIEWCONTROLLER_TEST1;
}

-(void)loadView
{
    [super loadView];
    CGRect frame=[self createViewFrame];
    frame.size.height=  frame.size.height-50;
    test1View *test1=[[test1View alloc] initWithFrame:frame];
    self.view=test1;
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
