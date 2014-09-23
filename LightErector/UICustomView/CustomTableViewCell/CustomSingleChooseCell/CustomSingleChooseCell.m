//
//  CustomSingleChooseCell.m
//  Test04
//
//  Created by wei.xu.95190 on 13-7-26.
//
//

#import "CustomSingleChooseCell.h"

@implementation CustomSingleChooseCell
@synthesize xShift=_xShift,labTitle=_labTitle,selectImageView=_selectImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _labTitle = [[UILabel alloc]initWithFrame:CGRectMake(30, 4, 120, 45.0f)];
        _labTitle.backgroundColor = [UIColor clearColor];
        [self addSubview:_labTitle];
        
        _selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(220, 8, 30, 30)];
        [self addSubview:_selectImageView];
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    if(selected)
    {
    }
    else
    {
    }
    
}


//- (void)setFrame:(CGRect)frame
//{
//    frame.origin.x += _xShift;
//    frame.origin.y -= 3;
//    frame.size.width -= _xShift*2;
//    
//    [super setFrame:frame];
//}

@end
