//
//  PagedScrollView.h
//  TOYOTA_ZhijiaX
//
//  Created by jayden on 14-8-1.
//  Copyright (c) 2014年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PageControlPosition) {
    PageControlPosition_TopLeft,
    PageControlPosition_TopCenter,
    PageControlPosition_TopRight,
    PageControlPosition_BottomLeft,
    PageControlPosition_BottomCenter,
    PageControlPosition_BottomRight
};

@interface PagedScrollView : UIView
{
    @protected
    NSMutableArray *totalViewsArray;
}
@property (nonatomic, assign) BOOL autoScroll;
@property (nonatomic, assign) NSUInteger scrollInterval;
@property (nonatomic, assign) PageControlPosition pageControlPosition;
@property (nonatomic, assign) BOOL hidePageControl;

/**
 *  初始化
 *
 *  @param frame             frame
 *  @param animationDuration 自动滚动的间隔时长。如果<=0，不自动滚动。
 *
 *  @return instance
 */
- (id)initWithFrame:(CGRect)frame autoScroll:(BOOL)autoScroll;

/**
 数据源：获取总的page个数
 **/
@property (nonatomic , copy) NSInteger (^totalPagesCount)(void);
/**
 数据源：获取第pageIndex个位置的contentView
 **/
@property (nonatomic , copy) UIView *(^fetchContentViewAtIndex)(NSInteger pageIndex);
/**
 当点击的时候，执行的block
 **/
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);

@end

//@protocol PagedScrollViewDelegate <NSObject>
//
//@required
//- (void)imagePlayerView:(PagedScrollView *)pagedScrollView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index;
//
//@optional
//- (void)imagePlayerView:(PagedScrollView *)pagedScrollView didTapAtIndex:(NSInteger)index imageURL:(NSURL *)imageURL DEPRECATED_ATTRIBUTE;
//
//- (void)imagePlayerView:(PagedScrollView *)pagedScrollView didTapAtIndex:(NSInteger)index;
//@end

