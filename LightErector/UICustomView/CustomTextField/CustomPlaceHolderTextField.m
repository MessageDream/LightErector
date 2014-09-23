//
//  CustomPlaceHolderTextField.m
//  G-NetLink
//
//  Created by jayden on 14-4-23.
//  Copyright (c) 2014年 95190. All rights reserved.
//

#import "CustomPlaceHolderTextField.h"

@implementation CustomPlaceHolderTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)drawPlaceholderInRect:(CGRect)rect
{
    [[UIColor whiteColor] setFill];
    
    [self.placeholder drawInRect:CGRectMake(0, rect.size.height/2-self.font.lineHeight/2, rect.size.width, rect.size.height) withFont:self.font];
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
