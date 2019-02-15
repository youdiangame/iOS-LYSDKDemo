//
//  LYUser.h
//  LYSDK
//
//  Created by Seven on 2018/12/19.
//  Copyright © 2018 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYUser : NSObject

/**
 *  用户ID
 */
@property (nonatomic, assign) long lyUserId;

/**
 *  用户名
 */
@property (nonatomic, strong) NSString *lyUsername;

/**
 *  用户手机号
 */
@property (nonatomic, strong) NSString *lyPhone;





@end

NS_ASSUME_NONNULL_END
