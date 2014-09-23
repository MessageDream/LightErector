//
//  ImagePlayerView.h
//  TOYOTA_ZhijiaX
//
//  Created by jayden on 14-7-31.
//  Copyright (c) 2014年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagedScrollView.h"

@interface ImagePlayerView : PagedScrollView
@property(nonatomic,strong)NSArray *imagesArray;
@property(nonatomic,strong)NSArray *urls;
@property(nonatomic,strong)UIImage *defaultImage;
-(id)initWithFrame:(CGRect)frame withUrls:(NSArray *)urls andDefaultImage:(UIImage *)defaultImage autoScroll:(BOOL)autoScroll;


@end

