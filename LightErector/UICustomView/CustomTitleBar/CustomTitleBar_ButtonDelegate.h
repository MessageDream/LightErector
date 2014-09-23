//
//  CustomTitleBar_ButtonDelegate.h
//  ZhiJiaXNew
//
//  Created by 95190 on 14-2-18.
//  Copyright (c) 2014年 95190. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CustomTitleBar_ButtonDelegate <NSObject>
@optional
-(IBAction)leftButton_onClick:(id)sender;
-(IBAction)rightButton_onClick:(id)sender;
@end
