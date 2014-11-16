//
//  TodayTaskTableViewDetailCellTableViewCell.m
//  LightErector
//
//  Created by Jayden Zhao on 9/28/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "OrderTitleTableViewCell.h"
#import "MainStyle.h"
typedef NS_ENUM(NSInteger, ButtonStatus) {
    ButtonStatus_Normal,
    ButtonStatus_Show,
    ButtonStatus_Hide,
};

@implementation UITableViewCellModel
-(id)initWithCellType:(NSString *)cellType isAttached:(BOOL) isAttached andContentModel:(id)model
{
    if (self=[super init]) {
        _cellType=cellType;
        _isAttached=isAttached;
        _contentModel=model;
    }
    return self;
}
@end
@interface OrderTitleTableViewCell()
{
    UIView *buttonsView;
    NSMutableArray *buttons;
    int buttonStatus;
    CGFloat buttopnViewWidth;
    void (^callBack)(NSInteger index);
}
@end
@implementation OrderTitleTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        self.backgroundColor=[UIColor clearColor];
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        self.imageView.image=[UIImage imageNamed:@"light"];
        self.textLabel.textColor=[MainStyle mainTitleColor];
        self.textLabel.font=[UIFont systemFontOfSize:16];
        
        UIFont *font=[UIFont italicSystemFontOfSize:14];
        self.nameLable=[[UILabel alloc] init];
        self.nameLable.backgroundColor=[UIColor clearColor];
        self.nameLable.textColor=[MainStyle mainDarkColor];
        self.nameLable.font=font;
        [self.contentView addSubview:self.nameLable];
        self.mobileLable=[[UILabel alloc] init];
        self.mobileLable.backgroundColor=[UIColor clearColor];
        self.mobileLable.textColor=[MainStyle mainDarkColor];
        self.mobileLable.font=font;
        [self.contentView addSubview:self.mobileLable];
        self.priceLable=[[UILabel alloc] init];
        self.priceLable.backgroundColor=[UIColor clearColor];
        self.priceLable.textColor=[MainStyle mainDarkColor];
        self.priceLable.textAlignment=NSTextAlignmentRight;
        self.priceLable.font=font;
        [self.contentView addSubview:self.priceLable];
        
        self.dateLable=[[UILabel alloc] init];
        self.dateLable.backgroundColor=[UIColor clearColor];
        self.dateLable.textColor=[MainStyle mainDarkColor];
        self.dateLable.textAlignment=NSTextAlignmentRight;
        self.dateLable.font=font;
        [self.contentView addSubview:self.dateLable];
        
//                CGFloat lspace=71.0f;
//                UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(lspace, self.frame.size.height-0.5, self.frame.size.width-lspace, 0.5)];
//                lineView.backgroundColor=[UIColor lightGrayColor];
//                [self addSubview:lineView];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)createOptionButtonsWithTitles:(NSArray *)titles andIcons:(NSArray *)icons andBackgroundColors:(NSArray *)backColors andAction:(void (^)(NSInteger buttonIndex))action;
{
    if (!buttons) {
        buttons=[[NSMutableArray alloc] initWithCapacity:3];
        
    }
    [buttons removeAllObjects];
    for (int i=0; i<titles.count; ++i) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (backColors!=nil&&backColors.count>i) {
            button.backgroundColor = backColors[i];
        }
        if (icons!=nil&&icons.count>i) {
            [button setImage:icons[i] forState:UIControlStateNormal];
        }
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [button sizeToFit];
        CGRect frame = button.frame;
        frame.size.height=self.frame.size.height;
        frame.size.width += 10; //padding
        frame.size.width = MAX(50, frame.size.width); //initial min size
        button.frame = frame;
        [buttons addObject:button];
    }
    
    callBack=action;
}

-(void)showButtons
{
//    if (buttonsView!=nil) {
//        [buttonsView removeFromSuperview];
//    }
    if (buttonsView==nil) {
        buttonsView=[self createButtonContainer];
    }
    
    buttonsView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    buttonsView.frame = CGRectMake(320, 0, buttonsView.bounds.size.width, self.bounds.size.height);
    buttopnViewWidth=buttonsView.frame.size.width;
    buttonStatus=ButtonStatus_Show;
    [self.contentView addSubview:buttonsView];
}

