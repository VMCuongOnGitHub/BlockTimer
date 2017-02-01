//
//  PresetTimerListTableViewCell.h
//  BlockTimer
//
//  Created by Mac on 8/20/16.
//  Copyright © 2016 VuManhCuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"

@interface PresetTimerListTableViewCell : MGSwipeTableCell

@property (strong, nonatomic) IBOutlet UILabel *presetNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *presetTimeIntervalLabel;

@end
