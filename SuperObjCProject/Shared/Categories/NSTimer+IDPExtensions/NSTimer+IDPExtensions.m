//
//  NSTimer+IDPExtensions.m
//  SuperObjCProject
//
//  Created by Ievgen on 7/19/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSTimer+IDPExtensions.h"

@implementation NSTimer (IDPExtensions)

#pragma mark -
#pragma mark Class methods

+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)delay
                                         block:(IDPTimerExecutionBlock)block
{
    IDPTimerHelper *helper = [[[IDPTimerHelper alloc] initWithBlock:block] autorelease];
    
    return [NSTimer scheduledTimerWithTimeInterval:delay
                                            target:helper
                                          selector:@selector(onTimer:)
                                          userInfo:nil
                                           repeats:YES];
}

@end
