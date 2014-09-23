//
//  CustomUIRadioButton.h
//  ZhiJiaX
//
//  Created by jishu on 13-5-21.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CustomUIRadioButton;
//单选按钮协议
@protocol selectionButtonDelegate
//按钮被点击了
-(void)selectionButton:(CustomUIRadioButton *)selectionButton didChangedTo:(BOOL)isSelected;
@end


@interface CustomUIRadioButton : UIButton

@property (assign, nonatomic)id <selectionButtonDelegate>selectionDelegate;
@property(nonatomic,getter = isSelected,setter = setSelected:,readwrite)BOOL selected;
//初始化
-(id)initWithSelected:(BOOL)isSelected;
//Setter
-(void)setSelected:(BOOL)isSelected;


@end
