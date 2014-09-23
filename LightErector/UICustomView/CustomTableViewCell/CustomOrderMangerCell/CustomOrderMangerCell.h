//
//  CustomOrderMangerCell.h
//  ZhiJiaX
//
//  Created by 95190 on 13-5-28.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomOrderMangerCell : UITableViewCell
{
@protected
    UIImageView *cutLineImageView;
    UILabel *_lbl_aboveText;
    UILabel *_lbl_belowText;
    UILabel *_lbl_bracketsText;
    UILabel *_lbl_firstBrackets;
    UILabel *_lbl_lastBrackets;
    
    NSString *_aboveText;
    NSString *_belowText;
    NSString *_bracketsText;
    UIColor *_bracketsTextColor;
}
@property(nonatomic,strong)NSString *aboveText;;
@property(nonatomic,strong)NSString *belowText;
@property(nonatomic,strong)NSString *bracketsText;
@property(nonatomic,strong)UIColor *bracketsTextColor;
-(double)calculateCellHeight;
@end
