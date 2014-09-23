//
//  CustomHeadView.m
//
//
//  Created by xuwei on 26/7/13
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomHeadView.h"

@implementation CustomHeadView
@synthesize delegate = _delegate;
@synthesize open,backBtn=_backBtn,arrySelectOption=_arrySelectOption,labTitle=_labTitle,imageOpen=_imageOpen;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        open = NO;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn addTarget:self action:@selector(doSelected) forControlEvents:UIControlEventTouchUpInside];
        _labTitle = [[UILabel alloc]init];
        _labTitle.backgroundColor = [UIColor clearColor];
        _labTitle.userInteractionEnabled = NO;
        
        _labValue = [[UILabel alloc]init];
        _labValue.backgroundColor = [UIColor clearColor];
        _labValue.userInteractionEnabled = NO;
        
        _imageOpen = [[UIImageView alloc]init];
    }
    return self;
}

-(void)doSelected{
    if (_delegate && [_delegate respondsToSelector:@selector(selectedWith:)]){
     	[_delegate selectedWith:self];
    }
}


@end
