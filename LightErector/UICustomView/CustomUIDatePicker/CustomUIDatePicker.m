//
//  CustomUIDatePicker.m
//  ZhiJiaAnX
//
//  Created by 95190 on 13-7-17.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import "CustomUIDatePicker.h"
#import "ResDefine.h"

#define DatePickerHeight 216

@interface CustomUIDatePicker()
{
    UIButton *btn_cancel;
    UIButton *btn_confirm;
}
-(IBAction)cancelButton_onClick:(id)sender;
-(IBAction)confirmButton_onClick:(id)sender;
@end


@implementation CustomUIDatePicker
@synthesize date = _date;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(id)initWithBottom
{
    UIImage *image = [UIImage imageNamed:NSLocalizedStringFromTable(@"custom_uidatepicker_background",Res_Image,@"")];
    
    
    CGRect frame = CGRectMake(0, [UIScreen mainScreen].applicationFrame.size.height-DatePickerHeight-image.size.height, [UIScreen mainScreen].applicationFrame.size.width, DatePickerHeight+image.size.height);
    
    self = [self initWithFrame:frame];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:image];
    backgroundImageView.userInteractionEnabled = YES;
    [self addSubview:backgroundImageView];
    
    
    image = [UIImage imageNamed:NSLocalizedStringFromTable(@"custom_uidatepicker_cancel",Res_Image,@"")];
    btn_cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_cancel.frame = CGRectMake(10,backgroundImageView.bounds.size.height/2-image.size.height/2,image.size.width,image.size.height);
    [btn_cancel setBackgroundImage:image forState:UIControlStateNormal];
    [btn_cancel addTarget:self action:@selector(cancelButton_onClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundImageView addSubview:btn_cancel];
    
    
    image = [UIImage imageNamed:NSLocalizedStringFromTable(@"custom_uidatepicker_confirm",Res_Image,@"")];
    btn_confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_confirm.frame = CGRectMake(backgroundImageView.bounds.size.width-image.size.width-10,backgroundImageView.bounds.size.height/2-image.size.height/2,image.size.width,image.size.height);
    [btn_confirm setBackgroundImage:image forState:UIControlStateNormal];
    [btn_confirm addTarget:self action:@selector(confirmButton_onClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundImageView addSubview:btn_confirm];
    
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, backgroundImageView.bounds.size.height, self.bounds.size.width, 216)];
    //[datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    if(_endDate != nil)
        [datePicker setMaximumDate:_endDate];
    [self addSubview:datePicker];
    
    return self;
}

-(void) setEndDate:(NSDate *)endDate
{
    _endDate = endDate;
    if(endDate != nil)
       [datePicker setMaximumDate:endDate];
}

-(IBAction)cancelButton_onClick:(id)sender
{
    [self.observer cancelButton_onClick:sender];
    
    [self removeFromSuperview];
}
-(IBAction)confirmButton_onClick:(id)sender
{
    [self.observer confirmButton_onClick:sender forDate:datePicker.date];
    [self removeFromSuperview];
}
-(void)setDate:(NSDate *)date
{
    _date = date;
    datePicker.date = date;
}
-(NSDate*)date
{
    return datePicker.date;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
