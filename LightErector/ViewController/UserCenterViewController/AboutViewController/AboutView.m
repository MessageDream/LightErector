//
//  AboutView.m
//  LightErector
//
//  Created by Jayden Zhao on 10/21/14.
//  Copyright (c) 2014 jayden. All rights reserved.
//

#import "AboutView.h"
#import "UIHyperlinksButton.h"
#import "ImageUtils.h"
#define TELPHONE     @"4000123863"
#define SERVICEPHONE @"037163221300"
#define MOBILEPHONE  @"18137275856"

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
        
        CGRect rect;
        CGFloat space=10.0f;
        CGSize maximumLabelSize = CGSizeMake(frame.size.width-space*2,MAXFLOAT);
        UIFont *font=[UIFont systemFontOfSize:14];
        NSString *firstTxt=@"   郑州灯师傅照明工程有限公司(原网盛灯保姆品牌)是一家专注于灯饰安装、清洗、维修、保养等售后服务的专业化服务公司。我们通过遍布全国的售后服务团队为全国灯饰产品消费者及商家提供专业、便捷的售后服务。";
        UILabel *firstLable=[[UILabel alloc] initWithFrame:CGRectMake(space, space, frame.size.width-space*2, 0)];
        firstLable.backgroundColor=[UIColor clearColor];
        firstLable.font=font;
        CGSize expectedLabelSizeFirst = [firstTxt sizeWithFont:font
                                                      constrainedToSize:maximumLabelSize
                                                          lineBreakMode:NSLineBreakByWordWrapping];
        
        rect=firstLable.frame;
        rect.size=expectedLabelSizeFirst;
        firstLable.frame=rect;
        firstLable.numberOfLines=0;
        firstLable.text=firstTxt;
        
        [_scrollerView addSubview:firstLable];
        
        NSString *secondTxt=@"   公司在灯饰售后服务领域拥有近十二年的行业从业经验。核心创始人02年起从中国灯饰之都“古镇”起步，十几年来摸爬滚打的生涯使其掌握了从灯饰制造至安装交付使用的每一个细节。我们的足迹遍布了祖国的大江南北，从北京到上海、西安、济南、武汉、重庆……，安装的工程案例大到上千万的五星级酒店大堂水晶灯，也有小到别墅、居家装饰的灯饰产品。";
        
        CGSize expectedLabelSizeSecond = [secondTxt sizeWithFont:font
                                            constrainedToSize:maximumLabelSize
                                                lineBreakMode:NSLineBreakByWordWrapping];
        
        UILabel *secondLable=[[UILabel alloc] initWithFrame:CGRectMake(space, firstLable.frame.size.height+firstLable.frame.origin.y, frame.size.width-space*2, 0)];
        secondLable.backgroundColor=[UIColor clearColor];
        secondLable.font=font;
        
        rect=secondLable.frame;
        rect.size=expectedLabelSizeSecond;
        secondLable.frame=rect;
        secondLable.numberOfLines=0;
        secondLable.text=secondTxt;
        [_scrollerView addSubview:secondLable];
        
        NSString *thirdTxt=@"   正因为我们十几年的行业从业经验，使我们深深了解到灯饰类产品售后服务的重要性。深刻了解消费者与商家的服务需求。";
        
        CGSize expectedLabelSizeThird = [thirdTxt sizeWithFont:font
                                               constrainedToSize:maximumLabelSize
                                                   lineBreakMode:NSLineBreakByWordWrapping];
        
        UILabel *thirdLable=[[UILabel alloc] initWithFrame:CGRectMake(space, secondLable.frame.size.height+secondLable.frame.origin.y, frame.size.width-space*2, 0)];
        thirdLable.backgroundColor=[UIColor clearColor];
        thirdLable.font=font;
        
        rect=thirdLable.frame;
        rect.size=expectedLabelSizeThird;
        thirdLable.frame=rect;
        thirdLable.numberOfLines=0;
        thirdLable.text=thirdTxt;
        [_scrollerView addSubview:thirdLable];
        
        NSString *fourTxt=@"   灯师傅将始终致力于为消费者和商家提供便捷、高效、一体化的售后服务平台。";
        
        CGSize expectedLabelSizeFour = [fourTxt sizeWithFont:font
                                             constrainedToSize:maximumLabelSize
                                                 lineBreakMode:NSLineBreakByWordWrapping];
        
        UILabel *fourLable=[[UILabel alloc] initWithFrame:CGRectMake(space, thirdLable.frame.size.height+thirdLable.frame.origin.y, frame.size.width-space*2, 0)];
        fourLable.backgroundColor=[UIColor clearColor];
        fourLable.font=font;
        
        rect=fourLable.frame;
        rect.size=expectedLabelSizeFour;
        fourLable.frame=rect;
        fourLable.numberOfLines=0;
        fourLable.text=fourTxt;
        [_scrollerView addSubview:fourLable];
        
        NSString *fiveTxt=@"   我们的宗旨：打造国内最专业，最有影响力的灯饰售后服务团队。";
        
        CGSize expectedLabelSizeFive = [fiveTxt sizeWithFont:font
                                            constrainedToSize:maximumLabelSize
                                                lineBreakMode:NSLineBreakByWordWrapping];
        
        UILabel *fiveLable=[[UILabel alloc] initWithFrame:CGRectMake(space, fourLable.frame.size.height+fourLable.frame.origin.y, frame.size.width-space*2, 0)];
        fiveLable.backgroundColor=[UIColor clearColor];
        fiveLable.font=font;
        
        rect=fiveLable.frame;
        rect.size=expectedLabelSizeFive;
        fiveLable.frame=rect;
        fiveLable.numberOfLines=0;
        fiveLable.text=fiveTxt;
        [_scrollerView addSubview:fiveLable];
        
        UILabel *sixLable=[[UILabel alloc] initWithFrame:CGRectMake(space, fiveLable.frame.size.height+fiveLable.frame.origin.y,130, 20)];
        sixLable.backgroundColor=[UIColor clearColor];
        sixLable.font=font;
        sixLable.text=@"   了解更多详情点击:";
        [_scrollerView addSubview:sixLable];
        
        webSiteBtn = [UIHyperlinksButton hyperlinksButton];
        webSiteBtn.frame = CGRectMake(sixLable.frame.origin.x+sixLable.frame.size.width, sixLable.frame.origin.y, 180, 20);
        [webSiteBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        webSiteBtn.titleLabel.font = font;
        [webSiteBtn addTarget:self action:@selector(web_click:) forControlEvents:UIControlEventTouchUpInside];
        NSString *str =@"www.dengbaomu.com";
        [webSiteBtn setTitle:str forState:UIControlStateNormal];
        [webSiteBtn setColor:[UIColor blueColor]];
        [_scrollerView addSubview:webSiteBtn];
        
        UIImage *btn_image = [ImageUtils createImageWithColor:[MainStyle mainGreenColor] andSize:CGSizeMake(self.frame.size.width-2*space, 40)];
        UIImage *btn_disableImage = [ImageUtils createImageWithColor:[MainStyle mainDarkColor] andSize:CGSizeMake(self.frame.size.width-2*space, 40)];
        UIButton  *btn_tel = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_tel.frame = CGRectMake(space, webSiteBtn.frame.origin.y+webSiteBtn.frame.size.height+space,btn_image.size.width, btn_image.size.height);
        [btn_tel setBackgroundImage:btn_image forState:UIControlStateNormal];
        [btn_tel setBackgroundImage:btn_disableImage forState:UIControlStateDisabled];
        btn_tel.titleLabel.font = [UIFont systemFontOfSize:14];
        btn_tel.tag=1101;
        [btn_tel setTitle:@"服务热线：4000－123－863" forState:UIControlStateNormal];
        [btn_tel addTarget:self action:@selector(call_click:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollerView addSubview:btn_tel];
        
        UIButton  *btn_service= [UIButton buttonWithType:UIButtonTypeCustom];
        btn_service.frame = CGRectMake(space, btn_tel.frame.origin.y+btn_tel.frame.size.height+space,btn_image.size.width, btn_image.size.height);
        [btn_service setBackgroundImage:btn_image forState:UIControlStateNormal];
        [btn_service setBackgroundImage:btn_disableImage forState:UIControlStateDisabled];
        btn_service.titleLabel.font = [UIFont systemFontOfSize:14];
        btn_service.tag=1102;
        [btn_service setTitle:@"服务固话：0371－63221300" forState:UIControlStateNormal];
        [btn_service addTarget:self action:@selector(call_click:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollerView addSubview:btn_service];
        
        UIButton  *btn_mobile= [UIButton buttonWithType:UIButtonTypeCustom];
        btn_mobile.frame = CGRectMake(space, btn_service.frame.origin.y+btn_service.frame.size.height+space,btn_image.size.width, btn_image.size.height);
        [btn_mobile setBackgroundImage:btn_image forState:UIControlStateNormal];
        [btn_mobile setBackgroundImage:btn_disableImage forState:UIControlStateDisabled];
        btn_mobile.titleLabel.font = [UIFont systemFontOfSize:14];
         btn_mobile.tag=1103;
        [btn_mobile setTitle:@"服务手机：18137275856" forState:UIControlStateNormal];
        [btn_mobile addTarget:self action:@selector(call_click:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollerView addSubview:btn_mobile];
        
        UILabel *sevenLable=[[UILabel alloc] initWithFrame:CGRectMake(space, btn_mobile.frame.size.height+btn_mobile.frame.origin.y+2*space,self.frame.size.width-space*2, 20)];
        sevenLable.backgroundColor=[UIColor clearColor];
        sevenLable.font=font;
        sevenLable.textAlignment=NSTextAlignmentCenter;
        sevenLable.text=@"灯师傅版权所有";
        [_scrollerView addSubview:sevenLable];
        
        UILabel *eightLable=[[UILabel alloc] initWithFrame:CGRectMake(space, sevenLable.frame.size.height+sevenLable.frame.origin.y,self.frame.size.width-space*2, 15)];
        eightLable.backgroundColor=[UIColor clearColor];
        eightLable.font=[UIFont systemFontOfSize:13];
        eightLable.textAlignment=NSTextAlignmentCenter;
        eightLable.text=@"2002－2014 dengbaomu.com.All rights reserved.";
        [_scrollerView addSubview:eightLable];

        _scrollerView.contentSize=CGSizeMake(self.frame.size.width, eightLable.frame.size.height+eightLable.frame.origin.y);
    }
    return self;
}


-(void)call_click:(UIButton*)sender
{
    if (self.observer&&[self.observer respondsToSelector:@selector(call_click:)]) {
        NSString *call=@"";
        switch (sender.tag) {
            case 1101:
                call=TELPHONE;
                break;
            case 1102:
                 call=SERVICEPHONE;
                break;
            case 1103:
                call=MOBILEPHONE;
                break;
            default:
                break;
        }
        if (![call length]) return;
        [self.observer call_click:call];
    }
}
-(void)web_click:(id)sender
{
    if (self.observer&&[self.observer respondsToSelector:@selector(web_click:)]) {
      UIHyperlinksButton *btn= ( UIHyperlinksButton*)sender;
        [self.observer web_click:btn.titleLabel.text];
    }
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
