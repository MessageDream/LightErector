//
//  UploadCodeValidationView.h
//  LightErector
//
//  Created by Jayden on 14-10-6.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "BaseUIView.h"
#import "MessagePhotoView.h"

@protocol UploadImageValidationViewDelegate <NSObject>

-(void)uploadCode_click:(NSDictionary *)imagesDic;
-(void)finish_click:(id)sender;
@end


@interface UploadImageValidationView : BaseUIView
@property(nonatomic,strong)UISegmentedControl *segmentedControl;
@property(nonatomic,strong)MessagePhotoView *photoViewOne;
@property(nonatomic,strong)MessagePhotoView *photoViewTwo;
@property(nonatomic,strong)UIScrollView *scrollerView;
@property(nonatomic,weak)id<UploadImageValidationViewDelegate> observer;
@end
