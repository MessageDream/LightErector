//
//  AppSettingView.m
//  LightErector
//
//  Created by Jayden Zhao on 10/27/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "AppSettingView.h"
#define DatePickerHeight 216
@interface AppSettingView()
@end
@implementation AppSettingView

-(id)initWithFrame:(CGRect)frame tableViewStyle:(UITableViewStyle)style
{
    if (self=[super initWithFrame:frame tableViewStyle:style]) {
         _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        self.backgroundColor=[MainStyle mainBackColor];
        self.customTitleBar.titleText= @"软件设置";
        self.customTitleBar.leftButtonImage=[UIImage imageNamed:@"nav_btn_right_return"];
        
        
        
        UIImage *image = [UIImage imageNamed:NSLocalizedStringFromTable(@"custom_uidatepicker_background",Res_Image,@"")];
        _ringView=[[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].applicationFrame.size.height-DatePickerHeight-image.size.height, [UIScreen mainScreen].applicationFrame.size.width, DatePickerHeight+image.size.height)];
                _ringView.backgroundColor=[UIColor clearColor];
        [        _ringView setHidden:YES];
        [self addSubview:        _ringView];
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:image];
        backgroundImageView.userInteractionEnabled = YES;
        [        _ringView addSubview:backgroundImageView];
        
        
        image = [UIImage imageNamed:NSLocalizedStringFromTable(@"custom_uidatepicker_cancel",Res_Image,@"")];
       UIButton * btn_cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_cancel.frame = CGRectMake(10,backgroundImageView.bounds.size.height/2-image.size.height/2,image.size.width,image.size.height);
        [btn_cancel setBackgroundImage:image forState:UIControlStateNormal];
        [btn_cancel addTarget:self action:@selector(cancelButton_onClick:) forControlEvents:UIControlEventTouchUpInside];
        [backgroundImageView addSubview:btn_cancel];
        
        
        image = [UIImage imageNamed:NSLocalizedStringFromTable(@"custom_uidatepicker_confirm",Res_Image,@"")];
       UIButton *  btn_confirm = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_confirm.frame = CGRectMake(backgroundImageView.bounds.size.width-image.size.width-10,backgroundImageView.bounds.size.height/2-image.size.height/2,image.size.width,image.size.height);
        [btn_confirm setBackgroundImage:image forState:UIControlStateNormal];
        [btn_confirm addTarget:self action:@selector(confirmButton_onClick:) forControlEvents:UIControlEventTouchUpInside];
        [backgroundImageView addSubview:btn_confirm];
        
        
        self.ringPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, backgroundImageView.bounds.size.height, self.bounds.size.width, 216)];
        [        _ringView addSubview:self.ringPicker];
        self.timePicker=[[CustomUIDatePicker alloc] initWithBottom];
        self.timePicker.datePickerMode=UIDatePickerModeTime;
        [self.timePicker setHidden:YES];
        [self addSubview:self.timePicker];
    }
    return self;
}

-(void)cancelButton_onClick:(id)sender
{
    [_ringView setHidden:YES];
}

-(void)confirmButton_onClick:(id)sender
{
    if (self.observer && [self.observer respondsToSelector:@selector(ringConfirmButton_onClick:)]) {
        [self.observer ringConfirmButton_onClick:[self.ringPicker selectedRowInComponent:0]];
    }
    [_ringView setHidden:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
