//
//  WorkOutSelectionList.m
//  WorkOut
//
//  Created by Lew on 11/11/14.
//  Copyright (c) 2014 nyalama1. All rights reserved.
//

#import "WorkOutSelectionList.h"

@implementation WorkOutSelectionList

static WorkOutSelectionList *theSelections = nil;

//Lazy instantiator for the workout list
-(id)init {
    self = [super init];
    
    if(self) {
        NSString *filepath = [[NSBundle mainBundle] pathForResource:@"WorkOutList" ofType:@"plist" ];
        
        self.workOuts = [NSMutableArray arrayWithContentsOfFile:filepath];
    }
    
    return self;
}

//Method that contains the list of all the workouts in the pList
+(WorkOutSelectionList *)allTheWorkouts {
    if (theSelections == nil) {
        theSelections = [[WorkOutSelectionList alloc] init];
    }
    return theSelections;
}

@end
