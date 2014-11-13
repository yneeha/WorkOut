//
//  AddItemViewController.m
//  WorkOut
//
//  Created by asharm64 on 10/27/14.
//  Copyright (c) 2014 nyalama1. All rights reserved.
//

#import "AddItemViewController.h"

@implementation AddItemViewController
@synthesize workoutPicker;

- (void)viewDidLoad {
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"images.jpeg"]];
}


- (IBAction)Cancel:(id)sender {
    [self.delegate addItemViewControllerDidCancel:self];
    //[ self.presentingViewController dismissViewControllerAnimated :YES completion :nil];
}

- (IBAction)Save:(id)sender {
    WorkoutlistItem *item =[[WorkoutlistItem alloc] init];
    
    //Get the picker's selection
    int currentIndex = [self.workoutPicker selectedRowInComponent:0];
    
    //Determine the workout associated with the selection
    WorkOutSelectionList *myWorkOuts = [WorkOutSelectionList allTheWorkouts];

    //Set selection as the text
    item.text = [myWorkOuts.workOuts objectAtIndex:currentIndex];

    item.checked =NO;
    [self.delegate addItemViewController:self didFinishAddingItem : item];
    //[ self.presentingViewController dismissViewControllerAnimated :YES completion :nil];
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.workoutPicker becomeFirstResponder];
}

//Methods added that are related to the setting up the picker
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    WorkOutSelectionList *myList = [WorkOutSelectionList allTheWorkouts];
    
    return [myList.workOuts count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    WorkOutSelectionList *myList = [WorkOutSelectionList allTheWorkouts];
    
    return [myList.workOuts objectAtIndex:row];
}
@end
