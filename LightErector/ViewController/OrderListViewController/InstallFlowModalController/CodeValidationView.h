//
//  CodeValidationView.h
//  LightErector
//
//  Created by Jayden on 14-10-5.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "BaseScrollerView.h"
@protocol CodeValidationViewDelegate <NSObject>
-(void)requestCode_click:(id)sender;
-(void)uploadCode_click:(NSString *)code;
@end

@interface CodeValidationView : BaseScrollerView
@property(nonatomic,weak)id<CodeValidationViewDelegate> observer;
@end
