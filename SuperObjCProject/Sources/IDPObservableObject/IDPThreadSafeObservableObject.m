//
//  IDPThreadSafeObservableObject.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/30/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPThreadSafeObservableObject.h"

@implementation IDPThreadSafeObservableObject

#pragma mark -
#pragma mark Accessors

- (NSSet *)observerSet {
    @synchronized(self) {
        return [super observerSet];
    }
}

- (void)setState:(NSUInteger)state {
    @synchronized(self) {
        [super setState:state];
    }
}

#pragma mark -
#pragma mark Public

- (void)addObserver:(id)observer {
    @synchronized(self) {
        [super addObserver:observer];
    }
}

- (void)removeObserver:(id)observer {
    @synchronized(self) {
        [super removeObserver:observer];
    }
}

- (BOOL)isObservedByObject:(id)observer {
    @synchronized(self) {
        return [super isObservedByObject:observer];
    }
}

@end
