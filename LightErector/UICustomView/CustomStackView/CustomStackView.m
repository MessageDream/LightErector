//
//  KTStackView.m
//  YoPingSDK
//
//  Created by dengjian 2012-11-15
//  Copyright (c) 2012年 ktplay. All rights reserved.
//

#import "CustomStackView.h"
#import "CustomStackItemView.h"

#define HIDDEN_BACK_VIEW        1

//==============================================================
// 由于栈的功能只在这个类中使用，所以先放到此类中，以后再提取出来
@interface YPStack : NSObject
-(void)push:(id)obj;
-(id)pop;
-(id)top;
-(void)popAll;
-(int)count;
@property (nonatomic, retain) NSMutableArray * mutableArray;
@end

@implementation YPStack

-(id)initWithCapacity:(NSUInteger)numItems{
    self = [super init];
    if (self) {
       _mutableArray = [[NSMutableArray alloc] initWithCapacity:numItems];
    }
    return self;
}

-(void)dealloc{
    //NSLog(@"destory YPStack  ");

    [_mutableArray removeAllObjects];
}

-(void)push:(id)obj{
    [_mutableArray addObject:obj];
}
-(id)pop{
    
//    id obj = [_mutableArray lastObject];
//	if(obj)
//	{
//		[obj retain];
//		[_mutableArray removeLastObject];
//	}
//	return obj;
    
    id obj = [self top];
    [self.mutableArray removeLastObject];
    return obj;
}

-(id)top{
    return [_mutableArray lastObject];
}

-(void)popAll{
    [_mutableArray removeAllObjects];
}

-(int)count{
    return [_mutableArray count];
}
@end

//=============================================================


//动画的方向
typedef enum {
	YPStackAnimDirectNone               = 0 << 0,
    YPStackAnimDirectLeft2Mid           = 1 << 0,
    YPStackAnimDirectRight2Mid          = 2 << 0,
    YPStackAnimDirectUp2Mid             = 3 << 0,
    YPStackAnimDirectDown2Mid           = 4 << 0,
    YPStackAnimDirectMid2Left           = 5 << 0,
    YPStackAnimDirectMid2Right          = 6 << 0,
    YPStackAnimDirectMid2Up             = 7 << 0,
    YPStackAnimDirectMid2Down           = 8 << 0,
}YPStackAnimDirect;


//动画完成之后，新View的对齐方式
typedef enum {
	YPStackAnimFinishNone               = 0 << 4,
    YPStackAnimFinishLeftIn             = 1 << 4,
    YPStackAnimFinishLeftOut            = 2 << 4,
    YPStackAnimFinishRightIn            = 3 << 4,
    YPStackAnimFinishRightOut           = 4 << 4,
    YPStackAnimFinishUpIn               = 5 << 4,
    YPStackAnimFinishUpOut              = 6 << 4,
    YPStackAnimFinishDownIn             = 7 << 4,
    YPStackAnimFinishDownOut            = 8 << 4,
    YPStackAnimFinishMidV               = 9 << 4,
    YPStackAnimFinishMidH               = 10 << 4,
}YPStackAnimEnd;




@interface CustomStackView ()
@property (nonatomic, retain) YPStack * viewStack;
@end

@implementation CustomStackView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _viewStack = [[YPStack alloc] initWithCapacity:10];
        self.clipsToBounds = YES;
    }
    return self;
}

-(void)dealloc{
}

typedef struct _YPAnimRect {
    CGRect beginRect;
    CGRect endRect;
}YPAnimRect;

-(CustomStackItemView *)topView{
    return [_viewStack top];
}

-(void)viewWillAppear{
    CustomStackItemView * topView = [self topView];
    if (topView) {
        [topView viewWillAppear];
    }
    
}
-(void)viewWillDisAppear{
    CustomStackItemView * topView = [self topView];
    if (topView) {
        [topView viewWillDisAppear];
    }
    
}
-(void)viewDidAppear{
    CustomStackItemView * topView = [self topView];
    if (topView) {
        [topView viewDidAppear];
    }

}


