//
//  BlockListViewController.h
//  BlockTimer
//
//  Created by Mac on 8/14/16.
//  Copyright © 2016 VuManhCuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Preset.h"

@interface BlockListViewController : UIViewController
@property(nonatomic) NSString *titleString;
-(id)initWithPreset:(Preset *)preset andManagedContext:(NSManagedObjectContext *)context;
@end
