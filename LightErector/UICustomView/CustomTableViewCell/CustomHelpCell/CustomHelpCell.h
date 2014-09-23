//
//  CustomHelpCell.h
//  ZhiJiaX
//
//  Created by 95190 on 13-6-19.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>

enum HELP_LICENSE_TYPE
{
    CELL_TYPE_HELP = 0,
    CELL_TYPE_LICENSE = 1,
};

@interface CustomHelpCell : UITableViewCell
{
@protected
    UIImageView *cutLineImageView;
    UILabel *_lbl_question;
    UILabel *_lbl_answer;
    UIImageView *_questionImageView;
    UIImageView *_answerImageView;
    
    NSString *_questionText;
    NSString *_answerText;
    UIColor *_questionTextColor;
    UIColor *_answerTextColor;
}
@property(nonatomic,strong)NSString *questionText;
@property(nonatomic,strong)NSString *answerText;
@property(nonatomic,strong)UIFont *font;
@property(nonatomic,strong)UIFont *questionFont;
@property(nonatomic,strong)UIFont *answerFont;
@property(nonatomic,strong)UIColor *questionTextColor;
@property(nonatomic,strong)UIColor *answerTextColor;
@property(nonatomic)enum HELP_LICENSE_TYPE cellType;
-(double)calculateCellHeight;
+(float) calculateCellHeightByQeustion:(NSString *) pQuestion andAnswer:(NSString *)pAnswer;
@end
