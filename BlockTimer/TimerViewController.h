//
//  TimerViewController.h
//  BlockTimer
//
//  Created by Cuong on 10/15/16.
//  Copyright © 2016 VuManhCuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZTimerLabel.h"
#import "Block.h"

@interface TimerViewController : UIViewController<MZTimerLabelDelegate>

@property (nonnull,strong)NSArray<Block *> *blocks;

@end
