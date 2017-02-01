//
//  Preset.h
//  BlockTimer
//
//  Created by Mac on 8/18/16.
//  Copyright © 2016 VuManhCuong. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Block;

@interface Preset : NSManagedObject

@property(nonatomic,strong) NSString *presetName;
@property(nonatomic,strong) NSString *reminderTime;
@property(nonatomic) BOOL monday;
@property(nonatomic) BOOL tuesday;
@property(nonatomic) BOOL wednesday;
@property(nonatomic) BOOL thursday;
@property(nonatomic) BOOL friday;
@property(nonatomic) BOOL saturday;
@property(nonatomic) BOOL sunday;

@end
