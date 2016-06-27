//
//  IDPRetainReference.m
//  Test
//
//  Created by Ievgen on 6/24/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPRetainReference.h"

@interface IDPRetainReference ()
@property (nonatomic, retain) id  target;

@end

@implementation IDPRetainReference

@synthesize target = _target;

@end
