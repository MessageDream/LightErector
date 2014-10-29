//
//  AppSettingView.h
//  LightErector
//
//  Created by Jayden Zhao on 10/27/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "TitleBarAndTableView.h"
#import "CustomUIDatePicker.h"
@protocol AppSettingViewDelegate<NSObject>
-(void)ringConfirmButton_onClick:(NSInteger)index;
@end
@interface AppSettingView : TitleBarAndTableView
@property(nonatomic,strong)CustomUIDatePicker *timePicker;
@property(nonatomic,strong)UIPickerView *ringPicker;
@property(nonatomic,strong) UIView *ringView;
@property(nonatomic,weak)id<AppSettingViewDelegate> observer;
@end
