//
//  IDPCarwashDispatcher.h
//  SuperObjCProject
//
//  Created by Ievgen on 7/13/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPCarwash;

@interface IDPCarwashDispatcher : NSObject
@property (nonatomic, readonly, getter=isRunning)   BOOL    running;

+ (instancetype)dispatcherWithCarwash:(IDPCarwash *)carwash;
- (instancetype)initWithCarwash:(IDPCarwash *)carwash;

- (void)start;
- (void)stop;

@end
