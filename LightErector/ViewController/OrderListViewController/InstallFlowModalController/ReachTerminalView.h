//
//  ReachTerminalView.h
//  LightErector
//
//  Created by Jayden on 14-10-4.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "BaseUIView.h"
#import "BMapKit.h"

@protocol ReachTerminalViewDelegate <NSObject>
-(void)reach_terminal_click:(id)sender;
@end

@interface ReachTerminalView : BaseUIView
@property(nonatomic,strong)BMKMapView *mapView;
@property(nonatomic,weak)id<ReachTerminalViewDelegate> observer;
@end
