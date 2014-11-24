
//
//  AddItemViewController.m
//  WorkOut
//
//  Created by asharm64 on 10/27/14.
//  Copyright (c) 2014 nyalama1. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController()
@property NSArray *workoutOptions;
@property NSString *selectedWorkout;
@property (weak, nonatomic) IBOutlet UITextField *mytextField;
@end

@implementation AddItemViewController
@synthesize mytextField;


- (void)viewDidLoad {
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"images.jpeg"]];
    self.workoutOptions = [[NSArray alloc ] initWithObjects:@"Select Workout", @"Bench Press", @"Incline Bench Press", @"Chest Flies",@"Butterflies",@"Push Ups",@"Squats",@"Deadlift",@"Shoulder Press", @"Bicep Curls",@"Arnold Presses",@"Lunges",@"Skull Crushers",@"Tricep Pull Downs",
                           @"Cable Chest Press", nil];
    
}


- (IBAction)Cancel:(id)sender {
    [self.delegate addItemViewControllerDidCancel:self];
    //[ self.presentingViewController dismissViewControllerAnimated :YES completion :nil];
}

- (IBAction)Save:(id)sender {
    
    //save what they selected on the picker
    WorkoutlistItem *item =[[WorkoutlistItem alloc] init];
    if([self.selectedWorkout isEqual:@"Select Workout"] || self.selectedWorkout == nil)
    {
        item.text = [self.mytextField text];
    }
    else
    {
        item.text = self.selectedWorkout;
    }
    item.checked =NO;
    [self.delegate addItemViewController:self didFinishAddingItem : item];
    [ self.presentingViewController dismissViewControllerAnimated :YES completion :nil];
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mytextField becomeFirstResponder];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [self.workoutOptions count];
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    
    return [self.workoutOptions objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    self.selectedWorkout = [self.workoutOptions objectAtIndex:row];
}
@end