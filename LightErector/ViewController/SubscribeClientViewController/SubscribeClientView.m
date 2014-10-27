//
//  SubscribeClientView.m
//  LightErector
//
//  Created by Jayden Zhao on 10/11/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "SubscribeClientView.h"
#import "CustomUIRadioButton.h"
#import "CustomUIDatePicker.h"

@interface SubscribeClientView()<selectionButtonDelegate,CustomUIDatePickerDelegate>
{
    UIView *lineView;
    UIButton *btnOne;
    UIButton *btnTwo;
    UILabel *btnOneLable;
    UILabel *btnTwoLable;
    UIView *selectView;
    UILabel *timeLable;
    int selectindex;
}
@property(nonatomic,strong)CustomUIDatePicker *dataPicker;
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
        
        selectView=[[UIView alloc] initWithFrame:CGRectMake(0, btnTwoLable.frame.size.height+btnTwoLable.frame.origin.y+5, self.frame.size.width, 170)];
        selectView.backgroundColor=[MainStyle mainGreenColor];
        [self.scrollerView addSubview:selectView];
        
        CGFloat vspace=(selectView.frame.size.height-(3*24))/5;
        UIFont *font=[UIFont systemFontOfSize:14];
        UILabel *one=[[UILabel alloc] initWithFrame:CGRectMake((frame.size.width-(frame.size.width*0.5))/2, vspace, frame.size.width*0.6, 14)];
        one.backgroundColor=[UIColor clearColor];
        //one.textAlignment=NSTextAlignmentCenter;
        one.font=font;
        one.textColor=[MainStyle mainTitleColor];
        one.text=@"预约成功";
        [selectView addSubview:one];
        CustomUIRadioButton *radioOne=[[CustomUIRadioButton alloc] initWithSelected:NO];
        radioOne.tag=101;
        radioOne.selectionDelegate=self;
        radioOne.frame=CGRectMake(one.frame.origin.x-34, one.frame.origin.y-5, 24, 24);
        [selectView addSubview:radioOne];
        
        timeLable=[[UILabel alloc] initWithFrame:CGRectMake(one.frame.size.width+one.frame.origin.x-120, vspace, 140, 14)];
        timeLable.backgroundColor=[UIColor clearColor];
        //one.textAlignment=NSTextAlignmentCenter;
        timeLable.textColor=[MainStyle mainLightTwoColor];
        timeLable.font=font;
        [selectView addSubview:timeLable];
        
        UILabel *two=[[UILabel alloc] initWithFrame:CGRectMake((frame.size.width-(frame.size.width*0.5))/2, radioOne.frame.size.height+radioOne.frame.origin.y+vspace, frame.size.width*0.6, 14)];
        two.backgroundColor=[UIColor clearColor];
        //one.textAlignment=NSTextAlignmentCenter;
        two.font=font;
        two.textColor=[MainStyle mainTitleColor];
        two.text=@"已预约，但客户未确定时间";
        [selectView addSubview:two];
        CustomUIRadioButton *radiotwo=[[CustomUIRadioButton alloc] initWithSelected:NO];
        radiotwo.tag=102;
        radiotwo.selectionDelegate=self;
        radiotwo.frame=CGRectMake(two.frame.origin.x-34, two.frame.origin.y-5, 24, 24);
        [selectView addSubview:radiotwo];
        
        UILabel *three=[[UILabel alloc] initWithFrame:CGRectMake((frame.size.width-(frame.size.width*0.5))/2, radiotwo.frame.size.height+radiotwo.frame.origin.y+vspace, frame.size.width*0.6, 14)];
        three.backgroundColor=[UIColor clearColor];
        //one.textAlignment=NSTextAlignmentCenter;
        three.font=font;
        three.textColor=[MainStyle mainTitleColor];
        three.text=@"已预约，但客户电话未接通";
        [selectView addSubview:three];
        CustomUIRadioButton *radiothree=[[CustomUIRadioButton alloc] initWithSelected:NO];
        radiothree.tag=103;
        radiothree.selectionDelegate=self;
        radiothree.frame=CGRectMake(three.frame.origin.x-34, three.frame.origin.y-5, 24, 24);
        [selectView addSubview:radiothree];
        
        UIButton *btn=[UIButton  buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake((frame.size.width-200)/2, three.frame.size.height+three.frame.origin.y+vspace, 200, 34);
        [btn setTitle:@"正式接单" forState:UIControlStateNormal];
        [btn setBackgroundColor:[MainStyle mainLightColor]];
        [btn addTarget:self action:@selector(receptOrder_btn_click:) forControlEvents:UIControlEventTouchUpInside];
        [selectView addSubview:btn];
        
        _mapView=[[BMKMapView alloc] initWithFrame:CGRectMake(0, selectView.frame.size.height+selectView.frame.origin.y, frame.size.width, frame.size.height-selectView.frame.origin.y-selectView.frame.size.height)];
        _mapView.mapType=BMKMapTypeStandard;
        _mapView.zoomLevel = 14;
        [self.scrollerView addSubview:_mapView];
        self.dataPicker=[[CustomUIDatePicker alloc]initWithBottom];
        self.dataPicker.backgroundColor=[MainStyle mainBackColor];
        self.dataPicker.observer=self;
        self.dataPicker.hidden=YES;
        [self addSubview:self.dataPicker];
        
    }
    return self;
}

-(void)selectionButton:(CustomUIRadioButton *)selectionButton didChangedTo:(BOOL)isSelected
{
    if (selectionButton.tag==101) {
        self.dataPicker.hidden=NO;
        selectindex=1;
    }else if (selectionButton.tag==102){
        selectindex=2;
    }else{
        selectindex=3;
    }
    
    for (UIView *view in selectView.subviews) {
        if ([view isKindOfClass:[CustomUIRadioButton class]]&&![view isEqual:selectionButton]) {
            ((CustomUIRadioButton*)view).selected=NO;
        }
    }
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
    
    self.scrollerView.contentSize=CGSizeMake(self.frame.size.width, _mapView.frame.origin.y+_mapView.frame.size.height);
}

-(void)call_btn_click:(id)sender
{
    if (self.observer &&[self.observer respondsToSelector:@selector(call_btn_click:)]) {
        [self.observer call_btn_click:sender];
    }
}

-(void)location_btn_click:(id)sender
{
    if (self.observer &&[self.observer respondsToSelector:@selector(location_btn_click:)]) {
        [self.observer location_btn_click:sender];
        [self.scrollerView scrollRectToVisible:CGRectMake(0, _mapView.frame.origin.y, self.scrollerView.frame.size.width, self.scrollerView.frame.size.height) animated:YES];
    }
}

-(void)receptOrder_btn_click:(id)sender
{
    if (self.observer &&[self.observer respondsToSelector:@selector(receptOrder_btn_click:withDate:)]) {
        [self.observer receptOrder_btn_click:selectindex withDate:timeLable.text];
    }
    
}

-(IBAction)cancelButton_onClick:(id)sender
{
    self.dataPicker.hidden=YES;
}
-(IBAction)confirmButton_onClick:(id)sender forDate:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    timeLable.text=destDateString;
    self.dataPicker.hidden=YES;
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
