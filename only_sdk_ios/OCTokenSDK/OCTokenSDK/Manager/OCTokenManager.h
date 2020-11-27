//
//  OCTokenManager.h
//  OCTokenSDK
//
//  Created by zy on 2020/10/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    OCTokenAuthorizationStatusSuccess = 0,
    OCTokenAuthorizationStatusFail = (1<<0),
    OCTokenAuthorizationStatusCancel = (1<<1),
} OCTokenAuthorizationStatus;

typedef void (^OCTokenAuthCompletion)(OCTokenAuthorizationStatus resCode, id resInfo);

@interface OCTokenManager : NSObject

/** 初始化
 @param scheme  定义的ULR scheme
 @param appName  app名字
 @param address  公网钱包地址
 */
+ (void)initWithAppScheme:(NSString *)scheme andAppName:(NSString *)appName andAppAddress:(NSString *)address;

/** 开始授权
*/
+ (void)startOAuth;

/**
 开始充值
 @param orderNum     订单号
 @param amount  充值金额
*/
+ (void)startRechargeWithChargeAmount:(float)amount andOrderNum:(NSString *)orderNum;

/**
 开始提现
 @param addrress 提现钱包地址
*/
+ (void)startWithdrawWithTargetWallet:(NSString *)addrress;

/** 统一回调处理
 @param url  回调URL
 @param completion 回调处理结果  resInfo数据 OAuth: @{@"token":@"",@"walletAddress":@""}  Recharge: @{@"action":@""}
*/
+ (void)OAuthCallBackByURL:(NSString *)url
               completion:(OCTokenAuthCompletion)completion;

@end

NS_ASSUME_NONNULL_END
