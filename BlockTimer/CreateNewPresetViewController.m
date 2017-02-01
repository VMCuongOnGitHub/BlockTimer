//
//  CreateNewPresetViewController.m
//  BlockTimer
//
//  Created by Mac on 8/5/16.
//  Copyright © 2016 VuManhCuong. All rights reserved.
//

#import "CreateNewPresetViewController.h"
#import "BlockListViewController.h"
#import "PresetTimerListViewController.h"
#import "Preset.h"
#import "CoreDataManager.h"
#import "AppDelegate.h"
#import "AppHelper.h"
#import "UIColor+Hex.h"
#import "IQKeyboardManager.h"

@interface CreateNewPresetViewController () <UITextFieldDelegate>
{
    UITapGestureRecognizer *_tapGesture;
    UITextField *_activeTextField;
    
    NSArray *_restTimeArray;
    NSArray *_restTimeTypeArray;
    
    NSMutableArray *minsArray;
    NSMutableArray *secsArray;
    
    NSString *restTimeIntervalString;
    int sum;
    NSString *minutesString;
    NSString *secondsString;
    
}
@property (strong, nonatomic) IBOutlet UITextField *presetTitleTextField;

@property (strong, nonatomic) IBOutlet UILabel *reminderLabel;
@property (strong, nonatomic) IBOutlet UITextField *reminderTextField;

@property (strong, nonatomic) IBOutlet UILabel *selectDayLabel;

@property (strong, nonatomic) IBOutlet UIDatePicker *reminderPickerView;

@property (strong, nonatomic) IBOutlet UIButton *mondayButton;
@property (nonatomic) BOOL mondayIsPick;
@property (strong, nonatomic) IBOutlet UIButton *tuesdayButton;
@property (nonatomic) BOOL tuesdayIsPick;
@property (strong, nonatomic) IBOutlet UIButton *wednesdayButton;
@property (nonatomic) BOOL wednesdayIsPick;
@property (strong, nonatomic) IBOutlet UIButton *thursdayButton;
@property (nonatomic) BOOL thursdayIsPick;
@property (strong, nonatomic) IBOutlet UIButton *fridayButton;
@property (nonatomic) BOOL fridayIsPick;
@property (strong, nonatomic) IBOutlet UIButton *saturdayButton;
@property (nonatomic) BOOL saturdayIsPick;
@property (strong, nonatomic) IBOutlet UIButton *sundayButton;
@property (nonatomic) BOOL sundayIsPick;


@property (strong, nonatomic) IBOutlet UIButton *saveAndNextButton;

@property(retain, nonatomic) NSMutableArray *minsArray;
@property(retain, nonatomic) NSMutableArray *secsArray;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) Preset *preset;

@end

@implementation CreateNewPresetViewController

@synthesize minsArray;
@synthesize secsArray;

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

-(void)handleGestureRecognizers:(UITapGestureRecognizer *)tapGusture{
    
    [self.view endEditing:YES];
    
}
-(void)initObject{
    
    _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleGestureRecognizers:)];
    [self.view addGestureRecognizer:_tapGesture];
    
}
- (void)setupUI{
    
    /************* Config *************/
    
    
    /************* Decorate View *************/
    // Preset Title
    
    // rest-time
    
    // rest-time Hours Seconds Label
    
    // Reminder
    
    // Select Day
    //    self.selectDayLabel.textColor = [UIColor colorWithHexString:@"f26a42"];
    
    // Save And Next Button
    self.saveAndNextButton.backgroundColor = [UIColor colorWithHexString:@"f26a42"];
    self.saveAndNextButton.tintColor = [UIColor whiteColor];
    [self.saveAndNextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // Day of Week
    
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initObject];
    [self setupUI];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.presetTitleTextField becomeFirstResponder];
    self.navigationItem.title = @"Create New Preset";
    
    // rest-time Picker View
    
    // Initialize Timer Arrays
    
    // Reminder Picker View
    self.reminderPickerView.datePickerMode = UIDatePickerModeTime;
    self.reminderTextField.inputView = self.reminderPickerView;
    [self.reminderPickerView addTarget:self action:@selector(reminderDidChange:) forControlEvents:UIControlEventValueChanged];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonDidPress:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    if (self.preset) {
        [self.presetTitleTextField setText:[self.preset valueForKey:@"presetName"]];
        [self.reminderTextField setText:[self.preset valueForKey:@"reminderTime"]];
    }
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

#pragma mark - TextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.presetTitleTextField) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - PickerView


-(void)reminderDidChange:(UIDatePicker*)reminderPickerView
{
    self.reminderTextField.text = [self dateStringFromDate:reminderPickerView.date];
}

-(NSString*)dateStringFromDate:(NSDate*)date
{
    NSDateFormatter *formater = [NSDateFormatter new];
    [formater setDateFormat:@"HH : mm : a"];
    
    NSString *reminderString = [formater stringFromDate:date];
    //    self.reminderTextField.text = reminderString;
    return reminderString;
}
#pragma mark - Other Function

#pragma mark - Action Button
- (IBAction)cancelButtonDidPress:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)saveAndNexttButtonDidPress:(id)sender {
    
    NSString *presetName = self.presetTitleTextField.text;
    NSString *reminderTime = self.reminderTextField.text;
    
    if (presetName.length==0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Block Timer" message:@"Please give preset a name" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
        [alertView show];
        [self.presetTitleTextField becomeFirstResponder];
    } else {
        // Fetch all the data that exist
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Preset"];
        [request setPredicate:[NSPredicate predicateWithFormat:@"presetName = %@", presetName]];
        [request setFetchLimit:1];
        NSError *error = nil;
        NSUInteger count = [managedObjectContext countForFetchRequest:request error:&error];
        if (count == NSNotFound){
            NSLog(@"error");
            
        }
        // Not find any existed data then save the data
        else if (count == 0){
            if (self.preset) {
                // Update existing preset
                
                [self.preset setValue:presetName forKey:@"presetName"];
                [self.preset setValue:reminderTime forKey:@"reminderTime"];
                
            }else{
                AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
                
                Preset *newPreset = (Preset *)[NSEntityDescription insertNewObjectForEntityForName:@"Preset" inManagedObjectContext:managedObjectContext];
                
                [newPreset setValue:presetName forKey:@"presetName"];
                [newPreset setValue:reminderTime forKey:@"reminderTime"];
                
                NSError *error = nil;
                if (![managedObjectContext save:&error]) {
                    NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                }
            }
        }
        // Find 1 data that existed then show alert
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Block Timer" message:@"The name has exist,rename it" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
            [alertView show];
            [self.presetTitleTextField becomeFirstResponder];
            
        }
        
    }
}




@end

