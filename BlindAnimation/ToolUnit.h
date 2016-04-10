//
//  ToolUnit.h
//  BlindAnimation
//
//  Created by hgdq on 16/4/10.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ToolUnit : NSObject

/**
 *  图片裁剪
 *
 *  @param superImage 需要被裁剪的图片
 *  @param subRect    需要裁剪的区域
 *
 *  @return 裁剪后的图片
 */
+ (UIImage *)cutSuperImage:(UIImage *)superImage subImageRect:(CGRect)subRect;

/**
 *  图片压缩
 *
 *  @param superImage 需要被压缩的图片
 *  @param percent    压缩系数 0~1
 *
 *  @return 压缩后的图片
 */
+ (UIImage *)compressImage:(UIImage *)superImage percent:(CGFloat)percent;

/**
 *  截图
 *
 *  @param view 需要截取的视图
 *
 *  @return 目标视图
 */
+ (UIImage *)screenShotForView:(UIView *)view;

/**
 *  根据文件名获取文件路径
 *
 *  @param fileName 文件名
 *
 *  @return 返回文件路径
 */
+ (NSString *)getFilePath:(NSString *)fileName fileType:(NSString *)type;

/**
 *  图片切割
 *
 *  @param image   需要切割的图片
 *  @param x       切割的份数
 *  @param quality 切割的质量
 *
 *  @return 切割后小图片的文件路径
 */
+ (NSDictionary *)separateImage:(UIImage *)image separate:(NSInteger)x cacheQuality:(CGFloat)quality;

@end

