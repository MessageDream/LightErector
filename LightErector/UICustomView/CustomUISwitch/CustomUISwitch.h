//
//  CustomUISwitch.h
//  ZhiJiaX
//
//  Created by 95190 on 13-5-17.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomUISwitchDelegate <NSObject>
-(void)didSwitchButton:(id)sender forStatus:(BOOL)status;
@end

@interface CustomUISwitch : UIView
{
@protected
    UIImage *_onBackgroundImage;
    UIImage *_offBackgroundImage;
    UIImage *_switchButtonImage;
    BOOL _status;
}
@property(nonatomic)BOOL status;
@property(nonatomic,assign)id<CustomUISwitchDelegate> observer;
-(id)initWithImage:(UIImage*)onBackgroundImage forOffBackgroundImage:(UIImage*)offBackgroundImage forSwitchButtonImage:(UIImage*)switchButtonImage;
@end
