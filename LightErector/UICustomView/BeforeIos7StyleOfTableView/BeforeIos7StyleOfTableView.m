//
//  BeforeIos7StyleOfTableView.m
//  ZhiJiaAnX
//
//  Created by 95190 on 13-12-13.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import "BeforeIos7StyleOfTableView.h"

@interface BeforeIos7StyleOfTableView()
{
    NSMutableArray *sectionsBackgrundImageViews;
}
-(void)removeCustomAllBackgroundImageView;
@end

@implementation BeforeIos7StyleOfTableView
@synthesize frameImage = _frameImage;
@synthesize separatorLineImage =_separatorLineImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    
    sectionsBackgrundImageViews = [[NSMutableArray alloc] init];
    _useBeforeIos7Style = YES;
    return self;
}
-(void)removeCustomAllBackgroundImageView
{
    for(int n=0;n<sectionsBackgrundImageViews.count;n++)
    {
        UIImageView *imageView = [sectionsBackgrundImageViews objectAtIndex:n];
        [imageView removeFromSuperview];
    }
    [sectionsBackgrundImageViews removeAllObjects];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue]<7)
    {
        if(self.separatorStyle == UITableViewCellSeparatorStyleNone)
            self.separatorColor = [UIColor clearColor];
    }
    if(!self.useBeforeIos7Style)
        return;
    
    NSArray *cells = self.visibleCells;
    for(int n=0;n<cells.count;n++)
    {
        ((UITableViewCell*)[cells objectAtIndex:n]).backgroundColor = [UIColor clearColor];
    }
    
    [self removeCustomAllBackgroundImageView];
    
    long sectionsNumber = [self numberOfSections];
    
    for(int sectionIndex=0;sectionIndex<sectionsNumber;sectionIndex++)
    {
        CGRect sectionRect = [self rectForSection:sectionIndex];
        sectionRect.size.height-=[self rectForFooterInSection:sectionIndex].size.height;
        sectionRect.origin.y+=[self rectForHeaderInSection:sectionIndex].size.height;
        sectionRect.size.height-=[self rectForHeaderInSection:sectionIndex].size.height;
        
        UIImageView *sectionsBackgrundImageView = [[UIImageView alloc] initWithFrame:sectionRect];
        sectionsBackgrundImageView.userInteractionEnabled = YES;
        sectionsBackgrundImageView.contentMode = UIViewContentModeScaleToFill;
        sectionsBackgrundImageView.image = [_frameImage resizableImageWithCapInsets:UIEdgeInsetsMake(6,15,6,15)];
        
        [self insertSubview:sectionsBackgrundImageView atIndex:0];
        
        if(sectionRect.size.height<10)
        {
            //            CGRect sectionsBackgrundImageViewFrame = sectionsBackgrundImageView.frame;
            //            sectionsBackgrundImageViewFrame.size.width = self.bounds.size.width;
            //            sectionsBackgrundImageViewFrame.size.height = self.bounds.size.height;
            //            sectionsBackgrundImageView.frame = sectionsBackgrundImageViewFrame;
            [sectionsBackgrundImageView removeFromSuperview];
        }
        
        [sectionsBackgrundImageViews addObject:sectionsBackgrundImageView];
        
        
        if(self.separatorStyle!=UITableViewCellSeparatorStyleNone)
        {
            self.separatorColor = [UIColor clearColor];
            double cellY = 0;
            
            if([self numberOfRowsInSection:sectionIndex]>0)
            {
                for(int rowIndex=0;rowIndex<[self numberOfRowsInSection:sectionIndex]-1;rowIndex++)
                {
                    CGRect rowRect = [self rectForRowAtIndexPath:[NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex]];
                    cellY+=rowRect.size.height;
                    
                    if(_separatorLineImage!=nil)
                    {
                        UIImageView *lineImageView = [[UIImageView alloc] initWithImage:_separatorLineImage];
                        CGRect lineImageViewFrame = lineImageView.frame;
                        lineImageViewFrame.origin.x = 0;
                        lineImageViewFrame.origin.y = cellY;
                        lineImageViewFrame.size.width = sectionRect.size.width;
                        lineImageView.frame = lineImageViewFrame;
                        
                        [sectionsBackgrundImageView addSubview:lineImageView];
                    }
                }
            }
            //            else
            //            {
            //                for(int rowIndex=0;rowIndex<self.bounds.size.height/self.rowHeight-2;rowIndex++)
            //                {
            //                    cellY+=self.rowHeight;
            //
            //                    if(separatorLineImage!=nil)
            //                    {
            //                        UIImageView *lineImageView = [[UIImageView alloc] initWithImage:separatorLineImage];
            //                        CGRect lineImageViewFrame = lineImageView.frame;
            //                        lineImageViewFrame.origin.x = 0;
            //                        lineImageViewFrame.origin.y = cellY;
            //                        lineImageView.frame = lineImageViewFrame;
            //
            //                        [sectionsBackgrundImageView addSubview:lineImageView];
            //                    }
            //                }
            //            }
            
        }
    }
    self.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, -3);
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
