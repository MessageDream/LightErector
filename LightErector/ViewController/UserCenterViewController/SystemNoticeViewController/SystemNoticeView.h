//
//  SystemNoticeView.h
//  LightErector
//
//  Created by Jayden Zhao on 10/21/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "TitleBarView.h"

@interface SystemNoticeView : TitleBarView
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)UIWebView *webView;
-(void)startLoading;
@end
