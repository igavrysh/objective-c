//
//  IDPObservableObject.m
//  Test
//
//  Created by Ievgen on 6/22/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPObservableObject.h"

#import "NSArray+IDPArrayEnumerator.h"

@interface IDPObservableObject ()
@property (nonatomic, retain) NSHashTable   *observers;

- (void)notifyOfStateChangeWithSelector:(SEL)selector;

- (void)notifyOfStateChangeWithSelector:(SEL)selector object:(id)object;

@end

@implementation IDPObservableObject

@dynamic observerSet;

#pragma mark - 
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.observers = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.observers = [NSHashTable weakObjectsHashTable];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSSet *)observerSet {
    return [self.observers setRepresentation];
}

- (void)setState:(NSUInteger)state {
    if (state != _state) {
        _state = state;
        
        [self notifyOfStateChangeWithSelector:[self selectorForState:state]];
    }
}

#pragma mark - 
#pragma mark Public

- (void)addObserver:(id)observer {
    [self.observers addObject:observer];
}

- (void)removeAllObservers {
    [self removeObservers:self.observers.setRepresentation.allObjects];
}

- (void)removeObservers:(NSArray *)observers {
    [observers performBlockWithEachObject:^(id object) {
        [self removeObserver:object];
    }];
}

- (void)removeObserver:(id)observer {
    [self.observers removeObject:observer];
}

- (BOOL)isObservedByObject:(id)observer {
    return [self.observers containsObject:observer];
}

#pragma mark -
#pragma mark Private

- (SEL)selectorForState:(NSUInteger)state {
    [self doesNotRecognizeSelector:_cmd];
    
    return NULL;
}

- (void)notifyOfStateChangeWithSelector:(SEL)selector {
    [self notifyOfStateChangeWithSelector:selector object:nil];
}

- (void)notifyOfStateChangeWithSelector:(SEL)selector object:(id)object {
    @synchronized(self.observers) {
        NSHashTable *observers = self.observers;
        for (id object in observers) {
            if ([object respondsToSelector:selector]) {
                [object performSelector:selector withObject:self withObject:object];
            }
        }
    }
}

@end
