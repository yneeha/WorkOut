//
//  LoginViewController.m
//  WorkOut
//
//  Created by Neeharika on 12/2/14.
//  Copyright (c) 2014 nyalama1. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)loginBtnPressed:(id)sender;


@property NSMutableDictionary *users;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(id)init
{
    self=[super init];
    if(self)
    {
        self.users =[[NSMutableDictionary alloc] init];
    }
    return self;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(BOOL) ValidateUser {
    NSString *username= self.usernameText.text;
    NSString *password= self.passwordText.text;
    
    [self loadUsers];
    //check if the user name & password or valid

    if(username.length != 0 && password.length !=0 ){
        
        NSString *savedPwd= [self.users  objectForKey:username];
        
        if(savedPwd!=nil &&[ savedPwd isEqualToString:password])
        {
            return TRUE;
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Username/Password" message:@"Enter the correct username & password" delegate:nil cancelButtonTitle:@"Retry" otherButtonTitles:nil, nil];
            [alert show];
            return false;
        }
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Information" message:@"Fill out the username and password" delegate:nil cancelButtonTitle:@"Retry" otherButtonTitles:nil, nil];
        [alert show];
        return FALSE;
    }
}

- (NSString *) documentsDirectory
{   //  path to <our applications home >/ Documents
    return [@"~/Documents" stringByExpandingTildeInPath];
}

- (NSString *) dataFilePath
{
    return [[self documentsDirectory]stringByAppendingPathComponent :@"Users1.plist"];
}

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
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
- (IBAction)loginBtnPressed:(id)sender {
    if ([self ValidateUser] == TRUE){
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
    }
}
@end
