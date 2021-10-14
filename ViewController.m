//
//  ViewController.m
//  TimerDemo
//
//  Created by Meet on 2021/6/9.
//

#import "ViewController.h"
#import "DDWeakObject.h"
#import "DDProxy.h"

@interface ViewController ()
// self 对 link 强引用
@property (nonatomic, strong) CADisplayLink *link;

// self 对 timer 强引用
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 这里可以调用下方的方法测试
    
    [self executeLinkResolveRecycleByNSProxy];
}

#pragma mark -------------------- NSTimer 循环引用
/// timer循环引用
- (void)executeTimerRecycle {
    // 由于 当前VC强引用了 timer
    // timer 又对 target 强引用  这里的target 就是 self
    // 所以会造成循环引用 当点击返回的时候 控制器就不会销毁了
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(test) userInfo:nil repeats:YES];
}

#pragma mark -------------------- NSTimer Block解决循环引用
/// block 解决 timer循环引用
- (void)executeTimerResolveRecycleByBlock {
    // 让 timer 对self 产生弱引用
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakSelf test];
    }];
}

#pragma mark -------------------- NSTimer 自定义对象解决循环引用
/// 自定义weakObject 解决 timer循环引用
- (void)executeTimerResolveRecycleByWeakObject {
    // 当前VC强引用了 timer
    // timer 对 weakObject 强引用
    // 但是 weakObject 对 self 是弱引用的关系
    // 因此不会产生循环引用
    DDWeakObject *weakObject = [DDWeakObject weakObjectWithTarget:self];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakObject selector:@selector(test) userInfo:nil repeats:YES];
}

#pragma mark -------------------- NSTimer Block解决循环引用
/// 自定义NSProxy 解决 timer循环引用
- (void)executeTimerResolveRecycleByNSProxy {
    // 当前VC强引用了 timer
    // timer 对 proxy 强引用
    // 但是 proxy 对 self 是弱引用的关系
    // 因此不会产生循环引用
    DDProxy *proxy = [DDProxy proxyWithTarget:self];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:proxy selector:@selector(test) userInfo:nil repeats:YES];
}


#pragma mark -------------------- CADisplayLink 循环引用
/// CADisplayLink循环引用
- (void)executeLinkRecycle {
    // 由于 当前VC强引用了 link
    // link 又对 target 强引用  这里的target 就是 self
    // 所以会造成循环引用 当点击返回的时候 控制器就不会销毁了
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(test)];
    [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark -------------------- CADisplayLink 使用自定义三方类解决循环引用
/// 使用自定义三方类解决CADisplayLink循环引用
- (void)executeLinkResolveRecycleByWeakObject {
    // 由于 当前VC强引用了 link
    // link 对 weakObject 强引用
    // 但是 weakObject 对 self 是弱引用的关系
    // 因此不会产生循环引用
    self.link = [CADisplayLink displayLinkWithTarget:[DDWeakObject weakObjectWithTarget:self] selector:@selector(test)];
    [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark -------------------- CADisplayLink 使用NSProxy解决循环引用
/// 使用NSProxy解决CADisplayLink循环引用
- (void)executeLinkResolveRecycleByNSProxy {
    // 由于 当前VC强引用了 link
    // link 对 proxy 强引用
    // 但是 proxy 对 self 是弱引用的关系
    // 因此不会产生循环引用
    self.link = [CADisplayLink displayLinkWithTarget:[DDProxy proxyWithTarget:self] selector:@selector(test)];
    [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}


- (void)test {
    
    NSLog(@"%s", __func__);
}

- (void)dealloc {
    
    if (self.link) {
        [self.link invalidate];
        self.link = nil;
    }
    
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    NSLog(@"控制器销毁了");
}
@end
