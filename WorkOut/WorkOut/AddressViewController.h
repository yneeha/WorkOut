//
//  AddressViewController.h
//  WorkOut
//
//  Created by Arpit Sharma on 30/11/14.
//  Copyright (c) 2014 nyalama1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface AddressViewController : UIViewController<UITextFieldDelegate, MFMailComposeViewControllerDelegate>
{
    
    IBOutlet UITextField *_addressTF;
    IBOutlet UIButton *_mapButton;
    IBOutlet UITextField *_emailTF;
}

- (IBAction)sendEmail:(id)sender;

@end
