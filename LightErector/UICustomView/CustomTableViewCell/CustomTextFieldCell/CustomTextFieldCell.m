//
//  CustomTextFieldCell.m
//  ZhiJiaAnX
//
//  Created by wei.xu.95190 on 13-7-24.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import "CustomTextFieldCell.h"

@implementation CustomTextFieldCell
@synthesize txt_content=_txt_content;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _txt_content = [[CustomTextField alloc]init];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
