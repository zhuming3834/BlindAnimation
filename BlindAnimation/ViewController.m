//
//  ViewController.m
//  BlindAnimation
//
//  Created by hgdq on 16/4/10.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import "ViewController.h"

#import "BlindUnit.h"
#import "ToolUnit.h"

@interface ViewController ()<BlindDelegate>

@property (nonatomic,strong)UIImage *image1;
@property (nonatomic,strong)UIImage *image2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.image1 = [UIImage imageNamed:@"1"];
    self.image2 = [UIImage imageNamed:@"2"];
    self.view.backgroundColor = [UIColor orangeColor];
    [self test];
    
    [ToolUnit compressImage:self.image2 percent:0.2];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)test{
    
    //    [BlindUnit blindAnimationInSuperView:self.view image:image separate:15 cacheQuality:1 duration:3];
    
    BlindUnit *blindView = [[BlindUnit alloc] init];
    blindView.superView = self.view;
    blindView.image = self.image1;
    blindView.separateCount = 12;
    blindView.cacheQuality = 1;
    blindView.duration = 3;
    blindView.delegate = self;
    [blindView blindAnimation];
}

- (void)blindFinishedAnimation{
    NSLog(@"blindFinishedAnimation");
}
- (void)blindStartAnimation{
    NSLog(@"blindStartAnimation");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end