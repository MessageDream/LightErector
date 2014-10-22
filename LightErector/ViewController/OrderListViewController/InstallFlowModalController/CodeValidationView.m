//
//  CodeValidationView.m
//  LightErector
//
//  Created by Jayden on 14-10-5.
//  Copyright (c) 2014年 jayden. All rights reserved.
//

#import "CodeValidationView.h"
#import "CustomTextField.h"
#import "BaseCustomMessageBox.h"
#import "ImageUtils.h"

#define VIEWHEIGHT 260
#define VIEWWIDTH 260
@interface CodeValidationView()
{
    CustomTextField *codeText;
}
@end
@implementation CodeValidationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor=[MainStyle mainBackColor];
        UIView *centerContainer=[[UIView alloc] initWithFrame:CGRectMake((frame.size.width-VIEWWIDTH)/2, (frame.size.height-VIEWHEIGHT)/2+32, VIEWWIDTH,VIEWHEIGHT)];
        centerContainer.backgroundColor=[MainStyle mainLightTwoColor];
        centerContainer.layer.masksToBounds=YES;
        centerContainer.layer.cornerRadius=8;
        centerContainer.layer.shadowOffset=CGSizeMake(10, 10);
        [self addSubview:centerContainer];
        
        UIImage *image=[UIImage imageNamed:@"certificate"];
        
        UIButton *requestButton=[UIButton buttonWithType:UIButtonTypeCustom];
        requestButton.frame=CGRectMake(10, 33, centerContainer.frame.size.width-20, image.size.height+6);
        UIImage *bimage=[ImageUtils createImageWithColor:[MainStyle mainLightColor] andSize:requestButton.frame.size];
        [requestButton setBackgroundImage:bimage forState:UIControlStateNormal];
        [requestButton setTitle:@"完成安装 开始验证" forState:UIControlStateNormal];
        requestButton.titleLabel.textColor=[MainStyle mainBackColor];
        [requestButton addTarget:self action:@selector(requestCode_click:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(3, (requestButton.frame.size.height-image.size.height)/2, image.size.width, image.size.height)];
        imageView.image=image;
        [requestButton addSubview:imageView];
        [centerContainer addSubview:requestButton];
        
        codeText=[[CustomTextField alloc] initWithFrame:CGRectMake(10, requestButton.frame.origin.y+requestButton.frame.size.height+30, centerContainer.frame.size.width-20, 44)];
        codeText.contentPlaceholder =@"请输入验证码";
        codeText.backgroundColor=[UIColor clearColor];
        codeText.keyboardType=UIKeyboardTypeNumberPad;
        codeText.layer.borderWidth=1.0f;
        codeText.layer.borderColor=[[MainStyle mainLightColor] CGColor];
        [centerContainer addSubview:codeText];
        
       image=[UIImage imageNamed:@"fingerprint"];
        UIButton *uploadButton=[UIButton buttonWithType:UIButtonTypeCustom];
        uploadButton.frame=CGRectMake(10, codeText.frame.origin.y+codeText.frame.size.height+30, centerContainer.frame.size.width-20, image.size.height+6);
        bimage=[ImageUtils createImageWithColor:[MainStyle mainGreenColor] andSize:uploadButton.frame.size];
        [uploadButton setBackgroundImage:bimage forState:UIControlStateNormal];
        [uploadButton setTitle:@"完成安装 提交验证" forState:UIControlStateNormal];
        uploadButton.titleLabel.textColor=[MainStyle mainBackColor];
        [uploadButton addTarget:self action:@selector(uploadCode_click:) forControlEvents:UIControlEventTouchUpInside];
        
        imageView=[[UIImageView alloc] initWithFrame:CGRectMake(3, (uploadButton.frame.size.height-image.size.height)/2, image.size.width, image.size.height)];
        imageView.image=image;
        [uploadButton addSubview:imageView];
        [centerContainer addSubview:uploadButton];
//        UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0, _mapView.frame.origin.y+_mapView.frame.size.height, frame.size.width, 0.5)];
//        lineView.backgroundColor=[MainStyle mainTitleColor];
//        [self addSubview:lineView];

    }
    return self;
}

-(void)requestCode_click:(id)sender
{
    if (self.observer&&[self.observer respondsToSelector:@selector(requestCode_click:)]) {
        [self.observer requestCode_click:sender];
    }
}
-(void)uploadCode_click:(id)sender
{
    if (![codeText.text length]) {
        UIImage *image=[ImageUtils createImageWithColor:[[MainStyle mainLightColor] colorWithAlphaComponent:0.8f] andSize:CGSizeMake(200.0f, 50.0f)];
        BaseCustomMessageBox *baseCustomMessageBox = [[BaseCustomMessageBox alloc] initWithText:@"验证码为空" forBackgroundImage:image];
        baseCustomMessageBox.animation = YES;
        baseCustomMessageBox.autoCloseTimer = 2;
        [self addSubview:baseCustomMessageBox];
        return;
    }
    if (self.observer&&[self.observer respondsToSelector:@selector(uploadCode_click:)]) {
        [self.observer uploadCode_click:codeText.text];
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
-(void)dealloc
{
    codeText=nil;
    self.observer=nil;
}
@end
