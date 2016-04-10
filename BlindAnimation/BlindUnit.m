//
//  BlindUnit.m
//  BlindAnimation
//
//  Created by hgdq on 16/4/10.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import "BlindUnit.h"
#import "ToolUnit.h"

@interface BlindUnit ()

@property (nonatomic,assign)NSInteger startCount;
@property (nonatomic,assign)NSInteger endCount;

@end

@implementation BlindUnit

/**
 *  百叶窗动画
 */
- (void)blindAnimation{
    NSDictionary *dice = [ToolUnit separateImage:self.image separate:self.separateCount cacheQuality:self.cacheQuality];
    // 百叶窗动画
    CABasicAnimation *rotation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotation.duration = self.duration;
    rotation.fromValue = [NSNumber numberWithFloat:0];    // 从0°开始
    rotation.toValue = [NSNumber numberWithFloat:M_PI_2]; // 转动180°
    rotation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    rotation.autoreverses = YES;  // 翻转后是否反向翻转
    rotation.repeatCount = MAXFLOAT;    // 循环次数
    rotation.delegate = self;    // 动画代理
    NSArray *keys=[dice allKeys];
    for (int count = 0; count < self.separateCount; count++)
    {
        NSString *key=[keys objectAtIndex:count];
        UIImageView *imageView=[dice objectForKey:key];
        [imageView.layer addAnimation:rotation forKey:@"rotation"];
        [self.superView addSubview:imageView];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    // 原系统代理会多次执行 执行次数就是图片分割的数量
    self.endCount ++;
    if ((self.separateCount - 1) == self.endCount) {
        //代理
        if (_delegate && [_delegate respondsToSelector:@selector(blindFinishedAnimation)]) {
            [_delegate blindFinishedAnimation];
        }
    }
}
- (void)animationDidStart:(CAAnimation *)anim{
    // 原系统代理会多次执行 执行次数就是图片分割的数量
    if (self.startCount == 0) {
        //代理
        if (_delegate && [_delegate respondsToSelector:@selector(blindStartAnimation)]) {
            [_delegate blindStartAnimation];
        }
    }
    self.startCount ++;
}

/**
 *  百叶窗
 *
 *  @param superView 父视图
 *  @param image     需要变化的图片
 *  @param x         多少个叶
 *  @param quality   切割的质量 0~1之间
 *  @param duration  动画的时间
 */
+ (void)blindAnimationInSuperView:(UIView *)superView image:(UIImage *)image separate:(NSInteger)x cacheQuality:(CGFloat)quality duration:(CFTimeInterval)duration{
    
    NSDictionary *dice = [ToolUnit separateImage:image separate:x cacheQuality:quality];
    // 百叶窗动画
    CABasicAnimation *rotation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotation.duration = duration;
    rotation.fromValue = [NSNumber numberWithFloat:0];    // 从0°开始
    rotation.toValue = [NSNumber numberWithFloat:M_PI_2]; // 转动180°
    rotation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    rotation.autoreverses = NO;  // 翻转后是否反向翻转
    rotation.repeatCount = 1;    // 循环次数
    NSArray *keys=[dice allKeys];
    for (int count = 0; count < x; count++)
    {
        NSString *key=[keys objectAtIndex:count];
        UIImageView *imageView=[dice objectForKey:key];
        [imageView.layer addAnimation:rotation forKey:@"rotation"];
        [superView addSubview:imageView];
    }
}

@end