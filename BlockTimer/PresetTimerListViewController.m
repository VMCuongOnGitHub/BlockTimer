//
//  PresetTimerListViewController.m
//  BlockTimer
//
//  Created by Mac on 8/20/16.
//  Copyright © 2016 VuManhCuong. All rights reserved.
//

#import "PresetTimerListViewController.h"
#import "PresetTimerListTableViewCell.h"
#import "CreateNewPresetViewController.h"
#import "BlockListViewController.h"
#import "AppDelegate.h"
#import <MGSwipeTableCell.h>

#import "Preset.h"
#import "CoreDataManager.h"

static NSString *const TableViewCellIdentifier = @"TableViewCellIdentifier";
@interface PresetTimerListViewController ()<UITableViewDelegate,UITableViewDataSource,MGSwipeTableCellDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSMutableArray *presets;
@property (strong, nonatomic) Preset *preset;

@end

@implementation PresetTimerListViewController

-(id)initWithPreset:(Preset *)preset andManagedContext:(NSManagedObjectContext *)context
{
    self = [super init];
    if (self)
    {
        self.managedObjectContext = context;
        self.preset = preset;
    }
    return self;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"Preset List";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    /* Create left button item. */
    UIBarButtonItem *createNewPresetButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewPresetButtonDidPress:)];
    self.navigationItem.rightBarButtonItem = createNewPresetButton;

    [self.tableView registerNib:[UINib nibWithNibName:@"PresetTimerListTableViewCell" bundle:nil] forCellReuseIdentifier:TableViewCellIdentifier];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.presets = [[[CoreDataManager sharedInstance] getAllPresets] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - Table View
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Preset *removedPreset = [self.presets objectAtIndex:indexPath.row];
        [self.presets removeObject:removedPreset];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        if([[CoreDataManager sharedInstance] deletePreset:removedPreset]){
            [self.tableView reloadData];
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Preset *preset = (Preset *)[self.presets objectAtIndex:indexPath.row];
    BlockListViewController *blockListViewController = [[BlockListViewController alloc] initWithPreset:preset andManagedContext:self.managedObjectContext];
    [self.navigationController pushViewController:blockListViewController animated:YES];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.presets.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    PresetTimerListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier forIndexPath:indexPath];
    
    Preset *preset = (Preset *)[self.presets objectAtIndex:indexPath.row];
    cell.presetNameLabel.text = preset.presetName;
    cell.presetTimeIntervalLabel.text = @"Totall Time";
    
    cell.leftButtons = @[[MGSwipeButton buttonWithTitle:@"Edit" backgroundColor:[UIColor greenColor]callback:^BOOL(MGSwipeTableCell *sender) {
        NSLog(@"Yes %@",[preset valueForKey:@"presetName"]);
        Preset *selectedPreset = [self.presets objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        CreateNewPresetViewController *createNewPresetViewController = [[CreateNewPresetViewController alloc] initWithPreset:selectedPreset andManagedContext:self.managedObjectContext];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:createNewPresetViewController];
        [self.navigationController presentViewController:navController animated:YES completion:nil];
        return YES;
    }]];
    cell.leftSwipeSettings.transition = MGSwipeTransitionDrag;
    
    return cell;
}

#pragma mark - Action
- (IBAction)createNewPresetButtonDidPress:(id)sender
{
    CreateNewPresetViewController *createNewPresetViewController = [[CreateNewPresetViewController alloc] initWithNibName:@"CreateNewPresetViewController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:createNewPresetViewController];
    [self.navigationController presentViewController:navController animated:YES completion:nil];

}




@end
