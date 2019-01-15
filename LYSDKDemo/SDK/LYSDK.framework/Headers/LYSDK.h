//
//  LYSDK.h
//  LYSDK
//
//  Created by Seven on 2018/12/17.
//  Copyright © 2018 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYUser.h"
#import "LYOrder.h"
//#import "LYSDKProguard.h"

//! Project version number for LYSDK.
FOUNDATION_EXPORT double LYSDKVersionNumber;

//! Project version string for LYSDK.
FOUNDATION_EXPORT const unsigned char LYSDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <LYSDK/PublicHeader.h>

typedef NS_ENUM(NSInteger, LYChannel) {
    LYChannelYD = 1,              //优点
    LYChannelLY = 2,              //龙游
    LYChannelTest = 3,            //优点Pro
    LYChannelYDPro = 4
};


typedef NS_ENUM(NSInteger, LYAppleType) {
    LYDoesNotExistProduct  = 1,    //商品信息不存在
    LYUnknowFail           = 2,    //未知错误
    LYVerifyReceiptSucceed = 3,    //验证成功
    LYVerifyReceiptFail    = 4,    //验证失败
    LYURLFail              = 5     //未能连接苹果商店
};

/**
 *  当前SDK版本
 */
extern NSString *const LYSDKVersion;
//extern NSString *const LYLoginSuccess;


typedef void (^LYLoginSuccessBlock)(LYUser *user);
typedef void (^LYLogoutBlock)(void);
typedef void (^LYAppleBlock)(LYAppleType lyAppleType);

@interface LYSDK : NSObject


/**
 *  游戏编号
 */
@property (nonatomic, strong, readonly) NSString *lyAppId;

/**
 *  渠道
 */
@property (nonatomic, assign, readonly) LYChannel lyChannel;

/**
 *  游戏密钥
 */
@property (nonatomic, strong, readonly) NSString *lyOpenKey;

/**
 *  登陆成功后当前用户信息
 */
@property (nonatomic, strong, readonly) LYUser *lyCurrUser;


@property (nonatomic, copy) LYLoginSuccessBlock lyLoginSuccessBlock;
@property (nonatomic, copy) LYAppleBlock  lyAppleBlock;
@property (nonatomic, copy) LYLogoutBlock lyLogoutBlock;

/**
 *  获取LYSDK单例
 *  @return LYSDK单例对象
 */
+ (LYSDK *)lySharedSDK;


/**
 *  初始化SDK
 *
 *  @param lyAppId       游戏编号
 *  @param lyOpenKey     游戏密钥
 *  @param lyChannel     游戏渠道
 *  @param trackId       trackId
 *  @param successBlock  成功回调
 *  @param errorBlock    失败回调
 */
- (void)lyInitWithId:(NSString *)lyAppId
             openKey:(NSString *)lyOpenKey
           lyChannel:(LYChannel)lyChannel
             trackId:(NSString *)trackId
             success:(void (^)(void))successBlock
             failure:(void (^)(int errcode, NSString *errorMessage))errorBlock;

/**
 *  用户登录
 */
- (void)lyLogin;


/**
 *  用户中心
 */
- (void)lyUserCenter;


/**
 *  创建API订单
 *  @param lyOrder    订单信息
 */
- (void)lySelect:(LYOrder *)lyOrder;


/**
 *  注销/登出/切换账号
 */
- (void)lyLogout;



@end
