//
//  NSTimer+IDPExtensions.m
//  SuperObjCProject
//
//  Created by Ievgen on 7/19/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSTimer+IDPExtensions.h"

@interface NSTimer ()
@property (nonatomic, retain) IDPTimerHelper *helper;

@end

@implementation NSTimer (IDPExtensions)

- (void)setHelper:(IDPTimerHelper *)helper {
    
}


#pragma mark -
#pragma mark Class methods

- (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)delay
                                         block:(IDPTimerExecutionBlock)block
{
    IDPTimerHelper *helper = [[[IDPTimerHelper alloc] initWithBlock:block] autorelease];
    
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:delay
                                                       target:helper
                                                     selector:@selector(onTimer:)
                                                     userInfo:nil
                                                      repeats:YES];
    self.helper = helper;
    
    return timer;
}


#pragma mark - 
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.helper = nil;
    
    [super dealloc];
}

@end
