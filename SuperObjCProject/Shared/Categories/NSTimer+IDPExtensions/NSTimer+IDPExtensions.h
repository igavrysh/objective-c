//
//  NSTimer+IDPExtensions.h
//  SuperObjCProject
//
//  Created by Ievgen on 7/19/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPTimerHelper.h"

@interface NSTimer (IDPExtensions)

- (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)delay
                                         block:(IDPTimerExecutionBlock)block;

@end
