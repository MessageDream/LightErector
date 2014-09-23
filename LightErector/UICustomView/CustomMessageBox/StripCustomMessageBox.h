//
//  StripCustomMessageBox.h
//  G-NetLink
//
//  Created by jayden on 14-4-24.
//  Copyright (c) 2014年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIHyperlinksButton.h"

@interface StripCustomMessageBox : UIView
{
@protected
    UIImageView *_backgroundImageView;
    UIImage *_backgroundImage;
    UILabel *_lbl_text;
    NSString *_text;
    double _autoCloseTimer;
    BOOL _animation;
    UIHyperlinksButton *_btn_close;
}
@property(nonatomic,strong)NSString *text;
@property(nonatomic)double autoCloseTimer;
@property(nonatomic)BOOL animation;
-(id)initWithOriginY:(CGFloat)originY forText:(NSString*)text forBackgroundImage:(UIImage*)image;
@end
