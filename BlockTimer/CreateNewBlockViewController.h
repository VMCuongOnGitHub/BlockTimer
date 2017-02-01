//
//  CreateNewBlockViewController.h
//  BlockTimer
//
//  Created by Mac on 8/22/16.
//  Copyright © 2016 VuManhCuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Block.h"
#import "Preset.h"


@interface CreateNewBlockViewController : UIViewController
@property (strong) NSManagedObject *block;
-(id)initWithPreset:(Preset *)preset andManagedContext:(NSManagedObjectContext *)context;
@end
