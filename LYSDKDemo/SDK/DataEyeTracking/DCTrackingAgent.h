//
//  DCSdk.h
//  DCSdk
//
//  Created by xqwang on 13-7-8.
//  Copyright (c) 2013年 digitcube. All rights reserved.
//

#import <Foundation/Foundation.h>

//这里提供静态方法
@interface DCTrackingAgent : NSObject

/**
 *  @brief 初始化接口，程序启动时调用
 *
 *  一般在- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions内调用一次即可
 *  !!!一定要调用，否则后面无法上报,只能调用一次
 *  @param appId         在我们网站上创建游戏时分配的appId,用于标识这款游戏. 注意保密!
 *  @param channelId    渠道id , 方便统计分析你在各渠道的推广效果
 */
+ (void)initWithAppId:(NSString *)appId andChannelId:(NSString*)channelId;


/**
 * @brief 设置数据上报间隔时间，该接口需要在onStart接口之前调用，否则无效。如果不调用该接口，SDK默认以1分钟的间隔上报数据
 *
 **/
+(void)setUploadInterval:(unsigned int)time;


/**
 * @brief 设置应用版本号，不调用该接口时SDK默认从配置文件中读取应用版本号
 *
 * @param version 应用版本号
 */
+(void)setVersion:(NSString*)version;

/**
 * @brief 立即上报数据
 **/
+(void)uploadNow;

/**
 * @brief 获取设备ID
 **/
+(NSString*)getUID;

@end


@interface DCTrackingPoint : NSObject

/**
 @brief 广告效果追踪设置有效的效果点
 @param pointId 广告效果点
 @param dictionary 触发时希望传入的属性字典
 **/
+(void)setEffectPoint:(NSString*)pointId propDictionary:(NSDictionary*)dictionary;

/**
 @brief 玩家登陆事件
 @param accountId 玩家账户ID
 **/
+(void)login:(NSString*)accountId;


/**
 @brief 玩家注册事件
 @param accountId 玩家账户ID
 **/
+(void)createAccount:(NSString*)accountId;

/**
 @brief 玩家付费事件
 @param orderId 订单ID
 @param currencyAmount 付费总额
 @param currencyType 货币类型
 @param paymentType 支付途径
 **/
+(void)paymentSuccess:(NSString*)accountId orderId:(NSString*)orderId currencyAmount:(double)currencyAmount currencyType:(NSString*)currencyType paymentType:(NSString*)paymentType;

@end
