//
//  CustomArticleAlertView.h
//  ZhiJiaX
//
//  Created by 95190 on 13-5-27.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomAlertView.h"

@interface CustomArticleAlertView : CustomAlertView
{
@protected
    UITextView *_textView;
    UILabel *_lbl_title;
}
@property(nonatomic,readonly)UITextView *textView;
@property(nonatomic,readonly)UILabel *lbl_title;
@end
