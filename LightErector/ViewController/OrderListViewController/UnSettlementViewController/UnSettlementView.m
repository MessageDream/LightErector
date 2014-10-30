//
//  UnSettlementView.m
//  LightErector
//
//  Created by Jayden Zhao on 10/11/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "UnSettlementView.h"

@implementation UnSettlementView

- (id)initWithFrame:(CGRect)frame tableViewStyle:(UITableViewStyle)style
{
    self = [super initWithFrame:frame tableViewStyle:style];
    if (self) {
        // Initialization code
        self.customTitleBar.titleText= @"待结算";
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
-(void)dealloc
{
}
@end
