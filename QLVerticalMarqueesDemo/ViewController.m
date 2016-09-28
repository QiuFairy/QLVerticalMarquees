//
//  ViewController.m
//  QLVerticalMarqueesDemo
//
//  Created by qiu on 16/7/4.
//  Copyright © 2016年 QiuFairy. All rights reserved.
//

/**
 *  @author QiuFairy, 16-07-04 15:07:01
 *
 *  此Demo适用于各种垂直方向上的跑马灯，操作简单，
 *  可以点击回调事件
 *  
 *  只需要给QLHeadLine一个数组，即可点击返回点击的第几个对象
 *
 *  note: 因为使用了定时器，故应在VC消失时，去掉timer
 */

#import "ViewController.h"
#import "QLHeadLine.h"

@interface ViewController ()
@property (nonatomic, strong) QLHeadLine *headLine;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor= [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    QLHeadLine *headLine = [[QLHeadLine alloc]initWithFrame:CGRectMake(80, 200, [UIScreen mainScreen].bounds.size.width-120, 40)];
    headLine.messageArray = @[@"1,北京有大熊猫",@"2,南极有北极星，有北极熊，有企鹅，有猫头鹰，有海报",@"3,北极有黑人，有水，有很多水，有非常多的水",@"4,上海有人，有很多人，有非常多的人"];
    [headLine setBgColor:[UIColor cyanColor] textColor:[UIColor blackColor] textFont:[UIFont boldSystemFontOfSize:12]];
    [headLine setScrollDuration:0.8f stayDuration:3.0];
    headLine.hasGradient = YES;
    [headLine changeTapMarqueeAction:^(NSInteger btnTag) {
        NSLog(@"%ld",(long)btnTag);
        
    }];
    [headLine start];
    self.headLine = headLine;
    [self.view addSubview:headLine];
}
-(void)viewDidDisappear:(BOOL)animated{
    [self.headLine stop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
