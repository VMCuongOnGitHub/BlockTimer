//
//  PresetTimerListViewController.h
//  BlockTimer
//
//  Created by Mac on 8/20/16.
//  Copyright © 2016 VuManhCuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Preset.h"
@interface PresetTimerListViewController : UIViewController
-(id)initWithPreset:(Preset *)preset andManagedContext:(NSManagedObjectContext *)context;
@end
