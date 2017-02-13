//
//  TImerViewController.m
//  BlockTimer
//
//  Created by Cuong on 10/15/16.
//  Copyright © 2016 VuManhCuong. All rights reserved.
//

#import "TimerViewController.h"
#import "MZTimerLabel.h"



static NSString *const TimerMidTableViewCellIdentifier = @"TimerMidTableViewCell";
@interface TimerViewController ()<MZTimerLabelDelegate>
{
    MZTimerLabel *new;
    int indexx;
    Block *nee;
}
// Detail timer of blocks
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;

@property (weak, nonatomic) IBOutlet UILabel *blockNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *blockTimeIntervalLabel;

@property (weak, nonatomic) IBOutlet UILabel *blockPercentageLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *blockProgressBar;

// Detail timer of overall preset
@property (weak, nonatomic) IBOutlet UILabel *totalPercentageLabel;

@property (weak, nonatomic) IBOutlet UILabel *elapsedLabel;
@property (weak, nonatomic) IBOutlet UILabel *elapsedTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *remainingLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingTimeLabel;

@property (weak, nonatomic) IBOutlet UIProgressView *totalProgressBar;

@property (weak, nonatomic) IBOutlet UIButton *pauseButton;

// Control buttons
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation TimerViewController
@synthesize blocks;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIBarButtonItem *stopClock = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopClockButtonDidPress:)];
    self.navigationItem.leftBarButtonItem = stopClock;
    
    indexx = 0;
    nee = [self.blocks objectAtIndex:indexx];
    self.titleLabel.text = nee.blockName;
    
    new = [[MZTimerLabel alloc]initWithLabel:self.timerLabel andTimerType:MZTimerLabelTypeTimer];
    [new setCountDownTime:[nee.blockTimeInterval intValue]];
    new.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated{
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    // iPhone4/4S
    if (height == 480) {
        // Detail timer of blocks
        self.titleLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.titleLabel.frame)/1.5];
        self.noteLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.noteLabel.frame)/1.8];
        
        self.blockNumberLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.blockNumberLabel.frame)/2];
        self.timerLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.timerLabel.frame)/1.6];
        self.blockTimeIntervalLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.blockTimeIntervalLabel.frame)/1.7];
        
        self.blockPercentageLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.blockTimeIntervalLabel.frame)/0.7];
        
        // Detail timer of overall preset
        self.totalPercentageLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.totalPercentageLabel.frame)/0.9];
        self.elapsedLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.elapsedLabel.frame)/1.3];
        self.elapsedTimeLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.elapsedTimeLabel.frame)/1.2];
        self.remainingLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.remainingLabel.frame)/1.3];
        self.remainingTimeLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.remainingTimeLabel.frame)/1.2];
    }
    // iPhone5/5S
    else if (height == 568){
        // Detail timer of blocks
        self.titleLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.titleLabel.frame)/1.5];
        self.noteLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.noteLabel.frame)/1.8];
        
        self.blockNumberLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.blockNumberLabel.frame)/2];
        self.timerLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.timerLabel.frame)/1.3];
        self.blockTimeIntervalLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.blockTimeIntervalLabel.frame)/1.7];
        
        self.blockPercentageLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.blockTimeIntervalLabel.frame)/0.7];
        
        // Detail timer of overall preset
        self.totalPercentageLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.totalPercentageLabel.frame)/0.9];
        
        self.elapsedLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.elapsedLabel.frame)/1.3];
        self.elapsedTimeLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.elapsedTimeLabel.frame)/1.2];
        
        self.remainingLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.remainingLabel.frame)/1.3];
        self.remainingTimeLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.remainingTimeLabel.frame)/1.2];
    }
    // iPhone6/7
    else if (height == 667){
        // Detail timer of blocks
        self.titleLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.titleLabel.frame)/1.5];
        self.noteLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.noteLabel.frame)/1.8];
        
        self.blockNumberLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.blockNumberLabel.frame)/2];
        self.timerLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.timerLabel.frame)/1.6];
        self.blockTimeIntervalLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.blockTimeIntervalLabel.frame)/1.7];
        
        self.blockPercentageLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.blockTimeIntervalLabel.frame)/0.7];
        
        // Detail timer of overall preset
        self.totalPercentageLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.totalPercentageLabel.frame)/0.85];
        
        self.elapsedLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.elapsedLabel.frame)/0.99];
        self.elapsedTimeLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.elapsedTimeLabel.frame)/0.89];
        
        self.remainingLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.remainingLabel.frame)/0.99];
        self.remainingTimeLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.remainingTimeLabel.frame)/0.89];
    }
    // iPhone6Plus/7Plus
    else {
        // Detail timer of blocks
        self.titleLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.titleLabel.frame)/1.5];
        self.noteLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.noteLabel.frame)/1.8];
        
        self.blockNumberLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.blockNumberLabel.frame)/2];
        self.timerLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.timerLabel.frame)/1.6];
        self.blockTimeIntervalLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.blockTimeIntervalLabel.frame)/1.7];
        
        self.blockPercentageLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.blockTimeIntervalLabel.frame)/0.7];
        
        // Detail timer of overall preset
        self.totalPercentageLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.totalPercentageLabel.frame)/0.8];
        
        self.elapsedLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.elapsedLabel.frame)/0.9];
        self.elapsedTimeLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.elapsedTimeLabel.frame)/0.8];
        
        self.remainingLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.remainingLabel.frame)/0.9];
        self.remainingTimeLabel.font = [UIFont systemFontOfSize:CGRectGetHeight(self.remainingTimeLabel.frame)/0.8];
    }
}

