//
//  WorkoutGuideViewController.m
//  WorkOut
//
//  Created by Neeharika on 12/2/14.
//  Copyright (c) 2014 nyalama1. All rights reserved.
//

#import "WorkoutGuideViewController.h"
#import "DetailsViewController.h"

@interface WorkoutGuideViewController ()
@property (weak, nonatomic) IBOutlet UITableView *workoutsTableView;

@property NSArray *workouts;

@end

@implementation WorkoutGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.workouts = [NSArray arrayWithObjects:@"AirBike",@"Crunches",@"Decline PushUps",@"ExerciseBall Pull-In",@"Yoga", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView    {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.workouts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"workoutCell";
    
    UITableViewCell *cell = [self.workoutsTableView
                             dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self.workouts
                           objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSIndexPath *indexPath = [self.workoutsTableView indexPathForSelectedRow];
    self.workout = self.workouts[indexPath.row];
    //NSLog(@"Selected Workout:%@", self.workout);
    
    if([segue.identifier isEqualToString:@"detailsSegue"]){
        DetailsViewController *controller = (DetailsViewController *)segue.destinationViewController;
        controller.workout= self.workout;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
