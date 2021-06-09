//
//  DDProxy.h
//  TimerDemo
//
//  Created by Meet on 2021/6/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDProxy : NSProxy
+ (instancetype)proxyWithTarget:(id)target;
@end

NS_ASSUME_NONNULL_END
