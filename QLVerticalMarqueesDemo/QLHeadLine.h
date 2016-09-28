//
//  QLHeadLine.h
//  QLVerticalMarqueesDemo
//
//  Created by qiu on 16/7/4.
//  Copyright © 2016年 QiuFairy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QLHeadLine : UIView

/**
 *  input messages
 */
@property(nonatomic,strong)NSArray *messageArray;
/**
 *  text color for message label
 */
@property(nonatomic,strong)UIColor *textColor;
/**
 *  text font for message label
 */
@property(nonatomic,strong)UIFont *textFont;
/**
 *  backgroundColor for headlineView
 */
@property(nonatomic,strong)UIColor *bgColor;
/**
 *  set self.layer.cornerRadius
 */
@property(nonatomic,assign)CGFloat cornerRadius;
/**
 *  if set yes ,it would add two gradientViews on top and bottom. style is from backgoundColor to transparent. like marquee 's left and right.
 */
@property(nonatomic,assign)BOOL hasGradient;
/**
 *  the Animation duration for label scroll to nextLabel.
 */
@property(nonatomic,assign)NSTimeInterval scrollDuration;
/**
 *  the duration for the label hold at a standstill
 */
@property(nonatomic,assign)NSTimeInterval stayDuration;
/**
 *  you can set three property together.
 */
- (void)setBgColor:(UIColor *)bgColor textColor:(UIColor *)textColor textFont:(UIFont *)textFont;
/**
 *  you can set two timeInterval setting toghter.
 */
- (void)setScrollDuration:(NSTimeInterval)scrollDuration stayDuration:(NSTimeInterval)stayDuration;

/**
 *  @author QiuFairy, 16-07-04 13:07:03
 *
 *  点击事件
 *
 *  @param action
 */
- (void)changeTapMarqueeAction:(void(^)(NSInteger btnTag))action;

/**
 *  add the timer and start headline animation.
 */
- (void)start;
/**
 *  stop the timer.
 */
- (void)stop;


@end
