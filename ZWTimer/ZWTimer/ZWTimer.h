//
//  ZWTimer.h
//  ZWTimer
//
//  Created by zzw on 2018/5/7.
//  Copyright © 2018年 zzw. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZWTimer;
@protocol ZWTimerDelegate <NSObject>
@required
- (void)onTimerFired:(ZWTimer*)timer;
@end
@interface ZWTimer : NSObject

- (void)startTimer:(NSTimeInterval)seconds
          delegate:(id<ZWTimerDelegate>)delegate
           repeats:(BOOL)repeats;

- (void)startGCDTimer:(NSTimeInterval)seconds
             delegate:(id<ZWTimerDelegate>)delegate;

- (void)stopTimer;


@end
