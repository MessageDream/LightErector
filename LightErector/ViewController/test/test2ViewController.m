//
//  test2ViewController.m
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "test2ViewController.h"
#import "CustomImageZoomView.h"


@interface test2ViewController ()

@end

@implementation test2ViewController

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
    _viewControllerId=VIEWCONTROLLER_TEST2;
}

-(void)loadView
{
    [super loadView];
    test2View *test=[[test2View alloc] initWithFrame:[self createViewFrame]];
    test.delegate=self;
    self.view=test;
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

-(void)imageTap:(UITapGestureRecognizer *)sender
{
    [CustomImageZoomView showImage:(UIImageView*)sender.view];
}

@end
