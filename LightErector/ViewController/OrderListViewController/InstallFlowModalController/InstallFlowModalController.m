//
//  InstallFlowViewController.m
//  LightErector
//
//  Created by Jayden on 14-10-3.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "InstallFlowModalController.h"
#import "ReachTerminalViewController.h"
#import "MZFormSheetController.h"
#import "StepBaseViewController.h"
#import "OrderDetailAndFeedBackViewController.h"
#import "CodeValidationViewController.h"
#import "UploadImageValidationViewController.h"
#import "MainStyle.h"

#define DETAILTAG 1108
#define FEEDTAG 1109
@interface InstallFlowModalController ()<StepBaseViewControllerDelegate>
{
}
@end

@implementation InstallFlowModalController

-initWithOrder:(Order *)order andClosedBlock:(void(^)(InstallFlowModalController *controller)) whenCLosed
{
    if (self=[super init]) {
        _currentOrder=order;
        _whenCLosed=whenCLosed;
    }
    return self;
}

- (NSArray *)stepViewControllers {
    StepBaseViewController *firstStep = [[ReachTerminalViewController alloc] init];
    firstStep.observer=self;
    firstStep.step.title = @"到达目的地";
    firstStep.order=self.currentOrder;
    CodeValidationViewController *secondStep = [[CodeValidationViewController alloc] init];
    secondStep.observer=self;
    secondStep.step.title = @"核对验证码";
    secondStep.order=self.currentOrder;
    UploadImageValidationViewController *thirdStep = [[UploadImageValidationViewController alloc] init];
    thirdStep.observer=self;
    thirdStep.step.title = @"上传验证";
    thirdStep.order=self.currentOrder;
    return @[firstStep,secondStep,thirdStep];
}

- (void)finishedAllSteps {
    [self dismissViewControllerAnimated:YES completion:^{
        if (_whenCLosed) {
            _whenCLosed(self);
        }
    }];
}

- (void)canceled {
    [self dismissViewControllerAnimated:YES completion:^{
        if (_whenCLosed) {
            _whenCLosed(self);
        }
    }];
}

#pragma mark - StepBaseViewControllerDelegate
-(void)nextStep
{
    [self showNextStep];
}
-(void)previousStep
{
    [self showPreviousStep];
}

-(void)closeStep:(id)ext
{
    self.extData=ext;
    [self canceled];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *optView=[[UIView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height-64, self.view.frame.size.width, 64)];
    optView.backgroundColor=[UIColor clearColor];
    optView.layer.zPosition=self.stepsBar.layer.zPosition;
    UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, optView.frame.size.width, 1)];
    lineView.backgroundColor=[MainStyle mainDarkColor];
    [optView addSubview:lineView];
    [self.view addSubview:optView];
    
    UIImage *image=[UIImage imageNamed:@"detail"];
    
    CGFloat space=(self.view.frame.size.width-image.size.width*2)/3;
    
    UIButton *btnOne=[UIButton buttonWithType:UIButtonTypeCustom];
     btnOne.frame=CGRectMake(space, 3, image.size.width , image.size.height) ;
    [btnOne setImage:image forState:UIControlStateNormal];
    btnOne.tag=DETAILTAG;
    [btnOne addTarget:self action:@selector(showFormSheet:) forControlEvents:UIControlEventTouchUpInside];
    [optView addSubview:btnOne];
    
    NSString *titleOne=@"订单详情";
    UIFont *tfont=[UIFont systemFontOfSize:12];

    UILabel *btnOneLable=[[UILabel alloc] initWithFrame:CGRectMake(btnOne.frame.origin.x-(60-image.size.width)/2, btnOne.frame.origin.y+image.size.height, 60, tfont.lineHeight)];
    btnOneLable.backgroundColor=[UIColor clearColor];
    btnOneLable.textAlignment=NSTextAlignmentCenter;
    btnOneLable.textColor=[MainStyle mainTitleColor];
    btnOneLable.font=tfont;
    btnOneLable.text=titleOne;
    [optView addSubview:btnOneLable];
    
    image=[UIImage imageNamed:@"feedback"];
    
    UIButton *btnTwo=[UIButton buttonWithType:UIButtonTypeCustom];
    btnTwo.tag=FEEDTAG;
    btnTwo.frame=CGRectMake(space*2+image.size.width, 3, image.size.width , image.size.height) ;
    [btnTwo setImage:image forState:UIControlStateNormal];
    [btnTwo addTarget:self action:@selector(showFormSheet:) forControlEvents:UIControlEventTouchUpInside];
    [optView addSubview:btnTwo];
    
    
    NSString *titleTwo=@"失败反馈";
    UILabel *btnTwoLable=[[UILabel alloc] initWithFrame:CGRectMake(btnTwo.frame.origin.x-(60-image.size.width)/2, btnTwo.frame.origin.y+image.size.height, 60, tfont.lineHeight)];
    btnTwoLable.backgroundColor=[UIColor clearColor];
    btnTwoLable.textAlignment=NSTextAlignmentCenter;
    btnTwoLable.textColor=[MainStyle mainTitleColor];
    btnTwoLable.font=tfont;
    btnTwoLable.text=titleTwo;
    [optView addSubview:btnTwoLable];
    
    [[MZFormSheetBackgroundWindow appearance] setBackgroundBlurEffect:NO];
    [[MZFormSheetBackgroundWindow appearance] setBlurRadius:5.0];
    [[MZFormSheetBackgroundWindow appearance] setBackgroundColor:[UIColor colorWithWhite:0.5f alpha:0.6f]];
    if (self.currentOrder.installStatus<=self.childViewControllers.count) {
        StepBaseViewController *controller=[self.childViewControllers objectAtIndex:self.currentOrder.installStatus-1];
        if (controller) {
            [self showStepViewController:controller animated:NO];
        }
    }
}

- (IBAction)showFormSheet:(UIButton *)sender
{
    OrderDetailAndFeedBackViewController *vc = [[OrderDetailAndFeedBackViewController alloc] init];
    vc.order=self.currentOrder;
    if(sender.tag==DETAILTAG){
        vc.isDetail=YES;
    }
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithSize:vc.view.frame.size viewController:vc];
    
    formSheet.transitionStyle = MZFormSheetTransitionStyleDropDown;
    formSheet.shadowRadius = 2.0;
    formSheet.shadowOpacity = 0.3;
    formSheet.shouldDismissOnBackgroundViewTap = YES;
    formSheet.shouldCenterVerticallyWhenKeyboardAppears = YES;
    formSheet.fromViewController=self.currentStepViewController;
    [formSheet presentAnimated:YES completionHandler:^(UIViewController *presentedFSViewController) {
        
    }];
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
