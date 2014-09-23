//
//  CustomHelpCell.m
//  ZhiJiaX
//
//  Created by 95190 on 13-6-19.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import "CustomHelpCell.h"

#import "ResDefine.h"

@interface CustomHelpCell()
{
    
}
-(void)drawCutline;
@end

@implementation CustomHelpCell
@synthesize questionText = _questionText;
@synthesize answerText = _answerText;
@synthesize font;
@synthesize questionTextColor = _questionTextColor;
@synthesize answerTextColor = _answerTextColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        cutLineImageView = [[UIImageView alloc] init];
        //                            WithImage:[UIImage imageNamed:NSLocalizedStringFromTable(@"tableview_cut_line",Res_Image,@"")]];
        
        if(_cellType == CELL_TYPE_HELP)
            [self addSubview:cutLineImageView];
        
        _lbl_question = [[UILabel alloc] init];
        _lbl_answer = [[UILabel alloc] init];
        
        _lbl_question.backgroundColor = [UIColor greenColor];
        _lbl_answer.backgroundColor = [UIColor redColor];
        
        [self addSubview:_lbl_question];
        [self addSubview:_lbl_answer];
    }
    return self;
}
-(void)setAnswerTextColor:(UIColor *)answerTextColor
{
    _answerTextColor = answerTextColor;
    _lbl_answer.textColor = _answerTextColor;
}
-(void)setQuestionTextColor:(UIColor *)questionTextColor
{
    _questionTextColor = questionTextColor;
    _lbl_question.textColor = _questionTextColor;
}
-(void)drawCutline
{
    CGRect frame = cutLineImageView.frame;
    frame.origin.x = -20;
    frame.origin.y = _lbl_answer.frame.origin.y+_lbl_answer.frame.size.height+8;
    frame.size.height = 2;
    frame.size.width = frame.size.width;
    cutLineImageView.frame = frame;
    cutLineImageView.backgroundColor = [UIColor redColor];
    
    if(_cellType == CELL_TYPE_HELP)
        cutLineImageView.image = [UIImage imageNamed:NSLocalizedStringFromTable(@"tableview_cut_line",Res_Image,@"")];
    else
        cutLineImageView.image = nil;
    cutLineImageView.contentMode = UIViewContentModeScaleAspectFill;
}
-(void)setQuestionText:(NSString *)questionText
{
    _questionText = questionText;
    
    if(_questionText==nil)
        return;
    
    CGSize size = [questionText sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:CGSizeMake(260, MAXFLOAT)  lineBreakMode:NSLineBreakByWordWrapping];
    
    _lbl_question.frame = CGRectMake(5, 0, 260, size.height);
    _lbl_question.backgroundColor = [UIColor clearColor];
    _lbl_question.textAlignment = NSTextAlignmentLeft;
    _lbl_question.font = [UIFont systemFontOfSize:20];
    _lbl_question.text = questionText;
    _lbl_question.numberOfLines = 0;
    
    CGRect answerImageViewFrame = _answerImageView.frame;
    answerImageViewFrame.origin.y = _lbl_question.frame.origin.y+_lbl_question.frame.size.height+15;
    _answerImageView.frame = answerImageViewFrame;
    
}
-(void)setAnswerText:(NSString *)answerText
{
    _answerText = answerText;
    
    if(_answerText==nil)
        return;
    
    CGSize size = [_answerText sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(260, MAXFLOAT)  lineBreakMode:NSLineBreakByWordWrapping];
    
    _lbl_answer.frame = CGRectMake(5, _lbl_question.frame.size.height+10, 260, size.height);
    _lbl_answer.backgroundColor = [UIColor clearColor];
    _lbl_answer.textAlignment = NSTextAlignmentLeft;
    _lbl_answer.font = [UIFont systemFontOfSize:15];
    _lbl_answer.text = answerText;
    _lbl_answer.numberOfLines = 0;
    
    [self drawCutline];
}
-(double)calculateCellHeight
{
    NSLog(@"question height:%f",_lbl_question.bounds.size.height);
    NSLog(@"answer height:%f",_lbl_answer.bounds.size.height);
    
    //15是问题与答案之间的距离,另因为_questionImageView初始位置是(10,10)固需要下移10,
    //为了显示出两个不同cell，中间再增加10
    return _lbl_question.bounds.size.height+_lbl_answer.bounds.size.height + 15 + 10 + 10;
}

+(float) calculateCellHeightByQeustion:(NSString *) pQuestion andAnswer:(NSString *)pAnswer
{
    CGSize questionSize = [pQuestion sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:CGSizeMake(260, MAXFLOAT)  lineBreakMode:NSLineBreakByWordWrapping];
    CGSize answerSize = [pAnswer sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(260, MAXFLOAT)  lineBreakMode:NSLineBreakByWordWrapping];
    
    return questionSize.height + 10 + answerSize.height + 10;
}

@end
