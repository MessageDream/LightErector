//
//  AboutView.h
//  LightErector
//
//  Created by Jayden Zhao on 10/21/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "TitleBarAndScrollerView.h"
@protocol AboutViewDelegate<NSObject>
-(void)call_click:(NSString *)number;
-(void)web_click:(NSString *)url;
@end
@interface AboutView : TitleBarAndScrollerView
@property(nonatomic,weak)id<AboutViewDelegate> observer;
@end
