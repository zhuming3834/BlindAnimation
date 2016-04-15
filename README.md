# BlindAnimation
##百叶窗动画
![](https://github.com/zhuming3834/BlindAnimation/blob/master/blind.gif)<br>
百叶窗动画显示原理:<br>
1.先把图片切分为一定的份数;<br>
2.做一个切割后的小图片的动画;<br>
3.设置动画相关的参数如:动画循环次数,动画时间等.<br>

###图片切割
```OC
/**
 *  图片切割
 *
 *  @param image   需要切割的图片
 *  @param x       切割的份数
 *  @param quality 切割的质量
 *
 *  @return 切割后小图片的文件路径
 */
+ (NSDictionary *)separateImage:(UIImage *)image separate:(NSInteger)x cacheQuality:(CGFloat)quality
{
    // 错误处理
    if (x<1) {
        NSLog(@"illegal x!");
        return nil;
    }
    if (![image isKindOfClass:[UIImage class]]) {
        NSLog(@"illegal image format!");
        return nil;
    }
    
    CGFloat xstep = image.size.width*1.0;
    CGFloat ystep = image.size.height*1.0/x;
    NSMutableDictionary *mutableDictionary=[[NSMutableDictionary alloc]initWithCapacity:1];
    NSString *prefixName = @"win";
    
    // 把图片裁剪为小图片存进沙盒
    for (int i=0; i<x; i++)
    {
        for (int j=0; j<1; j++)
        {
            CGRect rect=CGRectMake(xstep*j, ystep*i, xstep, ystep);
            CGImageRef imageRef=CGImageCreateWithImageInRect([image CGImage],rect);
            UIImage* elementImage=[UIImage imageWithCGImage:imageRef];
            UIImageView *imageView=[[UIImageView alloc] initWithImage:elementImage];
            imageView.frame=rect;
            NSString *imageString=[NSString stringWithFormat:@"%@_%d_%d.jpg",prefixName,i,j];
            // 切割后的图片保存进字典        图片               图片名
            [mutableDictionary setObject:imageView forKey:imageString];
            
            if (quality<=0)
            {
                continue;
            }
            quality=(quality>1)?1:quality;
            // 切割后的图片写进文件
            NSString *imagePath=[NSHomeDirectory() stringByAppendingPathComponent:imageString];
            // 图片压缩 quality是压缩系数  0~1 之间
            NSData *imageData=UIImageJPEGRepresentation(elementImage, quality);
            // 压缩后的图片 写进文件
            [imageData writeToFile:imagePath atomically:NO];
        }
    }
    NSDictionary *dictionary = mutableDictionary;
    return dictionary;
}
```
###百叶窗动画
```OC
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
```
###百叶窗动画视图的使用
1.包含头文件<br>
```OC
#import "BlindUnit.h"
```
2.设置代理<br>
```OC
BlindDelegate
```
3.新建视图<br>
```OC
BlindUnit *blindView = [[BlindUnit alloc] init];
blindView.superView = self.view;
blindView.image = self.image1;
blindView.separateCount = 12;
blindView.cacheQuality = 1;
blindView.duration = 3;
blindView.delegate = self;
[blindView blindAnimation];
```
4.实现代理方法<br>
```OC
- (void)blindFinishedAnimation{
    NSLog(@"blindFinishedAnimation");
}
- (void)blindStartAnimation{
    NSLog(@"blindStartAnimation");
}
```
详细使用可以查看博客[《【iOS】百叶窗动画》](http://blog.csdn.net/zhuming3834/article/details/50499636)<br>


