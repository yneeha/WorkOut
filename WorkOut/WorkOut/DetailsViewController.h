//
//  DetailsViewController.h
//  WorkOut
//
//  Created by Neeharika on 12/2/14.
//  Copyright (c) 2014 nyalama1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController

@property NSString *workout;


-(void) loadDetailsText:(NSString *) path;
@end
