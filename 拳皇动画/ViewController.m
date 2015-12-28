//
//  ViewController.m
//  拳皇动画
//
//  Created by 胡祥 on 15/11/14.
//  Copyright © 2015年 胡祥. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *images;
//用于停止动画
@property (weak, nonatomic) IBOutlet UIButton *stopAnimation;
@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) AVPlayer *player;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
   
        [self standAnimation];
    
    [self.stopAnimation addTarget:nil action:@selector(dead) forControlEvents:UIControlEventTouchUpInside];
    
}

//加载声音
-(void)loadsound:(NSString *)name
{
    NSURL *url = [[NSBundle mainBundle]URLForResource:name withExtension:@"mp3"];
//    NSLog(@"%@",url);
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:url];
   AVPlayer *player = [[AVPlayer alloc]initWithPlayerItem:item];
    self.player = player;
    [self.player play];
    
}

//抽取一个动画效果
-(void)animationStartWithCount:(NSInteger)count andName:(NSString *)name
{
    
    NSMutableArray *imageArray = [NSMutableArray array];
    self.imageArray = imageArray;
    
    for (int i = 0; i < count; i++) {
        
        NSString *imageName = [NSString stringWithFormat:@"%@_%d",name,i+1];
        
        NSString *imagePath = [[NSBundle mainBundle]pathForResource:imageName ofType:@"png"];
        
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
 
        [self.imageArray addObject:image];
        
    }
    
    self.images.animationImages = self.imageArray;
//NSLog(@"%@",self.imageArray);
    
    if (![name isEqualToString:@"stand"]) {
        
        NSTimeInterval time = self.imageArray.count *1 / 30.0;
        NSLog(@"%ld",self.imageArray.count);
        [self performSelector:@selector(standAnimation) withObject:nil afterDelay:time];
    }

    [self.images startAnimating];
    [self loadsound:name];
  
}


//站立
- (IBAction)standAnimation {
    
    self.images.animationRepeatCount = 0;
    [self animationStartWithCount:10 andName:@"stand"];

//    [self.images startAnimating];
    
    
}
//小招
- (IBAction)xiaoZhao {
    
   
     self.images.animationRepeatCount = 1;
    [self animationStartWithCount:21 andName:@"xiaozhao1"];
    
    
   [self performSelector:@selector(standAnimation) withObject:nil afterDelay:1];

}
//大招
- (IBAction)daZhao{
    
    self.images.animationRepeatCount = 1;
    [self animationStartWithCount:87 andName:@"dazhao"];
  
}
//跑
- (IBAction)run {
    self.images.animationRepeatCount = 1;
  
    
    [self animationStartWithCount:6 andName:@"run"];
    
    [self performSelector:@selector(standAnimation) withObject:nil afterDelay:1];
    
}
//不知道
- (IBAction)instabll {
   
    self.images.animationRepeatCount = 1;
    
    [self animationStartWithCount:29 andName:@"install_b"];
    
    [self performSelector:@selector(standAnimation) withObject:nil afterDelay:1.4];
}
//停止动画
- (IBAction)dead {
//    self.imageArray = nil;
    [self.images stopAnimating];
}



@end
