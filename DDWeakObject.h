//
//  DDWeakObject.h
//  TimerDemo
//
//  Created by Meet on 2021/6/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDWeakObject : NSObject

/// 创建一个过渡类 让NSTimer 或者  CADisplayLink 对这个类产生弱引用 解决循环引用的问题
/// @param target 产生循环引用的target
+ (instancetype)weakObjectWithTarget:(id)target;
@end

NS_ASSUME_NONNULL_END
