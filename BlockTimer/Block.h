//
//  Block.h
//  BlockTimer
//
//  Created by Mac on 10/4/16.
//  Copyright © 2016 VuManhCuong. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Block : NSManagedObject

@property(nonatomic,strong) NSString *blockName;
@property(nonatomic,strong) NSString *blockNote;
@property(nonatomic,strong) NSString *blockTimeInterval;
@property(nonatomic,strong) NSDate *createdTime;
@end
