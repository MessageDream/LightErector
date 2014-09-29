//
//  TodayTaskTableViewDetailCellTableViewCell.h
//  LightErector
//
//  Created by Jayden Zhao on 9/28/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "CustomSwipeTableCell.h"

@interface TodayTaskTableViewTitleCell : CustomSwipeTableCell
@property(nonatomic,strong)UIButton *optionButton;
-(void)createOptionButtonWithTitle:(NSString *)title andIcon:(UIImage *)icon andBackgroundColor:(UIColor *)backColor;
@end
