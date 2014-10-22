//
//  FeedBackViewController.m
//  LightErector
//
//  Created by Jayden Zhao on 10/22/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "FeedBackViewController.h"
#import "FeedBackView.h"

@interface FeedBackViewController ()<FeedBackViewDelegate>
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)feedBackWithTitle:(NSString *)title andContent:(NSString *)content
{

}
@end
