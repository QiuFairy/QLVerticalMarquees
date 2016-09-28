//
//  QLHeadLine.m
//  QLVerticalMarqueesDemo
//
//  Created by qiu on 16/7/4.
//  Copyright © 2016年 QiuFairy. All rights reserved.
//

#import "QLHeadLine.h"

//#import "SXColorGradientView.h"

#define kSXHeadLineMargin 10

typedef void(^SXWonderfulAction)(NSInteger BtnTag);

@interface QLHeadLine ()

@property(nonatomic,strong)UILabel *label1;
@property(nonatomic,strong)UILabel *label2;
@property(nonatomic,assign)NSInteger messageIndex;
@property(nonatomic,assign)CGFloat h;
@property(nonatomic,assign)CGFloat w;
@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,strong)UIButton *bgBtn1;
@property(nonatomic,strong)UIButton *bgBtn2;
@property(nonatomic,strong)SXWonderfulAction tapAction;

@end

@implementation QLHeadLine

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.h = frame.size.height;
        self.w = frame.size.width;
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(kSXHeadLineMargin, 0, frame.size.width, _h)];
        label1.numberOfLines = 0;
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(kSXHeadLineMargin, _h, frame.size.width, _h)];
        label2.numberOfLines = 0;
        self.bgColor = [UIColor whiteColor];
        self.textColor = [UIColor blackColor];
        self.scrollDuration = 1.0f;
        self.stayDuration = 4.0f;
        self.cornerRadius = 2;
        self.textFont = [UIFont systemFontOfSize:12];
        label1.font = label2.font = _textFont;
        label1.textColor = label2.textColor = _textColor;
        self.label1 = label1;
        self.label2 = label2;
        [self addSubview:label1];
        [self addSubview:label2];
        self.layer.cornerRadius = self.cornerRadius;
        self.layer.masksToBounds = YES;
    }
    return self;
}

#pragma mark - **************** animate
- (void)scrollAnimate
{
    CGRect rect1 = self.label1.frame;
    CGRect rect2 = self.label2.frame;
    rect1.origin.y -= _h;
    rect2.origin.y -= _h;
    [UIView animateWithDuration:_scrollDuration animations:^{
        self.label1.frame = rect1;
        self.label2.frame = rect2;
        self.bgBtn1.frame = rect1;
        self.bgBtn2.frame = rect2;
    } completion:^(BOOL finished) {
        [self checkButtonFrameChange:self.bgBtn1];
        [self checkButtonFrameChange:self.bgBtn2];
        [self checkLabelFrameChange:self.label1];
        [self checkLabelFrameChange:self.label2];
    }];
}


- (void)checkLabelFrameChange:(UILabel *)label
{
    if (label.frame.origin.y < -10) {
        CGRect rect = label.frame;
        rect.origin.y = _h;
        label.frame = rect;
        label.text = self.messageArray[self.messageIndex];
        if (self.messageIndex == self.messageArray.count - 1) {
            self.messageIndex = 0;
        }else{
            self.messageIndex += 1;
        }
    }
}

- (void)checkButtonFrameChange:(UIButton *)button
{
    if (button.frame.origin.y < -10) {
        CGRect rect = button.frame;
        rect.origin.y = _h;
        button.frame = rect;
        button.tag = self.messageIndex;
    }
}

#pragma mark ---- 点击事件
- (void)changeTapMarqueeAction:(void(^)(NSInteger btnTag))action{
    [self addSubview:self.bgBtn1];
    [self addSubview:self.bgBtn2];
    self.tapAction = action;
}
- (UIButton *)bgBtn1{
    if (!_bgBtn1) {
        _bgBtn1 = [[UIButton alloc]initWithFrame:self.label1.frame];
        _bgBtn1.tag =0;
        [_bgBtn1 addTarget:self action:@selector(bgButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgBtn1;
}
- (UIButton *)bgBtn2{
    if (!_bgBtn2) {
        _bgBtn2 = [[UIButton alloc]initWithFrame:self.label2.frame];
        _bgBtn2.tag =1;
        [_bgBtn2 addTarget:self action:@selector(bgButtonClick:)
          forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgBtn2;
}

- (void)bgButtonClick:(UIButton *)sender{
    if (self.tapAction) {
        self.tapAction(sender.tag);
    }
}

#pragma mark - **************** opration
- (void)start{
    if (self.messageArray.count < 2) {
        return;
    }
    NSTimer *timer = [NSTimer timerWithTimeInterval:_stayDuration target:self selector:@selector(scrollAnimate) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)stop{
    [self.timer invalidate];
}

#pragma mark - **************** set
-(void)setMessageArray:(NSArray *)messageArray
{
    _messageArray = messageArray;
    if (self.messageArray.count > 2) {
        self.label1.text = self.messageArray[0];
        self.label2.text = self.messageArray[1];
        self.messageIndex = 2;
    }else if (self.messageArray.count == 1){
        self.label1.text = self.messageArray[0];
    }else if (self.messageArray.count == 2){
        self.label1.text = self.messageArray[0];
        self.label2.text = self.messageArray[1];
        self.messageIndex = 0;
    }
}

- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    self.label1.textColor = textColor;
    self.label2.textColor = textColor;
}

- (void)setTextFont:(UIFont *)textFont{
    _textFont = textFont;
    self.label1.font = textFont;
    self.label2.font = textFont;
}

- (void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
    self.backgroundColor = bgColor;
}

- (void)setScrollDuration:(NSTimeInterval)scrollDuration{
    _scrollDuration = scrollDuration;
}

- (void)setStayDuration:(NSTimeInterval)stayDuration{
    _stayDuration = stayDuration;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setBgColor:(UIColor *)bgColor textColor:(UIColor *)textColor textFont:(UIFont *)textFont
{
    self.bgColor = bgColor;
    self.textColor = textColor;
    self.textFont = textFont;
}

- (void)setScrollDuration:(NSTimeInterval)scrollDuration stayDuration:(NSTimeInterval)stayDuration
{
    self.scrollDuration = scrollDuration;
    self.stayDuration = stayDuration;
}


@end
