//
//  AddressViewController.m
//  WorkOut
//
//  Created by Arpit Sharma on 30/11/14.
//  Copyright (c) 2014 nyalama1. All rights reserved.
//

#import "AddressViewController.h"
#import "CSEMapViewController.h"

@interface AddressViewController ()
{
    MFMailComposeViewController *_mailComposerl;
}
@end

@implementation AddressViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Find Location";
    
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"map"])
    {
        CSEMapViewController *dest = [segue destinationViewController];
        dest.address = _addressTF.text;
    }
}

- (IBAction)sendEmail:(id)sender
{
    //ye device
    if ([MFMailComposeViewController canSendMail])
    {
        NSLog(@"Please try again after setting up an account.");
        
        return;
    }
    
    // Email Subject
    NSString *emailTitle = @"Test Email";
    
    // Email Content
    NSString *messageBody = @"iOS programming is so fun!";
    
    if (!_emailTF.text || [_emailTF.text isEqualToString:@""])
        return;
    
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:_emailTF.text];
    
    _mailComposerl = [[MFMailComposeViewController alloc] init];
    _mailComposerl.mailComposeDelegate = self;
    [_mailComposerl setSubject:emailTitle];
    [_mailComposerl setMessageBody:messageBody isHTML:NO];
    [_mailComposerl setToRecipients:toRecipents];
    // Present mail view controller on screen
    [self presentViewController:_mailComposerl animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller
           didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
