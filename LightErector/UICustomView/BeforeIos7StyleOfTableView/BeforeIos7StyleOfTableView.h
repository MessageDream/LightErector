//
//  BeforeIos7StyleOfTableView.h
//  ZhiJiaAnX
//
//  Created by 95190 on 13-12-13.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeforeIos7StyleOfTableView : UITableView
{
@protected
    UIImage *_frameImage;
    UIImage *_separatorLineImage;
}
@property(nonatomic)BOOL useBeforeIos7Style;
@property(nonatomic,strong)UIImage *frameImage;
@property(nonatomic,strong)UIImage *separatorLineImage;
@end
