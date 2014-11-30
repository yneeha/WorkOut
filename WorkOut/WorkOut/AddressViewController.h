//
//  AddressViewController.h
//  WorkOut
//
//  Created by Arpit Sharma on 30/11/14.
//  Copyright (c) 2014 nyalama1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressViewController : UIViewController<UITextFieldDelegate>
{
    
    IBOutlet UITextField *_addressTF;
    IBOutlet UIButton *_mapButton;
}

@end
