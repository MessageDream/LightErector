//
//  AttributedLabel.m
//  AttributedStringTest
//
//  Created by sun huayu on 13-2-19.
//  Copyright (c) 2013年 sun huayu. All rights reserved.
//

#import "AttributedLabel.h"
#import <QuartzCore/QuartzCore.h>

@interface AttributedLabel(){
    CATextLayer *textLayer;
}
@property (nonatomic,strong)NSMutableAttributedString *attString;
@end

@implementation AttributedLabel
@synthesize attString = _attString;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    if(textLayer == nil)
    {
        textLayer = [CATextLayer layer];
        [self.layer addSublayer:textLayer];
    }
    textLayer.string = _attString;
    textLayer.transform = CATransform3DMakeScale(0.5,0.5,1);
    textLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
- (void)setText:(NSString *)text{
    [super setText:text];
    if (text == nil) {
        self.attString = nil;
    }else{
        self.attString = [[NSMutableAttributedString alloc] initWithString:text];
        [self.attString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)CTFontCreateWithName((__bridge CFStringRef)self.font.fontName,self.font.pointSize*2,NULL) range:NSMakeRange(0, _attString.length)];
        [self setNeedsDisplay];
    }
}

// 设置某段字的颜色
- (void)setColor:(UIColor *)color fromIndex:(NSInteger)location length:(NSInteger)length{
    if (location < 0||location>self.text.length-1||length+location>self.text.length) {
        return;
    }
    [_attString addAttribute:(NSString *)kCTForegroundColorAttributeName
                        value:(id)color.CGColor
                        range:NSMakeRange(location, length)];
}

// 设置某段字的字体
//- (void)setFont:(UIFont *)font fromIndex:(NSInteger)location length:(NSInteger)length{
//    if (location < 0||location>self.text.length-1||length+location>self.text.length) {
//        return;
//    }
//    [_attString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)CTFontCreateWithName((__bridge CFStringRef)font.fontName,font.pointSize*2,NULL) range:NSMakeRange(0, _attString.length)];
//}


- (void)setLabelFont:(UIFont *)font fromIndex:(NSInteger)location length:(NSInteger)length{
    if (location < 0||location>self.text.length-1||length+location>self.text.length) {
        return;
    }
    [_attString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)CTFontCreateWithName((__bridge CFStringRef)font.fontName,font.pointSize*2,NULL) range:NSMakeRange(0, _attString.length)];
}

// 设置某段字的风格
- (void)setStyle:(CTUnderlineStyle)style fromIndex:(NSInteger)location length:(NSInteger)length{
    if (location < 0||location>self.text.length-1||length+location>self.text.length) {
        return;
    }
    [_attString addAttribute:(NSString *)kCTUnderlineStyleAttributeName
                        value:(id)[NSNumber numberWithInt:style]
                        range:NSMakeRange(location, length)];
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
