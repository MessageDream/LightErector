//
//  TitleBarView.h
//  ZhiJiaX
//
//  Created by 95190 on 13-5-23.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUIView.h"
#import "CustomTitleBar.h"


@interface TitleBarView : BaseUIView
{
@protected
    CustomTitleBar *_customTitleBar;
}
@property(nonatomic,readonly)CustomTitleBar *customTitleBar;
@property (nonatomic,assign)id<CustomTitleBar_ButtonDelegate>delegate_soon;

@end
