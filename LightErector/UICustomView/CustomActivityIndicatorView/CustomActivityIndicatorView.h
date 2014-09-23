//
//  CustomActivityIndicatorView.h
//  ZhiJiaX
//
//  Created by 95190 on 13-6-6.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomActivityIndicatorView : UIView
{
@protected
    UIView *_backgroundView;
    UIActivityIndicatorView *activityIndicatorView;
    UIColor *_color;
    NSString *_showText;
    UILabel *_lbl_text;
}
@property(nonatomic,strong)UIColor *color;
@property(nonatomic,strong)NSString *showText;
-(void)startAnimating;
-(void)stopAnimating;
-(BOOL)isAnimating;
@end
