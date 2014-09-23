//
//  UIHyperlinksButton.m
//  ZhiJiaAnX
//
//  Created by 95190 on 13-10-12.
//  Copyright (c) 2013年 95190. All rights reserved.
//

#import "UIHyperlinksButton.h"

@implementation UIHyperlinksButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+ (UIHyperlinksButton*) hyperlinksButton {
    UIHyperlinksButton* button = [[UIHyperlinksButton alloc] init];
    return button;
}
-(void)setColor:(UIColor *)color{
    lineColor = [color copy];
    [self setNeedsDisplay];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    isHighlight = YES;
    [self setColor:self.titleLabel.textColor];
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    isHighlight = NO;
    [self setColor:self.titleLabel.highlightedTextColor];
    
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    [self setColor:self.titleLabel.highlightedTextColor];
}
- (void) drawRect:(CGRect)rect {
    CGRect textRect = self.titleLabel.frame;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    if (isHighlight) {
        CGContextSetRGBFillColor(contextRef, 0.5, 0.5, 0.5, 1.0);
        CGContextFillRect(contextRef, textRect);
        CGContextStrokePath(contextRef);
    }
    CGFloat descender = self.titleLabel.font.descender;
    if([lineColor isKindOfClass:[UIColor class]]){
        CGContextSetStrokeColorWithColor(contextRef, lineColor.CGColor);
    }
    
    CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender+1);
    CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender+1);
    
    CGContextClosePath(contextRef);
    CGContextDrawPath(contextRef, kCGPathStroke);
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
