//
//  DDProxy.m
//  TimerDemo
//
//  Created by Meet on 2021/6/9.
//

#import "DDProxy.h"

@interface DDProxy()
@property (weak, nonatomic) id target;
@end

@implementation DDProxy
+ (instancetype)proxyWithTarget:(id)target {
    DDProxy *proxy = [DDProxy alloc];
    proxy.target = target;
    return  proxy;
}

// 以下还是运用消息转发机制进行
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

-(void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}
@end
