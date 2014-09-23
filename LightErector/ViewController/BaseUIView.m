//
//  BaseUIView.m
//  LightErector
//
//  Created by Jayden Zhao on 8/27/14.
//  Copyright (c) 2014 LightErector. All rights reserved.
//

#import "BaseUIView.h"

@interface BaseUIView ()
{
    BOOL keyboardShown;
    double activeKeyboardControlOfScrollViewToBottomHeight;
    CGSize saveKeyboardSize;
    CGSize savekeepOutViewSize;
    UIView *keepOutView;
}
- (void)keyboardWillShown:(NSNotification*)aNotification;
- (void)keyboardWasHidden:(NSNotification*)aNotification;
@end

@implementation BaseUIView
//@synthesize noCanCoverControlOfScrollViewToBottomHeight;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShown:)
                                                     name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWasHidden:)
                                                     name:UIKeyboardDidHideNotification object:nil];
        keyboardShown = NO;
        activeKeyboardControlOfScrollViewToBottomHeight = 0;
    }
    return self;
}
-(void)keepOutViewWillShown:(UIView*)view
{
    keepOutView = view;
    
    if(self.activeKeyboardControl==nil || self.activeKeyboardControlOfScrollView == nil)
        return;
    
    CGSize keepOutViewSize = keepOutView.bounds.size;
    
    if(keyboardShown)
    {
        if(!CGSizeEqualToSize(keepOutViewSize, savekeepOutViewSize))
        {
            CGRect viewFrame = [self.activeKeyboardControlOfScrollView frame];
            
            viewFrame.size.height = viewFrame.size.height+savekeepOutViewSize.height-activeKeyboardControlOfScrollViewToBottomHeight;
            self.activeKeyboardControlOfScrollView.frame = viewFrame;
        }
    }
    
    activeKeyboardControlOfScrollViewToBottomHeight = [UIScreen mainScreen].applicationFrame.size.height-self.activeKeyboardControlOfScrollView.bounds.size.height-self.activeKeyboardControlOfScrollView.frame.origin.y;
    
    CGRect viewFrame = [self.activeKeyboardControlOfScrollView frame];
    viewFrame.size.height =  viewFrame.size.height-keepOutViewSize.height+activeKeyboardControlOfScrollViewToBottomHeight;
    self.activeKeyboardControlOfScrollView.frame = viewFrame;
    
    // Scroll the active text field into view.
    CGRect activeKeyboardControlRect = [self.activeKeyboardControl frame];
    [self.activeKeyboardControlOfScrollView scrollRectToVisible:activeKeyboardControlRect animated:YES];
    
    savekeepOutViewSize = keepOutViewSize;
}
-(void)keepOutViewWasHidden
{
    if(self.activeKeyboardControlOfScrollView == nil || self.activeKeyboardControl == nil || keepOutView == nil)
        return;
    
    CGSize keepOutViewSize = keepOutView.bounds.size;
    CGRect viewFrame = [self.activeKeyboardControlOfScrollView frame];
    
    viewFrame.size.height = viewFrame.size.height+keepOutViewSize.height-activeKeyboardControlOfScrollViewToBottomHeight;
    self.activeKeyboardControlOfScrollView.frame = viewFrame;
    
    savekeepOutViewSize = CGSizeZero;
    keepOutView = nil;
}
- (void)keyboardWillShown:(NSNotification*)aNotification
{
    if(self.activeKeyboardControl==nil || self.activeKeyboardControlOfScrollView == nil)
        return;
    NSDictionary* info = [aNotification userInfo];
    
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    
    if(keyboardShown)
    {
        if(!CGSizeEqualToSize(keyboardSize, saveKeyboardSize))
        {
            CGRect viewFrame = [self.activeKeyboardControlOfScrollView frame];
            
            viewFrame.size.height = viewFrame.size.height+saveKeyboardSize.height-activeKeyboardControlOfScrollViewToBottomHeight;
            self.activeKeyboardControlOfScrollView.frame = viewFrame;
        }
    }
    
    activeKeyboardControlOfScrollViewToBottomHeight = [UIScreen mainScreen].applicationFrame.size.height-self.activeKeyboardControlOfScrollView.bounds.size.height-self.activeKeyboardControlOfScrollView.frame.origin.y;
    
    CGRect viewFrame = [self.activeKeyboardControlOfScrollView frame];
    viewFrame.size.height =  viewFrame.size.height-keyboardSize.height+activeKeyboardControlOfScrollViewToBottomHeight;
    self.activeKeyboardControlOfScrollView.frame = viewFrame;
    
    // Scroll the active text field into view.
    CGRect activeKeyboardControlRect = [self.activeKeyboardControl frame];
    [self.activeKeyboardControlOfScrollView scrollRectToVisible:activeKeyboardControlRect animated:YES];
    
    saveKeyboardSize = keyboardSize;
    keyboardShown = YES;
}
- (void)keyboardWasHidden:(NSNotification*)aNotification
{
    if(self.activeKeyboardControlOfScrollView == nil || self.activeKeyboardControl == nil)
        return;
    NSDictionary* info = [aNotification userInfo];
    
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    CGRect viewFrame = [self.activeKeyboardControlOfScrollView frame];
    
    viewFrame.size.height = viewFrame.size.height+keyboardSize.height-activeKeyboardControlOfScrollViewToBottomHeight;
    self.activeKeyboardControlOfScrollView.frame = viewFrame;
    
    keyboardShown = NO;
    saveKeyboardSize = CGSizeZero;
    //self.activeKeyboardControl = nil;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:NO];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    self.activeKeyboardControl = nil;
    self.activeKeyboardControlOfScrollView = nil;
}
@end
