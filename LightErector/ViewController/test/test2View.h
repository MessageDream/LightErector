//
//  test2View.h
//  NavDemo
//
//  Created by Jayden Zhao on 8/28/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "BaseUIView.h"

@protocol ViewTapDelegate <NSObject>

-(void)imageTap:(UITapGestureRecognizer *)sender;

@end

@interface test2View : BaseUIView
@property(nonatomic,assign)id<ViewTapDelegate> delegate;
@end
