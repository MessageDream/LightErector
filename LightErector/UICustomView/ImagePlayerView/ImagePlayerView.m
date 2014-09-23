//
//  ImagePlayerView.m
//  TOYOTA_ZhijiaX
//
//  Created by jayden on 14-7-31.
//  Copyright (c) 2014年 95190. All rights reserved.
//

#import "ImagePlayerView.h"
#import "NSTimer+Addition.h"


@implementation ImagePlayerView
-(id)initWithFrame:(CGRect)frame withUrls:(NSArray *)urls andDefaultImage:(UIImage *)defaultImage autoScroll:(BOOL)autoScroll{
    if (self=[super initWithFrame:frame autoScroll:autoScroll]) {
        _defaultImage=defaultImage;
        self.urls=urls;
    }
    
    return self;
}

-(void)setImagesArray:(NSArray *)imagesArray
{
    totalViewsArray = [@[] mutableCopy];
    for ( int i=0; i<[imagesArray count]; i++) {
        UIImageView *img=[[UIImageView alloc]initWithFrame:self.frame];
        img.image=[imagesArray objectAtIndex:i];
        [totalViewsArray addObject:img];
       
    }
    
    self.totalPagesCount = ^NSInteger(void){
        return [imagesArray count];
    };
}

-(void)setUrls:(NSArray *)urls
{
    totalViewsArray = [@[] mutableCopy];
    for ( int i=0; i<[urls count]; i++) {
        NSURL *url=[urls objectAtIndex:i];
        UIImageView *img=[[UIImageView alloc]initWithFrame:self.frame];
        [totalViewsArray addObject:img];
        UIImageFromURL(url, ^( UIImage * image )
                       {
                           img.image=image;
                       }, ^(void){
                           if(_defaultImage)
                               img.image=_defaultImage;
                       });
    }
    
    
    self.totalPagesCount = ^NSInteger(void){
        return urls.count;
    };
}

#pragma mark - 下载图片
void UIImageFromURL( NSURL * URL, void (^imageBlock)(UIImage * image), void (^errorBlock)(void) )
{
    dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), ^(void)
                   {
                       NSData * data = [[NSData alloc] initWithContentsOfURL:URL] ;
                       UIImage * image = [[UIImage alloc] initWithData:data];
                       dispatch_async( dispatch_get_main_queue(), ^(void){
                           if( image != nil )
                           {
                               imageBlock( image );
                           } else {
                               errorBlock();
                           }
                       });
                   });
}
@end


