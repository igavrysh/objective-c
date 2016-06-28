//
//  IDPObservableObject.m
//  Test
//
//  Created by Ievgen on 6/22/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPObservableObject.h"
#import "IDPAssignReference.h"

typedef void(^IDPObserverNotificationBlock)(id object);

@interface IDPObservableObject ()
@property (nonatomic, retain) NSMutableSet *mutableRefereceObserverSet;

- (void)notifyOfStateChangeWithSelector:(SEL)selector;
- (void)notifyOfStateChangeWithSelector:(SEL)selector object:(id)object;
- (void)notifyOfStateChangeWithSelector:(SEL)selector handler:(IDPObserverNotificationBlock)handler;

@end

@implementation IDPObservableObject

@dynamic observerSet;

#pragma mark - 
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableRefereceObserverSet = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableRefereceObserverSet = [NSMutableSet set];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSSet *)observerSet {
    NSMutableSet *observerSet = self.mutableRefereceObserverSet;
    NSMutableSet *result = [NSMutableSet setWithCapacity:[observerSet count]];
    for (IDPReference *reference in observerSet) {
        [result addObject:reference.target];
    }
    
    return [[result copy] autorelease];
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
    [self.mutableRefereceObserverSet addObject:[IDPAssignReference referenceWithTarget:observer]];
}

- (void)removeObserver:(id)observer {
    [self.mutableRefereceObserverSet removeObject:[IDPAssignReference referenceWithTarget:observer]];
}

- (BOOL)isObservedByObject:(id)observer {
    return [self.mutableRefereceObserverSet containsObject:[IDPAssignReference referenceWithTarget:observer]];
}

#pragma mark -
#pragma mark Private

- (SEL)selectorForState:(NSUInteger)state {
    [self doesNotRecognizeSelector:_cmd];
    
    return NULL;
}

- (void)notifyOfStateChangeWithSelector:(SEL)selector {
    [self notifyOfStateChangeWithSelector:selector handler:^(id observableObject) {
        [observableObject performSelector:selector withObject:self];
    }];
}

- (void)notifyOfStateChangeWithSelector:(SEL)selector object:(id)object {
    
    [self notifyOfStateChangeWithSelector:selector handler:^(id observableObject) {
        [observableObject performSelector:selector withObject:self withObject:object];
    }];
}

- (void)notifyOfStateChangeWithSelector:(SEL)selector handler:(IDPObserverNotificationBlock)handler {
    if (!handler) {
        return;
    }
    
    NSMutableSet *observerSet = self.mutableRefereceObserverSet;
    for (IDPAssignReference *reference in observerSet) {
        id target = reference.target;
        if ([target respondsToSelector:selector]) {
            handler(target);
        }
    }
}

@end
