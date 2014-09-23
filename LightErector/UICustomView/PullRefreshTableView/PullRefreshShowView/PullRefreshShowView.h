//
//  PullRefreshShowView.h
//  pullRefreshTableView
//
//  Created by 95190 on 13-8-13.
//  Copyright (c) 2013年 sunhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PullRefreshShowView : UIView
{
@protected
    UIActivityIndicatorView *activityIndicatorView;
    UILabel *lbl_text;
    NSString *_readyText;
    NSString *_refreshText;
    UIColor *_textColor;
}
@property(nonatomic,strong)NSString *readyText;
@property(nonatomic,strong)NSString *refreshText;
@property(nonatomic,strong)UIColor *textColor;
-(void)ready;
-(void)refresh;
@end
