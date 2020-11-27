//
//  OCTokenConfigure.m
//  OCTokenSDK
//
//  Created by zy on 2020/10/15.
//

#import "OCTokenConfigure.h"

@implementation OCTokenConfigure

static OCTokenConfigure *_configure;

+ (instancetype)sharedConfigure{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _configure = [[self alloc] init];
    });
    
    return _configure;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _configure = [super allocWithZone:zone];
    });
    return _configure;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _configure;
}

@end