-(void)timerLabel:(MZTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    if (indexx < self.blocks.count - 1) {
        indexx ++;
        nee = [self.blocks objectAtIndex:indexx];
        self.titleLabel.text = nee.blockName;
        
        new = [[MZTimerLabel alloc]initWithLabel:self.timerLabel andTimerType:MZTimerLabelTypeTimer];
        [new setCountDownTime:[nee.blockTimeInterval intValue]];
        new.delegate = self;
        
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if (![new counting]) {
            [new start];
        }
        
        });
    } else {
        NSLog(@"end"); 
    }
}
- (IBAction)backButtonDidPress:(id)sender {
    if (indexx == 0) {
        NSLog(@"end");
    } else {
        if ([new counting]) {
            [new pause];
            if (![new counting]) {
                indexx--;
                nee = [self.blocks objectAtIndex:indexx];
                self.titleLabel.text = nee.blockName;
                
                new = [[MZTimerLabel alloc]initWithLabel:self.timerLabel andTimerType:MZTimerLabelTypeTimer];
                [new setCountDownTime:[nee.blockTimeInterval intValue]];
                new.delegate = self;
                double delayInSeconds = 1.0;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [new start];
                });
            }
        } else {
            indexx--;
            nee = [self.blocks objectAtIndex:indexx];
            self.titleLabel.text = nee.blockName;
            
            new = [[MZTimerLabel alloc]initWithLabel:self.timerLabel andTimerType:MZTimerLabelTypeTimer];
            [new setCountDownTime:[nee.blockTimeInterval intValue]];
                new.delegate = self;
            double delayInSeconds = 1.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [new start];
            });
        }
    }
}
- (IBAction)nextButtonDidPress:(id)sender {
    if (indexx == self.blocks.count - 1) {
        NSLog(@"end");
    } else {
    if ([new counting]) {
        [new pause];
        if (![new counting]) {
            indexx++;
            nee = [self.blocks objectAtIndex:indexx];
            self.titleLabel.text = nee.blockName;
            
            new = [[MZTimerLabel alloc]initWithLabel:self.timerLabel andTimerType:MZTimerLabelTypeTimer];
            [new setCountDownTime:[nee.blockTimeInterval intValue]];
            new.delegate = self;
            double delayInSeconds = 1.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [new start];
            });
        }
    } else {
        indexx++;
        nee = [self.blocks objectAtIndex:indexx];
        self.titleLabel.text = nee.blockName;
        
        new = [[MZTimerLabel alloc]initWithLabel:self.timerLabel andTimerType:MZTimerLabelTypeTimer];
        [new setCountDownTime:[nee.blockTimeInterval intValue]];
        new.delegate = self;
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [new start];
        });
    }
    }
}
- (IBAction)pauseButtonDidPress:(id)sender {
    if ([new counting]) {
        [new pause];
    } else {
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [new start];
        });
    }

}
- (IBAction)stopButtonDidPress:(id)sender {
}
-(IBAction)stopClockButtonDidPress:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
