//
//  SignupViewController.m
//  WorkOut
//
//  Created by Neeharika on 12/2/14.
//  Copyright (c) 2014 nyalama1. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "SignupViewController.h"

@interface SignupViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextView;
@property NSMutableArray *user;
@property NSMutableDictionary *users;

- (IBAction)signupBtn:(id)sender;

@end

@implementation SignupViewController

-(id)init
{
    self=[super init];
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadUsers];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString *) documentsDirectory
{   //  path to <our applications home >/ Documents
    return [@"~/Documents" stringByExpandingTildeInPath];
}

- (NSString *) dataFilePath
{
    return [[self documentsDirectory]stringByAppendingPathComponent :@"Users1.plist"];
}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [self saveWorkoutlistItems];
//}
- (void) loadUsers {
    // get our data file path
    NSString * path = [self dataFilePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath : path]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile: path];
        NSKeyedUnarchiver *unarchiver = [[ NSKeyedUnarchiver alloc]
                                         initForReadingWithData : data ];
        // We would like to unarchive the " userslist " key and get areference to it
        self.users  = [unarchiver decodeObjectForKey : @"Userslist"];
        [unarchiver finishDecoding];
    } else {
    self.users=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"hello",@"world", nil];
    }
}

- (void) saveUsers
{
    // create a generic data storage object
    NSMutableData * data = [[ NSMutableData alloc ] init ];
    
    NSKeyedArchiver * archiver = [[ NSKeyedArchiver alloc ]
                                  initForWritingWithMutableData : data ];
    // encode items array and just with all dictionaries we need a key
    [archiver encodeObject:self.users forKey:@"Userslist"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
        
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)signupBtn:(id)sender {
    NSString *username= self.nameText.text;
    NSString *password= self.passwordTextView.text;
    if(username.length != 0 && password.length !=0 ){
        
        _users[username]=password;
        //[_users setObject:password forKey:username];
        
        [self saveUsers];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SignUp Successful" message:@"Go back and Login" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Information" message:@"Fill out the username and password" delegate:nil cancelButtonTitle:@"Retry" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    //NSLog(@"Total users:%@", _users[username]);
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
@end
