//
//  CustomTextFieldCell.h
//  ZhiJiaAnX
//
//  Created by wei.xu.95190 on 13-7-24.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"

@interface CustomTextFieldCell : UITableViewCell
{
    CustomTextField *_txt_content;
}

@property (strong, nonatomic) CustomTextField *txt_content;
@end
