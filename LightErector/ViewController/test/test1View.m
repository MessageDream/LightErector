//
//  test1View.m
//  NavDemo
//
//  Created by Jayden Zhao on 8/28/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "test1View.h"

@implementation test1View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor redColor];
        UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(100, 50, 100, 50);
        [btn setTitle:@"Test1" forState:UIControlStateNormal];
        [self addSubview:btn];
        
        UIButton *btn2= [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame=CGRectMake(100, 70, 100, 50);
        [btn2 setTitle:@"Test2" forState:UIControlStateNormal];
        [self addSubview:btn2];
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

@end
