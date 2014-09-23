//
//  CustomUIDatePicker.h
//  ZhiJiaAnX
//
//  Created by 95190 on 13-7-17.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomUIDatePickerDelegate <NSObject>
-(IBAction)cancelButton_onClick:(id)sender;
-(IBAction)confirmButton_onClick:(id)sender forDate:(NSDate*)date;
@end

@interface CustomUIDatePicker : UIView
{
@protected
    UIDatePicker *datePicker;
    NSDate *_date;
}
@property(nonatomic,strong)NSDate *date;
@property(nonatomic,assign)id<CustomUIDatePickerDelegate> observer;
@property (nonatomic,strong) NSDate *endDate;
-(id)initWithBottom;
@end
