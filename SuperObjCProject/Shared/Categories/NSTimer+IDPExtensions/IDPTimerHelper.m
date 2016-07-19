//
//  IDPTimerHelper.m
//  SuperObjCProject
//
//  Created by Ievgen on 7/19/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPTimerHelper.h"

@interface IDPTimerHelper ()
@property (nonatomic, copy) IDPTimerExecutionBlock block;

@end

@implementation IDPTimerHelper

#pragma mark - 
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.block = nil;
    
    [super dealloc];
}

- (instancetype)initWithBlock:(IDPTimerExecutionBlock)block {
    self = [super init];
    if (self) {
        self.block = block;
        
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)onTimer:(NSTimer *)timer {
    IDPTimerExecutionBlock block = self.block;
    
    if (block) {
        block();
    }
}

@end
