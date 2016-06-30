//
//  IDPThreadSafeQueue.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/30/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPThreadSafeQueue.h"

@implementation IDPThreadSafeQueue

#pragma mark -
#pragma mark Accessors Methods

- (NSUInteger)count {
    @synchronized(self) {
        return [super count];
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)enqueue:(id)object {
    @synchronized(self) {
        [super enqueue:object];
    }
}

- (id)dequeue {
    @synchronized(self) {
        return [super dequeue];
    }
}

- (void)dequeueAll {
    @synchronized(self) {
        [super dequeueAll];
    }
}

@end
