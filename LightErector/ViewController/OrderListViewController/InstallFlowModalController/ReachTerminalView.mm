//
//  ReachTerminalView.m
//  LightErector
//
//  Created by Jayden on 14-10-4.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "ReachTerminalView.h"
@interface ReachTerminalView()
@end
@implementation ReachTerminalView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[MainStyle mainBackColor];
        _mapView=[[BMKMapView alloc] initWithFrame:CGRectMake(0, 64, frame.size.width, frame.size.height-128)];
        _mapView.mapType=BMKMapTypeStandard;
        _mapView.zoomLevel = 14;
        [self addSubview:_mapView];
        UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0, _mapView.frame.origin.y+_mapView.frame.size.height, frame.size.width, 1)];
        lineView.backgroundColor=[MainStyle mainDarkColor];
        [self addSubview:lineView];
        
        UIView *spView=[[UIView alloc] initWithFrame:CGRectMake(0,  lineView.frame.origin.y+lineView.frame.size.height, frame.size.width, frame.size.height-(lineView.frame.origin.y+lineView.frame.size.height))];
        spView.backgroundColor=[MainStyle mainLightTwoColor];
         [self addSubview:spView];
        UIImage *image=[UIImage imageNamed:@"location"];
        UIButton *btnOne=[UIButton buttonWithType:UIButtonTypeCustom];
        btnOne.frame=CGRectMake((frame.size.width-image.size.width)/2,3, image.size.width , image.size.height) ;
        [btnOne setImage:image forState:UIControlStateNormal];
        [btnOne addTarget:self action:@selector(reach_terminal_click:) forControlEvents:UIControlEventTouchUpInside];
        [spView addSubview:btnOne];
        
        NSString *titleOne=@"确认到达安装点";
        UIFont *tfont=[UIFont systemFontOfSize:12];
        
        UILabel *btnOneLable=[[UILabel alloc] initWithFrame:CGRectMake(btnOne.frame.origin.x-(100-image.size.width)/2, btnOne.frame.origin.y+image.size.height, 100, tfont.lineHeight)];
        btnOneLable.backgroundColor=[UIColor clearColor];
        btnOneLable.textAlignment=NSTextAlignmentCenter;
        btnOneLable.textColor=[MainStyle mainBackColor];
        btnOneLable.font=tfont;
        btnOneLable.text=titleOne;
        [spView addSubview:btnOneLable];
    }
    return self;
}

-(void)reach_terminal_click:(id)sender
{
    if (self.observer&&[self.observer respondsToSelector:@selector(reach_terminal_click:)]) {
        [self.observer reach_terminal_click:sender];
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

-(void)dealloc
{
    _mapView=nil;
    self.observer=nil;
}
@end
