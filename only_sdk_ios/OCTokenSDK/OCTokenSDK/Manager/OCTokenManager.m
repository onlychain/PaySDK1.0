//
//  OCTokenManager.m
//  OCTokenSDK
//
//  Created by zy on 2020/10/14.
//

#import "OCTokenManager.h"
#import "OCTokenConfigure.h"
#import <UIKit/UIKit.h>

@implementation OCTokenManager

/** 初始化
 @param scheme  定义的ULR scheme
 @param appName  app名字
 @param address  公网钱包地址
 */
+ (void)initWithAppScheme:(NSString *)scheme andAppName:(NSString *)appName andAppAddress:(NSString *)address;{
    OCTokenConfigure *configure = [OCTokenConfigure sharedConfigure];
    configure.scheme = scheme;
    configure.appName = appName;
    configure.address = address;
}

/** 开始授权
*/
+ (void)startOAuth{
    OCTokenConfigure *configure = [OCTokenConfigure sharedConfigure];
    NSDictionary *dict = @{@"scheme":configure.scheme,@"appName":configure.appName};
    NSString * jsonStr = [OCTokenManager stringFromDict:dict];
    NSString *data = [OCTokenManager base64Encoding:jsonStr];
    NSURL *url = [NSURL URLWithString:[@"OCToken://OAuth" stringByAppendingFormat:@"?data=%@", data]];
    [OCTokenManager openURL:url];
}

/**
 开始充值
 @param orderNum     订单号
 @param amount  充值金额
*/
+ (void)startRechargeWithChargeAmount:(float)amount andOrderNum:(NSString *)orderNum{
    NSDictionary *dict = @{@"scheme":[OCTokenConfigure sharedConfigure].scheme,@"address":[OCTokenConfigure sharedConfigure].address,@"amount":[NSString stringWithFormat:@"%f",amount],@"orderNum":orderNum,@"appName":[OCTokenConfigure sharedConfigure].appName};
    NSString * jsonStr = [OCTokenManager stringFromDict:dict];
    NSString *data = [OCTokenManager base64Encoding:jsonStr];
    NSURL *url = [NSURL URLWithString:[@"OCToken://Recharge" stringByAppendingFormat:@"?data=%@", data]];
    [OCTokenManager openURL:url];
}

/**
 开始提现
 @param addrress 提现钱包地址
*/
+ (void)startWithdrawWithTargetWallet:(NSString *)addrress{
    NSDictionary *dict = @{@"scheme":[OCTokenConfigure sharedConfigure].scheme,@"withdrawAddress":addrress,@"appName":[OCTokenConfigure sharedConfigure].appName};
    NSString * jsonStr = [OCTokenManager stringFromDict:dict];
    NSString *data = [OCTokenManager base64Encoding:jsonStr];
    NSURL *url = [NSURL URLWithString:[@"OCToken://Withdraw" stringByAppendingFormat:@"?data=%@", data]];
    [OCTokenManager openURL:url];
}

/** 统一回调处理
 @param url  回调URL
 @param completion 回调处理结果
*/
+ (void)OAuthCallBackByURL:(NSString *)url
               completion:(OCTokenAuthCompletion)completion{
    NSString *base64Str = [url componentsSeparatedByString:@"?data="][1];
    NSString *jsonStr = [OCTokenManager base64Decoding:base64Str];
    NSDictionary *dict = [OCTokenManager dictFormJson:jsonStr];
    NSString *status = dict[@"status"];
    
    if ([status isEqualToString:@"0"]) {
        
        id resInfo;
        if ([url containsString:@"OAuth"]) {
            
            resInfo = @{@"name":dict[@"name"],@"address":dict[@"address"],@"publickey":dict[@"publickey"],@"sign":dict[@"sign"],@"timeStamp":dict[@"timeStamp"]};
            
        }
        if ([url containsString:@"Recharge"]) {
            resInfo = @{@"action":dict[@"action"]};
        }
        if ([url containsString:@"Withdraw"]) {
            resInfo = @{};
        }
        
        if (completion) {
            completion(OCTokenAuthorizationStatusSuccess,resInfo);
        }
        
    }else if ([status isEqualToString:@"1"]) {
        if (completion) {
            completion(OCTokenAuthorizationStatusFail,@"");
        }
    }else{
        if (completion) {
            completion(OCTokenAuthorizationStatusCancel,@"");
        }
        
    }
    
}


+ (void)openURL:(NSURL *)url{
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }else{
        NSLog(@"尚未安装应用");
        url = [NSURL URLWithString:@"https://godsign.app/zY7Iq3"];
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}


+ (NSString *)stringFromDict:(NSDictionary *)dict{
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString * jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}

+ (NSDictionary *)dictFormJson:(NSString *)json{
    NSError * error = nil;
    NSData * getJsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * getDict = [NSJSONSerialization JSONObjectWithData:getJsonData options:NSJSONReadingMutableContainers error:&error];
    return getDict;
}

/**
 *  编码
 */
+ (NSString *)base64Encoding:(NSString *)plainString{
    NSData *plainData = [plainString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainData base64EncodedStringWithOptions:0];
    return base64String;
}

/**
 *   解码
 */
+ (NSString *)base64Decoding:(NSString *)encodedString{
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:encodedString options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    return decodedString;
}

@end
