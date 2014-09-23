//
//  test4View.m
//  NavDemo
//
//  Created by Jayden Zhao on 8/28/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "test4View.h"

@implementation test4View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor blackColor];
        
        UITextField *text=[[UITextField alloc] initWithFrame:CGRectMake(100, 100, 150, 50)];
        text.backgroundColor=[UIColor blueColor];
        [self addSubview:text];
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
