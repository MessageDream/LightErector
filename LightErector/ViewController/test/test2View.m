//
//  test2View.m
//  NavDemo
//
//  Created by Jayden Zhao on 8/28/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "test2View.h"

@implementation test2View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor greenColor];
        UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(100, 50, 100, 50);
        [btn setTitle:@"Test1" forState:UIControlStateNormal];
        [self addSubview:btn];
        
        UIButton *btn2= [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame=CGRectMake(100, 70, 100, 50);
        [btn2 setTitle:@"Test2" forState:UIControlStateNormal];
        [self addSubview:btn2];

        
        UITapGestureRecognizer *gestureRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
//        NSURL *url = [NSURL URLWithString: @"http://www.huabian.com/uploadfile/2014/0606/20140606024417539.jpg"];
//        
//        UIImage *image=[UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
        UIImage *image=[UIImage imageNamed:@"demo"];
        UIImageView * imageView=[[UIImageView alloc] initWithFrame:CGRectMake(50, 100, image.size.width/3, image.size.height/3)];
        imageView.image=image;
        [imageView addGestureRecognizer:gestureRecognizer];
        imageView.userInteractionEnabled=YES;
        [self addSubview:imageView];
    }
    return self;
}

-(void)tap:(UITapGestureRecognizer *)sender
{
    if (self.delegate) {
        [self.delegate performSelector:@selector(imageTap:) withObject:sender];
    }
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
