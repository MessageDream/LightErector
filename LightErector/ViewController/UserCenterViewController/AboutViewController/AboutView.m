//
//  AboutView.m
//  LightErector
//
//  Created by Jayden Zhao on 10/21/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "AboutView.h"
#import "UIHyperlinksButton.h"

@interface AboutView()
{
    UIHyperlinksButton *webSiteBtn;
}
@end
@implementation AboutView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[MainStyle mainBackColor];
        self.customTitleBar.titleText= @"关于灯师傅";
        self.customTitleBar.leftButtonImage=[UIImage imageNamed:@"nav_btn_right_return"];
        
        CGFloat space=10.0f;
         CGSize maximumLabelSize = CGSizeMake(frame.size.width-space*2,MAXFLOAT);
        UIFont *font=[UIFont systemFontOfSize:14];
        NSString *firstTxt=@"郑州灯师傅照明工程有限公司(原网盛灯保姆品牌)是一家专注于灯饰安装、清洗、维修、保养等售后服务的专业化服务公司。我们通过遍布全国的售后服务团队为全国灯饰产品消费者及商家提供专业、便捷的售后服务。";
        UILabel *firstLable=[[UILabel alloc] initWithFrame:CGRectMake(space, space, frame.size.width-space*2, 0)];
        firstLable.backgroundColor=[UIColor clearColor];
        firstLable.font=font;
        CGSize expectedLabelSizeFirst = [firstTxt sizeWithFont:font
                                                      constrainedToSize:maximumLabelSize
                                                          lineBreakMode:NSLineBreakByWordWrapping];
        
        frame=firstLable.frame;
        frame.size=expectedLabelSizeFirst;
        firstLable.frame=frame;
        firstLable.numberOfLines=0;
        firstLable.text=firstTxt;
        
        [_scrollerView addSubview:firstLable];
        
        NSString *secondTxt=@"公司在灯饰售后服务领域拥有近十二年的行业从业经验。核心创始人02年起从中国灯饰之都“古镇”起步，十几年来摸爬滚打的生涯使其掌握了从灯饰制造至安装交付使用的每一个细节。我们的足迹遍布了祖国的大江南北，从北京到上海、西安、济南、武汉、重庆……，安装的工程案例大到上千万的五星级酒店大堂水晶灯，也有小到别墅、居家装饰的灯饰产品。";
        
        CGSize expectedLabelSizeSecond = [secondTxt sizeWithFont:font
                                            constrainedToSize:maximumLabelSize
                                                lineBreakMode:NSLineBreakByWordWrapping];
        
        UILabel *secondLable=[[UILabel alloc] initWithFrame:CGRectMake(space, firstLable.frame.size.height+firstLable.frame.origin.y, frame.size.width-space*2, 0)];
        secondLable.backgroundColor=[UIColor clearColor];
        secondLable.font=font;
        
        frame=secondLable.frame;
        frame.size=expectedLabelSizeSecond;
        secondLable.frame=frame;
        secondLable.numberOfLines=0;
        secondLable.text=secondTxt;
        [_scrollerView addSubview:secondLable];
        
        NSString *thirdTxt=@"正因为我们十几年的行业从业经验，使我们深深了解到灯饰类产品售后服务的重要性。深刻了解消费者与商家的服务需求。";
        
        CGSize expectedLabelSizeThird = [thirdTxt sizeWithFont:font
                                               constrainedToSize:maximumLabelSize
                                                   lineBreakMode:NSLineBreakByWordWrapping];
        
        UILabel *thirdLable=[[UILabel alloc] initWithFrame:CGRectMake(space, secondLable.frame.size.height+secondLable.frame.origin.y, frame.size.width-space*2, 0)];
        thirdLable.backgroundColor=[UIColor clearColor];
        thirdLable.font=font;
        
        frame=thirdLable.frame;
        frame.size=expectedLabelSizeThird;
        thirdLable.frame=frame;
        thirdLable.numberOfLines=0;
        thirdLable.text=thirdTxt;
        [_scrollerView addSubview:thirdLable];
        
        NSString *fourTxt=@"灯师傅将始终致力于为消费者和商家提供便捷、高效、一体化的售后服务平台。";
        
        CGSize expectedLabelSizeFour = [fourTxt sizeWithFont:font
                                             constrainedToSize:maximumLabelSize
                                                 lineBreakMode:NSLineBreakByWordWrapping];
        
        UILabel *fourLable=[[UILabel alloc] initWithFrame:CGRectMake(space, thirdLable.frame.size.height+thirdLable.frame.origin.y, frame.size.width-space*2, 0)];
        fourLable.backgroundColor=[UIColor clearColor];
        fourLable.font=font;
        
        frame=fourLable.frame;
        frame.size=expectedLabelSizeFour;
        fourLable.frame=frame;
        fourLable.numberOfLines=0;
        fourLable.text=fourTxt;
        [_scrollerView addSubview:fourLable];
        
        NSString *fiveTxt=@"我们的宗旨：打造国内最专业，最有影响力的灯饰售后服务团队。";
        
        CGSize expectedLabelSizeFive = [fiveTxt sizeWithFont:font
                                            constrainedToSize:maximumLabelSize
                                                lineBreakMode:NSLineBreakByWordWrapping];
        
        UILabel *fiveLable=[[UILabel alloc] initWithFrame:CGRectMake(space, fourLable.frame.size.height+fourLable.frame.origin.y, frame.size.width-space*2, 0)];
        fiveLable.backgroundColor=[UIColor clearColor];
        fiveLable.font=font;
        
        frame=fiveLable.frame;
        frame.size=expectedLabelSizeFive;
        fiveLable.frame=frame;
        fiveLable.numberOfLines=0;
        fiveLable.text=fiveTxt;
        [_scrollerView addSubview:fiveLable];
        
        UILabel *sixLable=[[UILabel alloc] initWithFrame:CGRectMake(space, fiveLable.frame.size.height+fiveLable.frame.origin.y,130, 20)];
        sixLable.backgroundColor=[UIColor clearColor];
        sixLable.font=font;
        sixLable.text=@"了解更多详情点击：";
        [_scrollerView addSubview:sixLable];
        
        webSiteBtn = [UIHyperlinksButton hyperlinksButton];
        webSiteBtn.frame = CGRectMake(sixLable.frame.origin.x+sixLable.frame.size.width, sixLable.frame.origin.y, 180, 20);
        [webSiteBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        webSiteBtn.titleLabel.font = font;
        NSString *str =@"www.dengbaomu.com";
        [webSiteBtn setTitle:str forState:UIControlStateNormal];
        [webSiteBtn setColor:[UIColor blueColor]];
        [_scrollerView addSubview:webSiteBtn];
        //_scrollerView.contentSize=CGSizeMake(self.frame.size.width, webSiteBtn.frame.size.height+webSiteBtn.frame.origin.y);
    }
    return self;
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
