//
//  DDWeakObject.m
//  TimerDemo
//
//  Created by Meet on 2021/6/9.
//

#import "DDWeakObject.h"

@interface DDWeakObject()
@property (weak, nonatomic) id target;
@end

@implementation DDWeakObject
+(instancetype)weakObjectWithTarget:(id)target {
    DDWeakObject *weakObject = [[DDWeakObject alloc] init];
    weakObject.target = target;
    return weakObject;
}

// 利用消息转发机制 让这个类调用 target 的 方法
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.target;
}

@end
