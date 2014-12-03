//
//  DetailsViewController.m
//  WorkOut
//
//  Created by Neeharika on 12/2/14.
//  Copyright (c) 2014 nyalama1. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *detaisTextView;
@property NSMutableArray *workoutlist;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:self.workout ofType:@"txt"];
    [self loadDetailsText:path];
    [self setTitle:self.workout];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadDetailsText:(NSString *) path {
    NSString *textString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    self.detaisTextView.text = textString;
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