//-(void)initView:(CustomStackItemView *) newView{
//    [self addSubview:newView];
//    UIView * oldView = [_viewStack top];
//    [_viewStack push:newView];
//    
//    return;
//    /*
//    //不走动画
//    
//    YPAnimRect animNewView = [self paraStyle:(YPStackAnimDirectRight2Mid | YPStackAnimFinishLeftIn) currRect:newView.frame];
//    YPAnimRect animOldView = [self paraStyle:(YPStackAnimDirectMid2Left | YPStackAnimFinishLeftOut) currRect:oldView.frame];
//    
//    newView.frame = animNewView.beginRect;
//    oldView.frame = animOldView.beginRect;
//    [UIView animateWithDuration:0.5 animations:^{
//        newView.frame = animNewView.endRect;
//        oldView.frame = animOldView.endRect;
//    } completion:^(BOOL finished) {
//    }];
//    */
//}

-(void)pushView:(CustomStackItemView *) newView{
    [self pushView:newView animation:YES];

}

-(void)popView{
    [self popView:YES];

}

-(void)pushView:(CustomStackItemView *) newView animation:(BOOL)animation{

    [self addSubview:newView];
    newView.parentView = self;
    UIView * oldView = [_viewStack top];
    [_viewStack push:newView];
    
    YPAnimRect animNewView = [self paraStyle:(YPStackAnimDirectRight2Mid | YPStackAnimFinishLeftIn) currRect:newView.frame];
    YPAnimRect animOldView = [self paraStyle:(YPStackAnimDirectMid2Left | YPStackAnimFinishLeftOut) currRect:oldView.frame];
    
    newView.frame = animNewView.beginRect;
    oldView.frame = animOldView.beginRect;
#if HIDDEN_BACK_VIEW
    oldView.hidden = NO;
    newView.hidden = NO;
#endif
    [newView viewWillAppear];
    
    if (animation) {
        
        // 动画的时候，添加一个透明的View
        CGRect rect = self.frame;
        UIView * invisibleView = [[UIView alloc] initWithFrame:rect];
        invisibleView.backgroundColor = [UIColor clearColor];
        [self addSubview:invisibleView];
        
        [UIView animateWithDuration:0.5 animations:^{
            newView.frame = animNewView.endRect;
            oldView.frame = animOldView.endRect;
        } completion:^(BOOL finished) {
#if HIDDEN_BACK_VIEW
            oldView.hidden = YES;
#endif
            [invisibleView removeFromSuperview];
            [newView viewDidAppear];
            
        }];
    }else{
        newView.frame = animNewView.endRect;
        oldView.frame = animOldView.endRect;
#if HIDDEN_BACK_VIEW
        oldView.hidden = YES;
#endif
        [newView viewDidAppear];

    }
}
-(void)pushViewFromLeft2Right:(CustomStackItemView *) newView{
    
    [self pushViewFromLeft2Right:newView animation:YES];
}
-(void)pushViewFromLeft2Right:(CustomStackItemView *) newView animation:(BOOL)animation{

    [self addSubview:newView];
    newView.parentView = self;
    UIView * oldView = [_viewStack top];
    [_viewStack push:newView];
    
    YPAnimRect animNewView = [self paraStyle:(YPStackAnimDirectLeft2Mid |YPStackAnimFinishLeftIn) currRect:newView.frame];
    YPAnimRect animOldView = [self paraStyle:(YPStackAnimDirectMid2Right | YPStackAnimFinishRightOut) currRect:oldView.frame];
    
    newView.frame = animNewView.beginRect;
    oldView.frame = animOldView.beginRect;
#if HIDDEN_BACK_VIEW
    oldView.hidden = NO;
    newView.hidden = NO;
#endif
    [newView viewWillAppear];
    
    if (animation) {
        
        // 动画的时候，添加一个透明的View
        CGRect rect = self.frame;
        UIView * invisibleView = [[UIView alloc] initWithFrame:rect];
        invisibleView.backgroundColor = [UIColor clearColor];
        [self addSubview:invisibleView];
        
        [UIView animateWithDuration:0.5 animations:^{
            newView.frame = animNewView.endRect;
            oldView.frame = animOldView.endRect;
        } completion:^(BOOL finished) {
#if HIDDEN_BACK_VIEW
            oldView.hidden = YES;
#endif
            [invisibleView removeFromSuperview];
            [newView viewDidAppear];
            
        }];
    }else{
        newView.frame = animNewView.endRect;
        oldView.frame = animOldView.endRect;
#if HIDDEN_BACK_VIEW
        oldView.hidden = YES;
#endif
        [newView viewDidAppear];
        
    }

}
-(void)popView:(BOOL)animation{
    CustomStackItemView * oldView = [_viewStack  pop];
    CustomStackItemView * newView = [_viewStack  top];
    
    YPAnimRect animNewView = [self paraStyle:(YPStackAnimDirectLeft2Mid |YPStackAnimFinishLeftIn) currRect:newView.frame];
    YPAnimRect animOldView = [self paraStyle:(YPStackAnimDirectMid2Right | YPStackAnimFinishRightOut) currRect:oldView.frame];
    
    newView.frame = animNewView.beginRect;
    oldView.frame = animOldView.beginRect;
#if HIDDEN_BACK_VIEW
    oldView.hidden = NO;
    newView.hidden = NO;
#endif
    
    
    [newView viewWillAppear];
    if (animation) {
        [UIView animateWithDuration:0.5 animations:^{
            newView.frame = animNewView.endRect;
            oldView.frame = animOldView.endRect;
        } completion:^(BOOL finished) {
#if HIDDEN_BACK_VIEW
            oldView.hidden = YES;
#endif
            [newView viewDidAppear];
            oldView.parentView = nil;
            [oldView removeFromSuperview];
           // NSLog(@"pop === %i",oldView.retainCount);
        }];
    }else{
        newView.frame = animNewView.endRect;
        oldView.frame = animOldView.endRect;
#if HIDDEN_BACK_VIEW
        oldView.hidden = YES;
#endif
        [newView viewDidAppear];
        oldView.parentView = nil;
        [oldView removeFromSuperview];
    }

}