-(void)willRemoveSubview:(UIView *)subview
{
    buttonStatus=ButtonStatus_Normal;
}


-(void)willTransitionToState:(UITableViewCellStateMask)state
{
    
}

-(UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView * targets[] = {buttonsView};
    for (int i = 0; i< 1; ++i) {
        UIView * target = targets[i];
        if (!target) continue;
        
        CGPoint p = [self convertPoint:point toView:target];
        if (CGRectContainsPoint(target.bounds, p)) {
            return [target hitTest:p withEvent:event];
        }
    }
    return [super hitTest:point withEvent:event];
}

-(void)layoutSubviews
{
  
    if (self.contentView.frame.origin.x==0) {
        [super layoutSubviews];
        CGRect newFrame = self.contentView.frame;
        newFrame.origin.x =newFrame.origin.x-buttopnViewWidth;
        self.contentView.frame = newFrame;
        
        //有时候会导致x偏移，故加入下代码
        CGRect newrect= buttonsView.frame;
        newrect.origin.x=self.frame.size.width;
        buttonsView.frame=newrect;
    }else if(buttonStatus==ButtonStatus_Hide&&buttopnViewWidth>0.0f){
        [super layoutSubviews];
        if (self.contentView.frame.origin.x==-buttopnViewWidth) {
            CGRect newFrame = self.contentView.frame;
            newFrame.origin.x =newFrame.origin.x +buttopnViewWidth;
            self.contentView.frame = newFrame;
        }
        
        buttopnViewWidth=0.0f;
    }else{
        [super layoutSubviews];
        
    }
    CGRect rect=self.textLabel.frame;
    rect.origin.y= self.textLabel.font.lineHeight/6;
    rect.size.width= rect.size.width*0.5;
    rect.size.height=self.textLabel.font.lineHeight;
    
    self.textLabel.frame=rect;
    rect.size.width= rect.size.width/0.5*0.7;
    self.nameLable.frame=CGRectMake(rect.origin.x, rect.origin.y+rect.size.height*1.2, rect.size.width/2.8, 14);
    self.mobileLable.frame=CGRectMake(self.nameLable.frame.origin.x+self.nameLable.frame.size.width, self.nameLable.frame.origin.y, rect.size.width/1.5, 14);
    self.dateLable.frame=CGRectMake(self.textLabel.frame.origin.x+self.textLabel.frame.size.width,  self.textLabel.frame.origin.y+2, self.textLabel.frame.size.width, 14);
    
    self.priceLable.frame=CGRectMake(self.dateLable.frame.origin.x+self.dateLable.frame.size.width-rect.size.width/3,  self.mobileLable.frame.origin.y, rect.size.width/3, 14);
    buttonStatus=ButtonStatus_Normal;
}
-(void)hideButtons
{
    buttonStatus=ButtonStatus_Hide;
    [buttonsView removeFromSuperview];
}

-(UIView *) createButtonContainer
{
    CGSize maxSize = CGSizeZero;
    for (UIView * button in buttons) {
        maxSize.width = MAX(maxSize.width, button.bounds.size.width);
        maxSize.height = MAX(maxSize.height, button.bounds.size.height);
    }
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, maxSize.width * buttons.count, maxSize.height)];
    container.clipsToBounds = YES;
    container.backgroundColor = [UIColor clearColor];
    for (UIView * button in buttons) {
        if ([button isKindOfClass:[UIButton class]]) {
            [(UIButton *)button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        button.frame = CGRectMake(0, 0, maxSize.width, maxSize.height);
        button.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [container insertSubview:button atIndex:container.subviews.count];
        
        [self resetButtons];
    }
    return container;
}
-(void)buttonClicked:(UIButton *)sender
{
    if (callBack) {
        callBack([buttons indexOfObject:sender]);
    }
}

-(void) resetButtons
{
    int index = 0;
    for (UIView * button in buttons) {
        button.frame = CGRectMake(index * button.bounds.size.width, 0, button.bounds.size.width, self.bounds.size.height);
        button.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        index++;
    }
}

-(void)dealloc
{
    buttonsView=nil;
    buttons=nil;
}
@end
