//
//  FindPasswordFromPhoneView.h
//  LightErector
//
//  Created by Jayden Zhao on 9/24/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUIView.h"
#import "CustomTextField.h"
#import "TextFiledReturnEditingDelegate.h"

@protocol FindPasswordFromPhoneViewDelegate <NSObject>
-(IBAction)findPasswordConfirmButton_onClick:(id)sender;
-(IBAction)findPasswordCancelButton_onClick:(id)sender;
@end

@interface FindPasswordFromPhoneView : BaseUIView
{
@protected
    CustomTextField *_txt_userName;
}
@property(nonatomic,readonly)CustomTextField *txt_userName;
@property(nonatomic,readonly)CustomTextField *txt_veryCode;
@property(nonatomic,readonly)CustomTextField *txt_password;
@property(nonatomic,readonly)CustomTextField *txt_confirmpassword;
@property(nonatomic,assign)id<FindPasswordFromPhoneViewDelegate,TextFiledReturnEditingDelegate> eventObserver;
-(id)initWithBottom;
@end
