//
//  CustomStackItemView.h
//  LightErector
//
//  Created by Jayden Zhao on 10/23/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomStackView;

@interface CustomStackItemView : UIView
@property(nonatomic, assign) CustomStackView * parentView;

-(void)viewWillAppear;
-(void)viewWillDisAppear;
-(void)viewDidAppear;
@end
