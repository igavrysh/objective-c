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

- (void)setState:(NSUInteger)state object:(id)object;

- (void)notifyOfStateChangeWithSelector:(SEL)selector;
- (void)notifyOfState:(NSUInteger)state object:(id)object;
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
    @synchronized(self.observers) {
        return [self.observers setRepresentation];
    }
}

- (void)setState:(NSUInteger)state {
    @synchronized(self) {
        [self setState:state object:nil];
    }
}

- (void)setState:(NSUInteger)state object:(id)object {
    @synchronized(self) {
        if (state != _state) {
            _state = state;
            
            [self notifyOfState:_state object:object];
        }
    }
}

#pragma mark - 
#pragma mark Public

- (void)addObservers:(NSArray *)observers {
    @synchronized(self.observers) {
        [observers performBlockWithEachObject:^(id object) {
            [self addObserver:object];
        }];
    }
}

- (void)addObserver:(id)observer {
    @synchronized(self.observers) {
        [self.observers addObject:observer];
    }
}

- (void)removeAllObservers {
    @synchronized(self.observers) {
        [self removeObservers:self.observers.setRepresentation.allObjects];
    }
}

- (void)removeObservers:(NSArray *)observers {
    @synchronized(self.observers) {
        [observers performBlockWithEachObject:^(id object) {
            [self removeObserver:object];
        }];
    }
}

- (void)removeObserver:(id)observer {
    @synchronized(self.observers) {
        [self.observers removeObject:observer];
    }
}

- (BOOL)isObservedByObject:(id)observer {
    @synchronized(self.observers) {
        return [self.observers containsObject:observer];
    }
}

#pragma mark -
#pragma mark Private

- (SEL)selectorForState:(NSUInteger)state {
    return NULL;
}

- (void)notifyOfStateChangeWithSelector:(SEL)selector {
    [self notifyOfStateChangeWithSelector:selector object:nil];
}

- (void)notifyOfState:(NSUInteger)state object:(id)object {
    [self notifyOfStateChangeWithSelector:[self selectorForState:state] object:nil];
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
