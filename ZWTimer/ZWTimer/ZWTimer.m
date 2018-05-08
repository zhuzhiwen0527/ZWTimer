//
//  ZWTimer.m
//  ZWTimer
//
//  Created by zzw on 2018/5/7.
//  Copyright © 2018年 zzw. All rights reserved.
//

#import "ZWTimer.h"

@interface ZWTimer ()
@property (nonatomic,weak) id<ZWTimerDelegate> delegate;
@property (nonatomic,strong) dispatch_source_t gcdTimer;
@property (nonatomic,strong) NSTimer * timer;
@end
@implementation ZWTimer
- (void)startTimer:(NSTimeInterval)seconds
          delegate:(id<ZWTimerDelegate>)delegate
           repeats:(BOOL)repeats{
    
    self.delegate = delegate;
    
    
    if (self.timer)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
    //设置定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:seconds
                                                  target:self
                                                selector:@selector(onTimer:)
                                                userInfo:nil
                                                 repeats:repeats];
}
- (void)startGCDTimer:(NSTimeInterval)seconds
             delegate:(id<ZWTimerDelegate>)delegate{
    
    self.delegate = delegate;
    // 获得主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    if (self.gcdTimer) {
        dispatch_cancel(self.gcdTimer);
        self.gcdTimer = nil;
    }
    // 创建一个定时器(dispatch_source_t本质还是个OC对象)
    self.gcdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    uint64_t interval = (uint64_t)(seconds * NSEC_PER_SEC);
    dispatch_source_set_timer(self.gcdTimer, DISPATCH_TIME_NOW, interval, 0);
    
    // 设置回调
    dispatch_source_set_event_handler(self.gcdTimer, ^{
        
        
        // 取消定时器
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(onTimerFired:)]) {
            
            [self.delegate onTimerFired:self];
            
        }else{
            
            dispatch_cancel(self.gcdTimer);
            self.gcdTimer = nil;
        }
        
    });
    
    dispatch_resume(self.gcdTimer);
}
- (void)onTimer: (NSTimer *)timer{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onTimerFired:)]) {
        
        [self.delegate onTimerFired:self];
        
    }else{
        
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)stopTimer{
    
    if (self.gcdTimer) {
        dispatch_cancel(self.gcdTimer);
        self.gcdTimer = nil;
    }
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
- (void)dealloc{
    
    NSLog(@"定时器释放");
    
}
@end
