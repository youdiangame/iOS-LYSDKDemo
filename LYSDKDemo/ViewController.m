//
//  ViewController.m
//  QuYiDemo
//
//  Created by Data_Lucky on 2018/5/22.
//  Copyright © 2018年 Dateeye. All rights reserved.
//

#import "ViewController.h"
#import <LYK/LYK.h>


@interface ViewController ()
{
    NSArray *_btnTitles;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _btnTitles = @[@"登 陆",@"支 付",@"用户中心",@"注 销"];
    
    CGFloat topMar = 40;
    CGFloat lefMar = 40;
    CGFloat itemMar = 18;
    CGFloat itemWidth = 120;
    CGFloat itemHeight = 33;
    UIImage *btbImage = [UIImage imageNamed:@"LYRegButton"];
    
    [_btnTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [tempBtn setFrame:CGRectMake(lefMar, topMar + (itemHeight + itemMar) * idx , itemWidth, itemHeight)];
        [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [tempBtn setTitle:obj forState:UIControlStateNormal];
        [tempBtn setTag:idx];
        [tempBtn setBackgroundImage:btbImage forState:UIControlStateNormal];
        [tempBtn addTarget:self action:@selector(tempBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:tempBtn];
    }];
    
    
    
    
    [[LYK lyShared] setLyLoginSuccessBlock:^(LYUser *user) {
        long userId = user.lyUserId;
        NSString *userName = user.lyUsername;
        NSLog(@"登录回调");
        NSLog(@"userId - %ld userName - %@", userId, userName);
    }];
    
    [[LYK lyShared] setLyLogoutBlock:^{
        NSLog(@"注销回调");
    }];
    
    [[LYK lyShared] setLyAppleBlock:^(LYAppleType lyAppleType) {
        NSLog(@"苹果支付回调 - %ld", (long)lyAppleType);
    }];
    
}

#pragma mark --按钮点击事件--
- (void)tempBtnClick:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 0:
        {
            //登录
            [[LYK lyShared] lyLogin];
            break;
        }
        case 1:
        {
            //支付
            NSString *productId = @"com.ly.sdkdemo.6";
            NSString *ydProductId = @"P000735";
            
            
            LYOrder *lyOrder = [LYOrder new];
            [lyOrder setYdOrderId:[self generateTradeNO]];
            [lyOrder setYdProductId:productId];
            [lyOrder setYdToolProductId:ydProductId];
            [lyOrder setYdProductName:@"60元宝"];
            [lyOrder setYdRoleName:@"roleName"];
            [lyOrder setYdCustomInfo:@"CustomInfo"];
            [lyOrder setLyTotalFee:6];
            
            [[LYK lyShared] lySelect:lyOrder];
            break;
        }
        case 2:
        {
            //用户中心
            [[LYK lyShared] lyUserCenter];
            break;
        }
        case 3:
        {
            //注销
            [[LYK lyShared] lyLogout];
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

