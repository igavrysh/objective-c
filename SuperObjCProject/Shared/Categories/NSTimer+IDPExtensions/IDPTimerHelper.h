//
//  IDPTimerHelper.h
//  SuperObjCProject
//
//  Created by Ievgen on 7/19/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^IDPTimerExecutionBlock)(void);

@interface IDPTimerHelper : NSObject
@property (nonatomic, copy, readonly) IDPTimerExecutionBlock block;

- (instancetype)initWithBlock:(IDPTimerExecutionBlock)block;

- (void)onTimer:(NSTimer *)timer;

@end
