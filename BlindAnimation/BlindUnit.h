//
//  BlindUnit.h
//  BlindAnimation
//
//  Created by hgdq on 16/4/10.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BlindDelegate <NSObject>

@optional
/**
 *  百叶窗动画开始实现的代理方法
 */
- (void)blindStartAnimation;
/**
 *  百叶窗动画完成后实现的代理方法
 */
- (void)blindFinishedAnimation;

@end

@interface BlindUnit : NSObject

@property (nonatomic,strong)id<BlindDelegate>delegate;

/**
 *  父视图
 */
@property (nonatomic,strong)UIView *superView;
/**
 *  百叶窗转动的动画
 */
@property (nonatomic,strong)UIImage *image;
/**
 *  水平切割的数量
 */
@property (nonatomic,assign)NSInteger separateCount;
/**
 *  切割的质量 0~1之间
 */
@property (nonatomic,assign)CGFloat cacheQuality;
/**
 *  动画得时间
 */
@property (nonatomic,assign)CFTimeInterval duration;

/**
 *  减方法 有动画完成的代理
 */
- (void)blindAnimation;

/**
 *  百叶窗
 *  无代理
 *  @param superView 父视图
 *  @param image     需要变化的图片
 *  @param x         多少个叶
 *  @param quality   切割的质量 0~1之间
 *  @param duration  动画的时间
 */
+ (void)blindAnimationInSuperView:(UIView *)superView image:(UIImage *)image separate:(NSInteger)x cacheQuality:(CGFloat)quality duration:(CFTimeInterval)duration;

@end

