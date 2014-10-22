//
//  FeedBackView.h
//  LightErector
//
//  Created by Jayden Zhao on 10/22/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "TitleBarAndScrollerView.h"
#import "CustomTextField.h"
#import "CustomTextView.h"

@protocol FeedBackViewDelegate <NSObject>
-(void)feedBackWithTitle:(NSString *)title andContent:(NSString *)content;
@end

@interface FeedBackView : TitleBarAndScrollerView
@property(nonatomic,strong)CustomTextField *feedTitle;
@property(nonatomic,strong)CustomTextView *feedContent;
@property(nonatomic,weak)id<FeedBackViewDelegate> observer;
@end
