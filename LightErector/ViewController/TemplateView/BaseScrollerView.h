//
//  BaseScrollerView.h
//  ZhiJiaAnX
//
//  Created by 95190 on 13-7-1.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUIView.h"

@interface BaseScrollerView : BaseUIView
{
@protected
    UIScrollView *_scrollerView;
    UIView *_aboveRefreshView;
    UIView *_belowRefreshView;
    UILabel *_lbl_aboveRefreshText;
    UILabel *_lbl_belowRefreshText;
}
@property(nonatomic,strong)UIView *aboveRefreshView;
@property(nonatomic,strong)UIView *belowRefreshView;
@end
