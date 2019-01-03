# 优点游戏 iOS SDK 客户端说明文档

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/youdiangame/iOS-LYSDKDemo/master/LICENSE)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%208%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;

# [点击查看更新日志](https://github.com/youdiangame/iOS-LYSDKDemo/blob/master/LYSDKVerisonReadMe.txt 'Title')

# 演示项目

查看并运行 `LYSDKDemo/LYSDKDemo.xcodeproj`

# 使用

1. 下载 LYSDKDemo 文件夹内的所有内容。<br/>
   <img src="https://github.com/youdiangame/iOS-LYSDKDemo/blob/master/Snapshots/FrameworkPath.png"><br/>
2. 将 Frameworks 内的 LYSDK.framework 和 LYAssets.xcassets 添加(拖放)到你的工程目录中。
   <img src="https://github.com/youdiangame/iOS-LYSDKDemo/blob/master/Snapshots/Framework.png"><br/>
3. 在对应项目 Targets 下找到 General。<br/>
   在 Deployment Info 根据游戏需要，自行限制横屏还是竖屏。并且在 AppDelegate 入口限制方向<br/>

   ```
   - (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
   {
       return UIInterfaceOrientationMaskPortrait;
   }
   ```

   勾选 Hide status bar 和 requires full screen，并且在 info.plist 下加 View controller-based status bar appearance 设置为 NO
   并且在 Embedded Binaries 和 Linked Frameworks and Libraries 链接 frameworks:
   <img src="https://github.com/youdiangame/iOS-LYSDKDemo/blob/master/Snapshots/FrameworkLink.png"><br/>

4. 导入 `<LYSDK/LYSDK.h>`。

```
#import <LYSDK/LYSDK.h>
```

5. 初始化 SDK。并更改对应的参数

#### 初始化 SDK `初始化方法要写在[self.window makeKeyAndVisible]方法之后`

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[LYSDK lySharedSDK] lyInitWithId:@"AEF6EACFAF3F18795DC48F37BC3A41864"
                              openKey:@"f56245b440ee04aa9b765bd07791308c"
                            lyChannel:LYChannelYD
                              trackId:@"C92146DE6E7EB663893D797678A50A480"
                              success:^{

                              } failure:^(int errcode, NSString *errorMessage) {

                              }];
    return YES;
}
```

#### 获取 SDK 版本号

```objective-c
NSString *version = LYSDKVersion;
```

#### 登陆方法

```objective-c
- (void)loginButtonClick
{
    [[LYSDK lySharedSDK] lyLogin];
}
```

#### 支付方法

```objective-c
- (void)payButtonClick
{
    NSString *productId = @"com.ly.sdkdemo.6";
    //运营提供参数
    NSString *ydProductId = @"P001085";

    LYOrder *lyOrder = [LYOrder new];
    [lyOrder setYdOrderId:[self generateTradeNO]];
    [lyOrder setYdProductId:productId];
    [lyOrder setYdToolProductId:ydProductId];
    [lyOrder setYdProductName:@"60元宝"];
    [lyOrder setYdRoleName:@"roleName"];
    [lyOrder setYdCustomInfo:@"CustomInfo"];
    [lyOrder setLyTotalFee:6];

    [[LYSDK lySharedSDK] lySelect:lyOrder];
}
```

#### 登陆成功回调方法

```objective-c
[[LYSDK lySharedSDK] setLyLoginSuccessBlock:^(LYUser *user) {
  long userId = user.lyUserId;
  NSString *userName = user.lyUsername;
  NSLog(@"登录回调");
  NSLog(@"userId - %ld userName - %@", userId, userName);
}];
```

#### 用户注销回调方法

```objective-c
[[LYSDK lySharedSDK] setLyLogoutBlock:^{
  NSLog(@"注销回调");
}];
```

#### IAP 支付回调方法

```objective-c
[[LYSDK lySharedSDK] setLyAppleBlock:^(LYAppleType lyAppleType) {
  NSLog(@"苹果支付回调 - %ld", (long)lyAppleType);
}];
```

# 注意

1、项目编译 build Settings 的 Base SDK 选当前最新的版本。至少 iOS11 以上。不然会出现一些比较奇怪的问题。

# 系统要求

该项目最低支持 `iOS 8.0` 和 `Xcode 7.0`。

# 许可证

LYSDK 使用 MIT 许可证，详情见 LICENSE 文件。
