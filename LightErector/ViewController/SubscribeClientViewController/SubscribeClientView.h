//
//  SubscribeClientView.h
//  LightErector
//
//  Created by Jayden Zhao on 10/11/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "TitleBarAndScrollerView.h"
#import "OrderInfoView.h"
#import "BMapKit.h"
@protocol SubscribeClientViewDelegate<NSObject>
-(void)call_btn_click:(id)sender;

-(void)location_btn_click:(id)sender;

-(void)receptOrder_btn_click:(int)status withDate:(NSString *)date;
@end
@interface SubscribeClientView : TitleBarAndScrollerView
@property(nonatomic,strong)OrderInfoView *infoView;
@property(nonatomic,strong)UILabel *nameLable;
@property(nonatomic,strong)UILabel *phoneLable;
@property(nonatomic,strong)UILabel *subscribeTimeLable;
@property(nonatomic,strong)UILabel *addressLable;
@property(nonatomic,strong)UILabel *detailLable;
@property(nonatomic,strong)UILabel *remarkLable;

@property(nonatomic,strong)UILabel *sDetailLable;
@property(nonatomic,strong)UILabel *sRemarkLable;

@property(nonatomic,strong)BMKMapView *mapView;
@property(nonatomic,assign)id<SubscribeClientViewDelegate> observer;
@end
