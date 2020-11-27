//
//  OCTokenConfigure.h
//  OCTokenSDK
//
//  Created by zy on 2020/10/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OCTokenConfigure : NSObject

@property(nonatomic, copy) NSString *address;
@property(nonatomic, copy) NSString *token;
@property(nonatomic, copy) NSString *scheme;
@property(nonatomic, copy) NSString *appName;

+ (instancetype)sharedConfigure;

@end

NS_ASSUME_NONNULL_END
