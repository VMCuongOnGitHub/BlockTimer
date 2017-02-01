//
//  BlockListTableViewCell.h
//  BlockTimer
//
//  Created by Mac on 10/6/16.
//  Copyright © 2016 VuManhCuong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *blockName;
@property (strong, nonatomic) IBOutlet UILabel *blockNote;
@property (strong, nonatomic) IBOutlet UILabel *time;

@end
