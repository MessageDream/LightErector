//
//  CodeValidationViewController.m
//  LightErector
//
//  Created by Jayden on 14-10-5.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "CodeValidationViewController.h"
#import "CodeValidationView.h"
#import "ImageUtils.h"
#import "BaseCustomMessageBox.h"

@interface CodeValidationViewController ()<CodeValidationViewDelegate>

@end

@implementation CodeValidationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView
{
    CGRect rect=[self createViewFrame];
    rect.size.height=rect.size.height-64+20;
    CodeValidationView *view=[[CodeValidationView alloc] initWithFrame:rect];
    view.observer=self;
    self.view=view;
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

-(void)requestCode_click:(id)sender
{
    if (self.order) {
        self.order.observer=self;
        [self.order updateOrderStatusWithMemberId:user.userid flowStatus:UnValidateStatus];
        [self lockView];
    }
}

-(void)uploadCode_click:(NSString*)code
{
//    if (self.order) {
//        self.order.observer=self;
//        [self.order uploadCode:code];
//        [self lockView];
//    }
    [self.observer nextStep];
}

-(void)didDataModelNoticeSucess:(BaseDataModel *)baseDataModel forBusinessType:(BusinessType)businessID
{
    [super didDataModelNoticeSucess:baseDataModel forBusinessType:businessID];
    switch (businessID) {
        case BUSINESS_UPDATEORDERSTATUS:{
            UIImage *image=[ImageUtils createImageWithColor:[[MainStyle mainLightColor] colorWithAlphaComponent:0.8f] andSize:CGSizeMake(200.0f, 50.0f)];
            BaseCustomMessageBox *baseCustomMessageBox = [[BaseCustomMessageBox alloc] initWithText:@"验证码已经发送请查收" forBackgroundImage:image];
            baseCustomMessageBox.animation = YES;
            baseCustomMessageBox.autoCloseTimer = 2;
            [self.view addSubview:baseCustomMessageBox];
        }
            break;
        case BUSINESS_UPLOADCODE:
            if (self.observer&&[self.observer respondsToSelector:@selector(nextStep)]) {
                [self.observer nextStep];
            }
            break;
        default:
            break;
    }
}
@end
