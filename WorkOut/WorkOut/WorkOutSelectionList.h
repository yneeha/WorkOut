//
//  WorkOutSelectionList.h
//  WorkOut
//
//  Created by Lew on 11/11/14.
//  Copyright (c) 2014 nyalama1. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WorkOutSelectionList : NSObject

@property (nonatomic, strong) NSMutableArray *workOuts;

+(WorkOutSelectionList *)allTheWorkouts;

@end
