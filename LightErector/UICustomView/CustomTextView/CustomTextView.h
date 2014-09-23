//
//  CustomTextView.h
//  ZhiJiaX
//
//  Created by 95190 on 13-6-18.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextView : UIView<UITextViewDelegate>
{
@protected
    UITextView *_textView;
    UIImageView *_frameImageView;
    NSString *_text;
    NSString *_placeholder;
    UILabel *_lbl_placeholder;
    UIImage *_backgroundImage;
}
@property(nonatomic,strong)NSString *text;
@property(nonatomic,strong)NSString *placeholder;
@property(nonatomic,strong)UIImage *backgroundImage;
@end
