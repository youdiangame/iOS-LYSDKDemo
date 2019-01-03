//
//  ViewController.m
//  QuYiDemo
//
//  Created by Data_Lucky on 2018/5/22.
//  Copyright © 2018年 Dateeye. All rights reserved.
//

#import "ViewController.h"
#import <LYSDK/LYSDK.h>


@interface ViewController ()
{
    NSArray *_btnTitles;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _btnTitles = @[@"初始化",@"登 陆",@"支 付",@"用户中心",@"注 销",@"修改地址"];
    
    CGFloat topMar = 40;
    CGFloat lefMar = 40;
    CGFloat itemMar = 18;
    CGFloat itemWidth = 120;
    CGFloat itemHeight = 33;
    UIImage *btbImage = [UIImage imageNamed:@"YDRegButton"];
    UIImage *btnImageHighlighted = [UIImage imageNamed:@"Button_Highlighted"];
    
    [_btnTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [tempBtn setFrame:CGRectMake(lefMar, topMar + (itemHeight + itemMar) * idx , itemWidth, itemHeight)];
        [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [tempBtn setTitle:obj forState:UIControlStateNormal];
        [tempBtn setTag:idx];
        [tempBtn setBackgroundImage:btbImage forState:UIControlStateNormal];
        [tempBtn setBackgroundImage:btnImageHighlighted forState:UIControlStateSelected];
        [tempBtn addTarget:self action:@selector(tempBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:tempBtn];
    }];
    
    
    UIImage *image3 = [UIImage imageNamed:@"YDGift"];
    UIImageView *imageView3 = [UIImageView new];
    [imageView3 setImage:image3];
    [self.view addSubview:imageView3];
    
    [imageView3 setFrame:CGRectMake(300, 100, 20, 20)];
    
    [[LYSDK lySharedSDK] setLyLoginSuccessBlock:^(LYUser *user) {
        long userId = user.lyUserId;
        NSString *userName = user.lyUsername;
        NSLog(@"登录回调");
        NSLog(@"userId - %ld userName - %@", userId, userName);
    }];
    
    [[LYSDK lySharedSDK] setLyLogoutBlock:^{
        NSLog(@"注销回调");
    }];
    
    [[LYSDK lySharedSDK] setLyAppleBlock:^(LYAppleType lyAppleType) {
        NSLog(@"苹果支付回调 - %ld", (long)lyAppleType);
    }];
    
}

#pragma mark --按钮点击事件--
- (void)tempBtnClick:(UIButton *)sender
{
    switch (sender.tag) {
            //初始化
        case 0:
        {
            break;
        }
            //登陆
        case 1:
        {
            [[LYSDK lySharedSDK] lyLogin];
            break;
        }
            //支付
        case 2:
        {
            
            NSString *productId = @"com.ly.sdkdemo.6";
            NSString *ydProductId = @"P001085";
            
            
            LYOrder *lyOrder = [LYOrder new];
            [lyOrder setYdOrderId:[self generateTradeNO]];
            [lyOrder setYdProductId:productId];
            [lyOrder setYdToolProductId:ydProductId];
            [lyOrder setYdProductName:@"60元宝"];
            [lyOrder setYdRoleName:@"roleid"];
            [lyOrder setYdCustomInfo:@"CustomInfo"];
            [lyOrder setLyTotalFee:6];
            
            [[LYSDK lySharedSDK] lySelect:lyOrder];
            break;
        }
            //用户中心
        case 3:
        {
            [[LYSDK lySharedSDK] lyUserCenter];
            break;
        }
        case 4:
        {
            [[LYSDK lySharedSDK] lyLogout];
            break;
        }
            //修改地址
        case 5:
        {
            break;
        }
    }
}

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


@end

