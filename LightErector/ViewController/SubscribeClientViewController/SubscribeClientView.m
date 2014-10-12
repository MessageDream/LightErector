//
//  SubscribeClientView.m
//  LightErector
//
//  Created by Jayden Zhao on 10/11/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "SubscribeClientView.h"
@interface SubscribeClientView()
{
    UIView *lineView;
    UIButton *btnOne;
    UIButton *btnTwo;
    UILabel *btnOneLable;
    UILabel *btnTwoLable;
    UIView *selectView;
}
@end

@implementation SubscribeClientView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[MainStyle mainBackColor];
        self.customTitleBar.titleText=@"预约客户";
        self.customTitleBar.leftButtonImage=[UIImage imageNamed:@"nav_btn_right_return"];
       CGRect rect= self.scrollerView.frame;
        rect.size.height=self.frame.size.height-self.customTitleBar.frame.size.height-self.customTitleBar.frame.origin.y;
        self.scrollerView.frame=rect;
        self.scrollerView.scrollEnabled=YES;
        
        self.infoView=[[OrderInfoView alloc] initWithFrame:CGRectMake(0,  0, self.frame.size.width, 0)];
        self.nameLable=self.infoView.nameLable;
        self.phoneLable=self.infoView.phoneLable;
        self.subscribeTimeLable=self.infoView.subscribeTimeLable;
        self.addressLable=self.infoView.addressLable;
        self.detailLable=self.infoView.detailLable;
        self.remarkLable=self.infoView.remarkLable;
        
        self.sDetailLable=self.infoView.sDetailLable;
        self.sRemarkLable=self.infoView.sRemarkLable;
        [self.scrollerView addSubview:self.infoView];
       
        lineView=[[UIView alloc] initWithFrame:CGRectMake(0,self.infoView.frame.origin.y+self.infoView.frame.size.height+10, self.frame.size.width, 1)];
        lineView.backgroundColor=[MainStyle mainDarkColor];
        [self.scrollerView addSubview:lineView];
        
        
        UIImage *image=[UIImage imageNamed:@"phone"];
        
        CGFloat space=(self.frame.size.width-image.size.width*2)/3;
        
        btnOne=[UIButton buttonWithType:UIButtonTypeCustom];
        btnOne.frame=CGRectMake(space, lineView.frame.origin.y+lineView.frame.size.height+3, image.size.width , image.size.height) ;
        [btnOne setImage:image forState:UIControlStateNormal];
        [btnOne addTarget:self action:@selector(call_btn_click:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollerView addSubview:btnOne];
        
        NSString *titleOne=@"立即预约";
        UIFont *tfont=[UIFont systemFontOfSize:12];
        
       btnOneLable=[[UILabel alloc] initWithFrame:CGRectMake(btnOne.frame.origin.x-(60-image.size.width)/2, btnOne.frame.origin.y+image.size.height, 60, tfont.lineHeight)];
        btnOneLable.backgroundColor=[UIColor clearColor];
        btnOneLable.textAlignment=NSTextAlignmentCenter;
        btnOneLable.textColor=[MainStyle mainTitleColor];
        btnOneLable.font=tfont;
        btnOneLable.text=titleOne;
        [self.scrollerView  addSubview:btnOneLable];
        
        image=[UIImage imageNamed:@"location"];
        
        btnTwo=[UIButton buttonWithType:UIButtonTypeCustom];
        btnTwo.frame=CGRectMake(space*2+image.size.width, lineView.frame.origin.y+lineView.frame.size.height+3, image.size.width , image.size.height) ;
        [btnTwo setImage:image forState:UIControlStateNormal];
        [btnTwo addTarget:self action:@selector(location_btn_click:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollerView  addSubview:btnTwo];
        
        
        NSString *titleTwo=@"定位位置";
        btnTwoLable=[[UILabel alloc] initWithFrame:CGRectMake(btnTwo.frame.origin.x-(60-image.size.width)/2, btnTwo.frame.origin.y+image.size.height, 60, tfont.lineHeight)];
        btnTwoLable.backgroundColor=[UIColor clearColor];
        btnTwoLable.textAlignment=NSTextAlignmentCenter;
        btnTwoLable.textColor=[MainStyle mainTitleColor];
        btnTwoLable.font=tfont;
        btnTwoLable.text=titleTwo;
        [self.scrollerView  addSubview:btnTwoLable];
        
        selectView=[[UIView alloc] initWithFrame:CGRectMake(0, btnTwoLable.frame.size.height+btnTwoLable.frame.origin.y+5, self.frame.size.width, 150)];
        selectView.backgroundColor=[MainStyle mainGreenColor];
        [self.scrollerView addSubview:selectView];
        
        _mapView=[[BMKMapView alloc] initWithFrame:CGRectMake(0, selectView.frame.size.height+selectView.frame.origin.y, frame.size.width, frame.size.height-selectView.frame.origin.y-selectView.frame.size.height)];
        _mapView.mapType=BMKMapTypeStandard;
        _mapView.zoomLevel = 14;
        [self.scrollerView addSubview:_mapView];

    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    lineView.frame=CGRectMake(0,self.infoView.frame.origin.y+self.infoView.frame.size.height+10, self.frame.size.width, 1);
    CGRect rect=btnOne.frame;
    rect.origin.y=lineView.frame.origin.y+lineView.frame.size.height+3;
    btnOne.frame=rect;
    rect=btnTwo.frame;
    rect.origin.y=lineView.frame.origin.y+lineView.frame.size.height+3;
    btnTwo.frame=rect;
    
    UIImage *image=btnTwo.imageView.image;
    rect= btnOneLable.frame;
    rect.origin.y= btnOne.frame.origin.y+image.size.height;
    btnOneLable.frame=rect;
    
    rect=btnTwoLable.frame;
    rect.origin.y= btnTwo.frame.origin.y+image.size.height;
    btnTwoLable.frame=rect;
    
    rect=selectView.frame;
    rect.origin.y=btnTwoLable.frame.size.height+btnTwoLable.frame.origin.y+5;
    selectView.frame=rect;
    
    rect=_mapView.frame;
    rect.origin.y= selectView.frame.size.height+ selectView.frame.origin.y;
    _mapView.frame=rect;
}

-(void)call_btn_click:(id)sender
{

}

-(void)location_btn_click:(id)sender
{
    
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
