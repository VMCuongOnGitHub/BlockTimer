
#import "CoreDataManager.h"
#import "AppDelegate.h"

@implementation CoreDataManager

+ (instancetype)sharedInstance{
    static CoreDataManager *_sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _sharedInstance = [[CoreDataManager alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
        self.context = managedObjectContext;
    }
    return self;
}

- (NSArray *)getAllPresets {
    NSArray<Preset *> *presets = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Preset"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"presetName" ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    NSFetchedResultsController *fetchResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.context sectionNameKeyPath:nil cacheName:nil];
    [fetchResultController performFetch:nil];
    presets = fetchResultController.fetchedObjects;
    
    return presets;
}
- (BOOL)savePreset:(Preset *)preset{
    return [self.context save:nil];
}
- (BOOL)deletePreset:(Preset *)preset{
    [self.context deleteObject:preset];
    return [self.context save:nil];
}
- (BOOL)updatePreset:(Preset *)preset
{
    return YES;
}
// Block
- (NSArray *)getAllBlocks {
    NSArray<Block *> *blocks = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Block"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"createdTime" ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    NSFetchedResultsController *fetchResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.context sectionNameKeyPath:nil cacheName:nil];
    [fetchResultController performFetch:nil];
    blocks = fetchResultController.fetchedObjects;
    return blocks;
}
- (Block *)getBlockByID:(NSString *)blockID{
    NSArray<Block *> *blocks   = nil;
    NSFetchRequest *fetchRequest     = [[NSFetchRequest alloc] initWithEntityName:@"Block"];
    NSFetchedResultsController *fetchResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.context sectionNameKeyPath:nil cacheName:nil];
    [fetchResultController performFetch:nil];
    blocks = fetchResultController.fetchedObjects;
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"blockID == %@",blockID];
    return [[blocks filteredArrayUsingPredicate:pre] firstObject];
}
- (BOOL)saveBlock:(Block *)block
{
    return [self.context save:nil];
}
- (BOOL)deleteBlock:(Block *)block
{
    [self.context deleteObject:block];
    return [self.context save:nil];
}
- (BOOL)updateBlock:(Block *)block
{
    return YES;
}
@end
