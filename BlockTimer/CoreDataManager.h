

#import <Foundation/Foundation.h>
#import "Preset.h"
#import "Block.h"

@interface CoreDataManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) NSManagedObjectContext *context;

- (NSArray *)getAllPresets;
- (BOOL)savePreset:(Preset *)preset;
- (BOOL)deletePreset:(Preset *)preset;
- (BOOL)updatePreset:(Preset *)preset;
// Block
- (NSArray *)getAllBlocks;
- (Block *)getBlockByID:(NSString*) blockID;
- (BOOL)saveBlock:(Block *)block;
- (BOOL)deleteBlock:(Block *)block;
- (BOOL)updateBlock:(Block *)block;
@end
