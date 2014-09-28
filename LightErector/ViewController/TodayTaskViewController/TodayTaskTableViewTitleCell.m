//
//  TodayTaskTableViewDetailCellTableViewCell.m
//  LightErector
//
//  Created by Jayden Zhao on 9/28/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "TodayTaskTableViewTitleCell.h"
@implementation TodayTaskTableViewTitleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        self.imageView.image=[UIImage imageNamed:@"light"];
//        CGFloat lspace=71.0f;
//        UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(lspace, self.frame.size.height-0.5, self.frame.size.width-lspace, 0.5)];
//        lineView.backgroundColor=[UIColor lightGrayColor];
//        [self addSubview:lineView];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)createOptionButtonWithTitle:(NSString *)title andIcon:(UIImage *)icon andBackgroundColor:(UIColor *)backColor
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = backColor;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setImage:icon forState:UIControlStateNormal];
    [button sizeToFit];
    CGRect frame = button.frame;
    frame.size.height=self.frame.size.height;
    frame.size.width += 10; //padding
    frame.size.width = MAX(50, frame.size.width); //initial min size
    frame.origin.x=self.frame.size.width- frame.size.width;
    button.frame = frame;
    self.optionButton=button;
    if (button.superview!=self) {
        [self addSubview:self.optionButton];
    }
}
@end
