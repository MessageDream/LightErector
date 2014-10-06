//
//  OrderDetailView.h
//  LightErector
//
//  Created by Jayden on 14-10-5.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "BaseUIView.h"
#import "CustomTextView.h"
#import "OrderInfoView.h"

@protocol  OrderDetailAndFeedBackViewDelegate<NSObject>
-(void)feedBackButton_Clicked:(NSString *)feed;
@end

@interface OrderDetailAndFeedBackView : BaseUIView
@property(nonatomic,strong) OrderInfoView *infoView;
@property(nonatomic,strong) UIView *feedBackView;
@property(nonatomic,strong) UILabel *titleLable;
@property(nonatomic,strong)CustomTextView *feedText;
@property(nonatomic,weak)id<OrderDetailAndFeedBackViewDelegate> observer;
@end