-(void)presentView:(CustomStackItemView *) newView result:(void (^)(id params))result
{
    [self presentView:newView animation:YES result:result];
}


-(void)presentView:(CustomStackItemView *) newView animation:(BOOL)animation result:(void (^)(id params))result{
    
    [self addSubview:newView];
    newView.parentView = self;
    UIView * oldView = [_viewStack top];
    [_viewStack push:newView];
    
    YPAnimRect animNewView = [self paraStyle:(YPStackAnimDirectDown2Mid | YPStackAnimFinishUpIn) currRect:newView.frame];
    YPAnimRect animOldView = [self paraStyle:(YPStackAnimDirectNone | YPStackAnimFinishNone) currRect:oldView.frame];
    
    newView.frame = animNewView.beginRect;
    oldView.frame = animOldView.beginRect;
#if HIDDEN_BACK_VIEW
    oldView.hidden = NO;
    newView.hidden = NO;
#endif
    
    [newView viewWillAppear];
    
    
    
    if (animation) {
        // 动画的时候，添加一个透明的View
        CGRect rect = self.frame;
        UIView * invisibleView = [[UIView alloc] initWithFrame:rect];
        invisibleView.backgroundColor = [UIColor clearColor];
        [self addSubview:invisibleView];
        
        [UIView animateWithDuration:0.5 animations:^{
            newView.frame = animNewView.endRect;
            oldView.frame = animOldView.endRect;
        } completion:^(BOOL finished) {
#if HIDDEN_BACK_VIEW
            oldView.hidden = YES;
#endif
            [invisibleView removeFromSuperview];
            [newView viewDidAppear];
            if (result) {
                    result(nil);
            }
        
        }];
    }else{
        newView.frame = animNewView.endRect;
        oldView.frame = animOldView.endRect;
#if HIDDEN_BACK_VIEW
        oldView.hidden = YES;
#endif
        [newView viewDidAppear];
    
    }
    

}

-(void)dismissView:(BOOL)animation{
    [self dismissView:animation completion:nil];
}

