//
//  CustomOrderMangerCell.m
//  ZhiJiaX
//
//  Created by 95190 on 13-5-28.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import "CustomOrderMangerCell.h"
#import "ResDefine.h"

@interface CustomOrderMangerCell()
{
    
}
-(void)drawCutline;
@end


@implementation CustomOrderMangerCell
@synthesize aboveText = _aboveText;
@synthesize belowText = _belowText;
@synthesize bracketsText = _bracketsText;
@synthesize bracketsTextColor = _bracketsTextColor;

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
    
    cutLineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NSLocalizedStringFromTable(@"tableview_cut_line",Res_Image,@"")]];
    [self addSubview:cutLineImageView];
    
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:NSLocalizedStringFromTable(@"table_arrow2",Res_Image,@"")]];
    self.accessoryView = arrowImageView;
    return self;
}
-(void)drawCutline
{
    CGRect frame = cutLineImageView.frame;
    frame.origin.x = 10;
    frame.origin.y = _lbl_belowText.frame.origin.y+_lbl_belowText.frame.size.height+5-frame.size.height;
    cutLineImageView.frame = frame;
}
-(void)setAboveText:(NSString *)aboveText
{
    _aboveText = aboveText;
    
    if(_lbl_aboveText == nil)
    {
        CGSize size = [_aboveText sizeWithFont:[UIFont systemFontOfSize:16]];
        _lbl_aboveText = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, size.width, size.height)];
        _lbl_aboveText.backgroundColor = [UIColor clearColor];
        _lbl_aboveText.textAlignment = NSTextAlignmentLeft;
        _lbl_aboveText.font = [UIFont systemFontOfSize:16];
        [self addSubview:_lbl_aboveText];
        
        if(_lbl_belowText!=nil)
        {
            CGRect frame = _lbl_belowText.frame;
            frame.origin.y = _lbl_aboveText.frame.origin.y+_lbl_aboveText.frame.size.height+5;
            _lbl_belowText.frame = frame;
            
            [self drawCutline];
        }
    }
    _lbl_aboveText.text = _aboveText;
}
-(void)setBelowText:(NSString *)belowText
{
    _belowText = belowText;
    
    if(_lbl_belowText == nil)
    {
        CGSize size = [_belowText sizeWithFont:[UIFont systemFontOfSize:14]];
        int y = 10;
        if(_lbl_aboveText!=nil)
            y = _lbl_aboveText.frame.origin.y+_lbl_aboveText.frame.size.height+5;
            
        _lbl_belowText = [[UILabel alloc] initWithFrame:CGRectMake(10, y, size.width, size.height)];
        _lbl_belowText.backgroundColor = [UIColor clearColor];
        _lbl_belowText.textAlignment = NSTextAlignmentLeft;
        _lbl_belowText.font = [UIFont systemFontOfSize:14];
        _lbl_belowText.textColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f  blue:153.0f/255.0f  alpha:1];
        [self addSubview:_lbl_belowText];
        
        [self drawCutline];
    }
    _lbl_belowText.text = _belowText;
}
-(void)setBracketsText:(NSString *)bracketsText
{
    _bracketsText = bracketsText;
    
    if(_lbl_bracketsText==nil)
    {
        int x = 10;
        int y = 10;
        if(_lbl_aboveText!=nil)
        {
            y = _lbl_aboveText.frame.origin.y;
            x = _lbl_aboveText.frame.origin.x+_lbl_aboveText.frame.size.width+5;
        }
        CGSize size = [_bracketsText sizeWithFont:[UIFont systemFontOfSize:16]];
        
        _lbl_firstBrackets = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 5, size.height)];
        _lbl_firstBrackets.backgroundColor = [UIColor clearColor];
        _lbl_firstBrackets.textAlignment = NSTextAlignmentLeft;
        _lbl_firstBrackets.font = [UIFont systemFontOfSize:16];
        _lbl_firstBrackets.text = @"(";
        [self addSubview:_lbl_firstBrackets];
        
        
        _lbl_bracketsText = [[UILabel alloc] initWithFrame:CGRectMake(_lbl_firstBrackets.frame.origin.x+_lbl_firstBrackets.frame.size.width+5, y, size.width, size.height)];
        _lbl_bracketsText.backgroundColor = [UIColor clearColor];
        _lbl_bracketsText.textAlignment = NSTextAlignmentLeft;
        _lbl_bracketsText.font = [UIFont systemFontOfSize:16];
        [self addSubview:_lbl_bracketsText];
        
        
        _lbl_lastBrackets = [[UILabel alloc] initWithFrame:CGRectMake(_lbl_bracketsText.frame.origin.x+_lbl_bracketsText.frame.size.width+5, y, 5, size.height)];
        _lbl_lastBrackets.backgroundColor = [UIColor clearColor];
        _lbl_lastBrackets.textAlignment = NSTextAlignmentLeft;
        _lbl_lastBrackets.font = [UIFont systemFontOfSize:16];
        _lbl_lastBrackets.text = @")";
        [self addSubview:_lbl_lastBrackets];
    }
    _lbl_bracketsText.text = _bracketsText;
}
-(void)setBracketsTextColor:(UIColor *)bracketsTextColor
{
    _bracketsTextColor = bracketsTextColor;
    
    if(_lbl_bracketsText!=nil)
        _lbl_bracketsText.textColor = _bracketsTextColor;
}
-(double)calculateCellHeight
{
    return 10+10+5+_lbl_aboveText.bounds.size.height+_lbl_belowText.bounds.size.height;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
