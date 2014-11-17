//
//  ChangeUserInfoView.h
//  LightErector
//
//  Created by Jayden Zhao on 10/21/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "TitleBarAndScrollerView.h"
#import "CustomTextField.h"
#import "TextFiledReturnEditingDelegate.h"

@protocol ChangeUserInfoViewDelegate <NSObject>
-(void)submit_change_onclick:(id)sender;
@end

@interface ChangeUserInfoView : TitleBarAndScrollerView
{
@private
    __weak id _observer;
}
@property (nonatomic,readonly)CustomTextField  *address;
@property (nonatomic,readonly)CustomTextField  *qq;
@property (nonatomic,readonly)CustomTextField  *email;
@property (nonatomic,readonly)CustomTextField  *telephone;
@property (nonatomic,readonly)CustomTextField  *mobilephone;
@property (nonatomic,readonly)UIButton  *btn_change;
@property(nonatomic,weak)id<ChangeUserInfoViewDelegate,TextFiledReturnEditingDelegate> observer;
@end