-(void)dismissView:(BOOL)animation completion:(void (^)(BOOL finished))completion{
    CustomStackItemView * oldView = [_viewStack pop];
    CustomStackItemView * newView = [_viewStack top];

#if HIDDEN_BACK_VIEW
    newView.hidden = NO;
    oldView.hidden = NO;
#endif
    
    YPAnimRect animNewView = [self paraStyle:(YPStackAnimDirectNone | YPStackAnimFinishNone) currRect:newView.frame];
    YPAnimRect animOldView = [self paraStyle:(YPStackAnimDirectMid2Down | YPStackAnimFinishDownOut) currRect:oldView.frame];
    
    newView.frame = animNewView.beginRect;
    oldView.frame = animOldView.beginRect;

    
    [newView viewWillAppear];
    
    if (animation) {
        [UIView animateWithDuration:0.5 animations:^{
            newView.frame = animNewView.endRect;
            oldView.frame = animOldView.endRect;
        } completion:^(BOOL finished) {
#if HIDDEN_BACK_VIEW
            oldView.hidden = YES;
#endif
            [newView viewDidAppear];
            oldView.parentView = nil;
            [oldView removeFromSuperview];
    //        [[oldView retain] autorelease];
            if (completion) {
                completion(finished);
            }
            
        }];
    }else{
        newView.frame = animNewView.endRect;
        oldView.frame = animOldView.endRect;
#if HIDDEN_BACK_VIEW
        oldView.hidden = YES;
#endif
        [newView viewDidAppear];
        oldView.parentView = nil;
        [oldView removeFromSuperview];
   //     [[oldView retain] autorelease];
        if (completion) {
            completion(YES);
        }
    }

}

-(void)popAllView{
    while ([_viewStack count] > 0) {
        CustomStackItemView * view = [_viewStack pop];
         view.parentView = nil;
        [view removeFromSuperview];
       
    }
}


// 解析动画类型，确定动画的起始Rect和结束Rect
-(YPAnimRect)paraStyle:(NSInteger)style currRect:(CGRect)currRect{
    YPAnimRect animRect;
    animRect.beginRect = currRect;
    animRect.endRect = currRect;
    
    NSInteger directType    = (style & 0x000F);
    NSInteger finishType    = (style & 0x00F0);
    
    switch (directType) {
        case YPStackAnimDirectLeft2Mid:
            animRect.beginRect.origin.x = -currRect.size.width;
            break;
        case YPStackAnimDirectRight2Mid:
            animRect.beginRect.origin.x = self.frame.size.width;
            break;
        case YPStackAnimDirectUp2Mid:
            animRect.beginRect.origin.y = -currRect.size.height;
            break;
        case YPStackAnimDirectDown2Mid:
            animRect.beginRect.origin.y = self.frame.size.height;
            break;
        case YPStackAnimDirectMid2Left:
        case YPStackAnimDirectMid2Right:
        case YPStackAnimDirectMid2Up:
        case YPStackAnimDirectMid2Down:
            break;
        default:
            break;
    }
    
    switch (finishType) {
        case YPStackAnimFinishLeftIn:
            animRect.endRect.origin.x = 0;
            break;
        case YPStackAnimFinishLeftOut:
            animRect.endRect.origin.x = -currRect.size.width;
            break;
        case YPStackAnimFinishRightIn:
            animRect.endRect.origin.x = self.frame.size.width - currRect.size.width;
            break;
        case YPStackAnimFinishRightOut:
            animRect.endRect.origin.x = self.frame.size.width;
            break;
        case YPStackAnimFinishUpIn:
            animRect.endRect.origin.y = 0;
            break;
        case YPStackAnimFinishUpOut:
            animRect.endRect.origin.y = -currRect.size.height;
            break;
        case YPStackAnimFinishDownIn:
            animRect.endRect.origin.y = self.frame.size.height - currRect.size.height;
            break;
        case YPStackAnimFinishDownOut:
            animRect.endRect.origin.y = self.frame.size.height;
            break;
        case YPStackAnimFinishMidV:
            animRect.endRect.origin.y = (self.frame.size.height - currRect.size.height) / 2;
            break;
        case YPStackAnimFinishMidH:
            animRect.endRect.origin.x = (self.frame.size.width - currRect.size.width) / 2;
            break;  
        default:
            break;
    }
    return animRect;
}


@end
