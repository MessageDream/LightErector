//
//  CustomHeadView.h
//
//
//  Created by xuwei on 26/7/13
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomHeadViewDelegate;

@interface CustomHeadView : UIView

@property(nonatomic, assign) id<CustomHeadViewDelegate> delegate;
@property(nonatomic) BOOL open;
@property(nonatomic, strong) UIButton* backBtn;
@property(nonatomic, strong) NSArray *arrySelectOption;
@property(nonatomic, strong) UILabel *labTitle;
@property(nonatomic, strong) UILabel *labValue;
@property(nonatomic) NSInteger iSelectedNum;        //当前选中值
@property(nonatomic) NSInteger tag;
@property(nonatomic) UIImageView *imageOpen;    //状态指示图标
@end

@protocol CustomHeadViewDelegate <NSObject>
-(void)selectedWith:(CustomHeadView *)view;
@end
