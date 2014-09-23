//
//  UIHyperlinksButton.h
//  ZhiJiaAnX
//
//  Created by 95190 on 13-10-12.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIHyperlinksButton : UIButton
{
    UIColor *lineColor;
    BOOL isHighlight;
}
-(void)setColor:(UIColor*)color;
+(UIHyperlinksButton *) hyperlinksButton;
@end
