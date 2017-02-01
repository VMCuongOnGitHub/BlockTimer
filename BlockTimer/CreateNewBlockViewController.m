//
//  CreateNewBlockViewController.m
//  BlockTimer
//
//  Created by Mac on 8/22/16.
//  Copyright © 2016 VuManhCuong. All rights reserved.
//

#import "CreateNewBlockViewController.h"
#import "UIColor+Hex.h"
#import "IQKeyboardManager.h"

#import "AppDelegate.h"
#import "Block.h"
#import "Preset.h"
#import "Preset+CoreDataProperties.h"

@interface CreateNewBlockViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UITapGestureRecognizer *_tapGesture;
    
    NSMutableArray *hoursArray;
    NSMutableArray *minsArray;
    NSMutableArray *secsArray;
    
    NSString *interval;
}
@property (strong, nonatomic) IBOutlet UITextField *blockNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *blockNoteTexField;

@property (strong, nonatomic) IBOutlet UILabel *timeIntervalTitle;
@property (strong, nonatomic) IBOutlet UIPickerView *blockTimerPickerView;

@property (strong, nonatomic) IBOutlet UIButton *addBlockButton;

@property(retain, nonatomic) NSMutableArray *hoursArray;
@property(retain, nonatomic) NSMutableArray *minsArray;
@property(retain, nonatomic) NSMutableArray *secsArray;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) Preset *preset;

@end

@implementation CreateNewBlockViewController

@synthesize hoursArray;
@synthesize minsArray;
@synthesize secsArray;

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(void)handleGestureRecognizers:(UITapGestureRecognizer *)tapGusture{
    
    [self.view endEditing:YES];
    
}
-(void)initObject{
    
    _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleGestureRecognizers:)];
    [self.view addGestureRecognizer:_tapGesture];
    
}
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



-(void)setUpUI{
    self.timeIntervalTitle.textColor = [UIColor colorWithHexString:@"f26a42"];
    
    self.blockTimerPickerView.showsSelectionIndicator = YES;
    self.blockTimerPickerView.delegate = self;
    self.blockTimerPickerView.dataSource = self;
    //initialize arrays
    hoursArray = [[NSMutableArray alloc] init];
    minsArray = [[NSMutableArray alloc] init];
    secsArray = [[NSMutableArray alloc] init];
    NSString *strVal = [[NSString alloc] init];
    
    for(int i=0; i<61; i++)
    {
        strVal = [NSString stringWithFormat:@"%d", i];
        
        //NSLog(@"strVal: %@", strVal);
        
        //Create array with 0-12 hours
        if (i < 13)
        {
            [hoursArray addObject:strVal];
        }
        
        //create arrays with 0-60 secs/mins
        [minsArray addObject:strVal];
        [secsArray addObject:strVal];
    }

    


}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self initObject];

    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent :(NSInteger)component
{
    if (component==0)
    {
        return [hoursArray count];
    }
    else if (component==1)
    {
        return [minsArray count];
    }
    else
    {
        return [secsArray count];
    }
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    switch (component)
    {
        case 0:
            return [hoursArray objectAtIndex:row];
            break;
        case 1:
            return [minsArray objectAtIndex:row];
            break;
        case 2:
            return [secsArray objectAtIndex:row];
            break;
    }
    return nil;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *hoursStr = [NSString stringWithFormat:@"%@",[hoursArray objectAtIndex:[self.blockTimerPickerView selectedRowInComponent:0]]];
    
    NSString *minsStr = [NSString stringWithFormat:@"%@",[minsArray objectAtIndex:[self.blockTimerPickerView selectedRowInComponent:1]]];
    
    NSString *secsStr = [NSString stringWithFormat:@"%@",[secsArray objectAtIndex:[self.blockTimerPickerView selectedRowInComponent:2]]];
    
    int hoursInt = [hoursStr intValue];
    int minsInt = [minsStr intValue];
    int secsInt = [secsStr intValue];
    
    
    interval = [NSString stringWithFormat:@"%d",secsInt + (minsInt*60) + (hoursInt*3600)];
    
    NSLog(@"hours: %d ... mins: %d .... sec: %d .... interval: %@", hoursInt, minsInt, secsInt, interval);
    
    //    NSString *totalTimeStr = [NSString stringWithFormat:@"%f",interval];

}

- (IBAction)addBlockButtonDidPress:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSDate *currentTime = [NSDate date];
    
    
    
//    if (self.block) {
//        // Update existing device
//        [self.block setValue:self.blockNameTextField.text forKey:@"blockTitle"];
//        [self.block setValue:self.blockNoteTexField.text forKey:@"blockNote"];
//        [self.block setValue:interval forKey:@"blockTimeInterval"];
//        
//    } else {
//        // Create a new device
//        NSManagedObject *newBlock = [NSEntityDescription insertNewObjectForEntityForName:@"Block" inManagedObjectContext:context];
//        [newBlock setValue:self.blockNameTextField.text forKey:@"blockTitle"];
//        [newBlock setValue:self.blockNoteTexField.text forKey:@"blockNote"];
//        [newBlock setValue:interval forKey:@"blockTimeInterval"];
//    }
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    NSEntityDescription *blockEntityDescription = [NSEntityDescription entityForName:@"Block" inManagedObjectContext:managedObjectContext];
    Block *newBlock = (Block *)[[NSManagedObject alloc] initWithEntity:blockEntityDescription
                                           insertIntoManagedObjectContext:self.managedObjectContext];
    
    [newBlock setValue:self.blockNameTextField.text forKey:@"blockName"];
    [newBlock setValue:self.blockNoteTexField.text forKey:@"blockNote"];
    [newBlock setValue:interval forKey:@"blockTimeInterval"];
    [newBlock setValue:currentTime forKey:@"createdTime"];


    
    [self.preset addBlocksObject:newBlock];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
