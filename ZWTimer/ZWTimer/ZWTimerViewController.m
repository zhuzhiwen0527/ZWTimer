//
//  ZWTimerViewController.m
//  ZWTimer
//
//  Created by zzw on 2018/5/7.
//  Copyright © 2018年 zzw. All rights reserved.
//

#import "ZWTimerViewController.h"
#import "ZWTimer.h"
@interface ZWTimerViewController () <ZWTimerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) ZWTimer * timer;
@property (assign, nonatomic) NSInteger index;
@end

@implementation ZWTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = 0;
    
    self.timer = [[ZWTimer alloc] init];
    //GCDTimer 不受runloop影响
    [self.timer startGCDTimer:1 delegate:self];
    //    NSTimer
    //    [self.timer startTimer:1 delegate:self repeats:YES];
}

- (void)onTimerFired:(ZWTimer *)timer{
    
    self.index ++;
    self.timeLab.text = [NSString stringWithFormat:@"%ld",self.index];
    
}

- (IBAction)dismiss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    if (self.timer) {
        [self.timer stopTimer];
    }
}

-(void)dealloc{
    NSLog(@"控制器释放");
}
@end
