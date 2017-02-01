//
//  PresetTimerListTableViewCell.m
//  BlockTimer
//
//  Created by Mac on 8/20/16.
//  Copyright © 2016 VuManhCuong. All rights reserved.
//

#import "PresetTimerListTableViewCell.h"
#import "UIColor+Hex.h"
@implementation PresetTimerListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.presetNameLabel.textColor = [UIColor colorWithHexString:@"f26a42"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
