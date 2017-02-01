//
//  Preset+CoreDataProperties.h
//  
//
//  Created by Cuong on 11/4/16.
//
//

#import "Preset.h"
#import "Block.h"


NS_ASSUME_NONNULL_BEGIN

@interface Preset (CoreDataProperties)

+ (NSFetchRequest *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *friday;
@property (nullable, nonatomic, copy) NSNumber *monday;
@property (nullable, nonatomic, copy) NSString *presetName;
@property (nullable, nonatomic, copy) NSString *reminderTime;
@property (nullable, nonatomic, copy) NSString *restTime;
@property (nullable, nonatomic, copy) NSNumber *saturday;
@property (nullable, nonatomic, copy) NSNumber *sunday;
@property (nullable, nonatomic, copy) NSNumber *thursday;
@property (nullable, nonatomic, copy) NSNumber *tuesday;
@property (nullable, nonatomic, copy) NSNumber *wednesday;
@property (nullable, nonatomic, retain) NSSet<Block *> *blocks;


@end

@interface Preset (CoreDataGeneratedAccessors)

- (void)addBlocksObject:(NSManagedObject *)value;
- (void)removeBlocksObject:(NSManagedObject *)value;
- (void)addBlocks:(NSSet<NSManagedObject *> *)values;
- (void)removeBlocks:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
