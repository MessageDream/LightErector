//
//  UnSettlementTableViewCell.m
//  LightErector
//
//  Created by Jayden Zhao on 10/11/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "UnSettlementTableViewCell.h"

@implementation UnSettlementTableViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

-(void)layoutSubviews
{
    self.imageView.image=nil;
    [super layoutSubviews];
    CGRect rect= self.textLabel.frame;
    rect.origin.y=(self.frame.size.height- rect.size.height)/2;
    rect.size.width=rect.size.width*2;
    self.textLabel.frame=rect;
//    rect=self.priceLable.frame;
//    rect.origin.y=self.mobileLable.frame.origin.y;
//    rect.origin.x+=10;
//    rect.size.width+=10;
//    self.priceLable.frame=rect;
    
}
@end
