//
//  UploadCodeValidationView.m
//  LightErector
//
//  Created by Jayden on 14-10-6.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "UploadImageValidationView.h"
#import "ImageUtils.h"
@interface UploadImageValidationView()
@end
@implementation UploadImageValidationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[MainStyle mainBackColor];
        self.segmentedControl=[[UISegmentedControl alloc] initWithItems:@[@"安装现场图",@"评分卡图"]];
        self.segmentedControl.frame=CGRectMake((frame.size.width-200)/2, 74, 200, 44);
        self.segmentedControl.selectedSegmentIndex=0;
        
        [self.segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.segmentedControl];
        
        self.scrollerView=[[UIScrollView alloc] init];
        self.scrollerView.frame=CGRectMake(0,  self.segmentedControl.frame.origin.y+self.segmentedControl.frame.size.height-30, frame.size.width, 200);
        self.scrollerView.backgroundColor = [UIColor clearColor];
        self.scrollerView.pagingEnabled = NO;
        self.scrollerView.showsHorizontalScrollIndicator = NO;
        self.scrollerView.scrollEnabled=NO;
        self.scrollerView.contentSize = CGSizeMake(frame.size.width*2, self.scrollerView.frame.size.height);
        
        self.scrollerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        self.photoViewOne=[[MessagePhotoView alloc] init];
        self.photoViewOne.frame = CGRectMake(0.0f,0.0f,CGRectGetWidth(self.scrollerView.frame),200);
        
        self.photoViewTwo=[[MessagePhotoView alloc] init];
        self.photoViewTwo.frame = CGRectMake(self.photoViewOne.frame.size.width,0.0f,CGRectGetWidth(self.scrollerView.frame),200);
        
        [self.scrollerView addSubview:self.photoViewOne];
        [self.scrollerView addSubview:self.photoViewTwo];
        [self addSubview:self.scrollerView];
        [self sendSubviewToBack:self.self.scrollerView];
        
        UIImage *image=[UIImage imageNamed:@"upload"];
        
        UIButton *uploadButton=[UIButton buttonWithType:UIButtonTypeCustom];
        uploadButton.frame=CGRectMake(30,  self.scrollerView.frame.origin.y+ self.scrollerView.frame.size.height+10, self.frame.size.width-60, image.size.height+6);
        UIImage *bimage=[ImageUtils createImageWithColor:[MainStyle mainLightColor] andSize:uploadButton.frame.size];
        [uploadButton setBackgroundImage:bimage forState:UIControlStateNormal];
        [uploadButton setTitle:@"上传图片" forState:UIControlStateNormal];
        uploadButton.titleLabel.textColor=[MainStyle mainBackColor];
        [uploadButton addTarget:self action:@selector(uploadImage_click:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(3, (uploadButton.frame.size.height-image.size.height)/2, image.size.width, image.size.height)];
        imageView.image=image;
        [uploadButton addSubview:imageView];
        [self addSubview:uploadButton];
        
        image=[UIImage imageNamed:@"finish"];
        
        UIButton *finishButton=[UIButton buttonWithType:UIButtonTypeCustom];
        finishButton.frame=CGRectMake(30,  uploadButton.frame.origin.y+uploadButton.frame.size.height+10,  self.frame.size.width-60, image.size.height+6);
        finishButton.backgroundColor=[MainStyle mainGreenColor];
        bimage=[ImageUtils createImageWithColor:[MainStyle mainGreenColor] andSize:finishButton.frame.size];
        [finishButton setBackgroundImage:bimage forState:UIControlStateNormal];
        [finishButton setTitle:@"完成验证" forState:UIControlStateNormal];
        finishButton.titleLabel.textColor=[MainStyle mainBackColor];
        [finishButton addTarget:self action:@selector(finish_click:) forControlEvents:UIControlEventTouchUpInside];
        
        imageView=[[UIImageView alloc] initWithFrame:CGRectMake(3, (finishButton.frame.size.height-image.size.height)/2, image.size.width, image.size.height)];
        imageView.image=image;
        [finishButton addSubview:imageView];
        [self addSubview:finishButton];
    }
    return self;
}

-(void)segmentAction:(UISegmentedControl *)seg
{
    NSInteger index=seg.selectedSegmentIndex;
    switch (index) {
        case 0:
           [self.scrollerView scrollRectToVisible:CGRectMake(0, 0, self.scrollerView.frame.size.width, self.scrollerView.frame.size.height) animated:YES];
            break;
            
        default:
             [self.scrollerView scrollRectToVisible:CGRectMake(self.scrollerView.frame.size.width, 0, self.scrollerView.frame.size.width, self.scrollerView.frame.size.height) animated:YES];
            break;
    }
}
-(void)uploadImage_click:(id)sender
{
    if (self.observer&&[self.observer respondsToSelector:@selector(uploadImage_click:)]) {
        [self.observer uploadImage_click:@{@"1":self.photoViewOne.photoMenuItems,@"2":self.photoViewTwo.photoMenuItems}];
    }
}
-(void)finish_click:(id)sender
{
    if (self.observer&&[self.observer respondsToSelector:@selector(finish_click:)]) {
        [self.observer finish_click:sender];
    }
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
