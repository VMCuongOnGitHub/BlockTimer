//
//  BlockListViewController.m
//  BlockTimer
//
//  Created by Mac on 8/14/16.
//  Copyright © 2016 VuManhCuong. All rights reserved.
//
#import "AppDelegate.h"

#import "BlockListViewController.h"
#import "CreateNewPresetViewController.h"
#import "CreateNewBlockViewController.h"
#import "TimerViewController.h"

#import "BlockListTableViewCell.h"
#import "UIColor+Hex.h"

#import "CoreDataManager.h"
#import "Preset+CoreDataProperties.h"
#import "Block.h"

static NSString *const BlockListTableViewCellIdentifier = @"Block";

@interface BlockListViewController ()<UITableViewDataSource,UITableViewDelegate>
{

}

@property (strong, nonatomic) IBOutlet UIView *buttonView;
@property (strong, nonatomic) IBOutlet UIButton *addNewBlockButton;
@property (strong, nonatomic) IBOutlet UITableView *blockTableView;
@property (strong, nonatomic) IBOutlet UIButton *beginButton;



@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) Block *block;
@property (strong, nonatomic) Preset *preset;
@property (strong, nonatomic) NSMutableArray *blocksInPreset;

@end

@implementation BlockListViewController
@synthesize titleString;
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
    
    self.navigationController.navigationBar.topItem.title = @"Back";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = self.preset.presetName;
    self.addNewBlockButton.backgroundColor = [UIColor colorWithHexString:@"f26a42"];
    self.blockTableView.hidden = YES;
    
    [self.blockTableView registerNib:[UINib nibWithNibName:@"BlockListTableViewCell" bundle:nil] forCellReuseIdentifier:BlockListTableViewCellIdentifier];
    
    [self.blockTableView reloadData];
    

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.blockTableView reloadData];
    
    self.blocksInPreset = [[[CoreDataManager sharedInstance] getAllBlocks] mutableCopy];
    self.blocksInPreset = [[NSMutableArray alloc] initWithArray:[self.preset.blocks allObjects]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.topItem.title = @"Create New Preset";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - TableViewDelegate
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"createdTime" ascending:YES];
            NSArray *sortedArray = [self.blocksInPreset sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
        
            Block *removeBlock = [sortedArray objectAtIndex:indexPath.row];
            [self.blocksInPreset removeObject:removeBlock];
            [self.preset removeBlocksObject:removeBlock];

            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
            if (self.preset.blocks.count > 0) {
                self.buttonView.hidden = YES;
                self.blockTableView.hidden = NO;
            }
            
            if([[CoreDataManager sharedInstance] deleteBlock:removeBlock]){
                [self.blockTableView reloadData];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.preset.blocks.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%li",(long)indexPath.row);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        BlockListTableViewCell *cell = (BlockListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:BlockListTableViewCellIdentifier forIndexPath:indexPath];

        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"createdTime" ascending:YES];
        NSArray *sortedArray = [self.blocksInPreset sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];

        Block *block = (Block *)[sortedArray objectAtIndex:indexPath.row];
        
        cell.blockName.text = block.blockName;
        cell.blockNote.text = block.blockNote;
        cell.time.text = block.blockTimeInterval;


        if (self.preset.blocks.count > 0) {
            self.buttonView.hidden = YES;
            self.blockTableView.hidden = NO;
        }

        return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0;
}
-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 69.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 69)];
    UIButton *createNewBlockFooter = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 69)];
    [createNewBlockFooter setTitle:@"Create New Block" forState:UIControlStateNormal];
    createNewBlockFooter.titleLabel.font = [UIFont fontWithName:@"Avenir Next-Demi Bold" size:15.0];
    createNewBlockFooter.titleLabel.textColor = [UIColor colorWithHexString:@"e75131"];
    UIImage *buttonBackground = [UIImage imageNamed:@"borderbottomGreyBG_03"];
    [createNewBlockFooter setBackgroundImage:buttonBackground forState:UIControlStateNormal];
    [createNewBlockFooter addTarget:self action:@selector(createNewBlockButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];

    [footerView addSubview:createNewBlockFooter];
    return footerView;
}

#pragma mark - Button Action

- (IBAction)createNewBlockButtonDidPress:(id)sender {
    CreateNewBlockViewController *createNewBlockViewController = [[CreateNewBlockViewController alloc] initWithPreset:self.preset andManagedContext:self.managedObjectContext];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:createNewBlockViewController];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}
- (IBAction)beginButtonDidPress:(id)sender {
    TimerViewController *timerViewController = [[TimerViewController alloc] initWithNibName:@"TimerViewController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:timerViewController];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"createdTime" ascending:YES];
    NSArray *sortedArray = [self.preset.blocks sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    timerViewController.blocks = sortedArray;
}
@end
