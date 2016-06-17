//
//  IDPSet.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPSet.h"

#import "IDPLinkedListSet.h"

#import "NSObject+IDPObject.h"

@implementation IDPSet

#pragma mark -
#pragma mark Class methods

+ (instancetype)setWithSet:(NSSet *)set {
    return [[[IDPLinkedListSet alloc] initWithSet:set] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithSet:(NSSet *)set {
    [self release];
    
    return [[IDPLinkedListSet alloc] initWithSet:set];
}

#pragma mark -
#pragma mark Public Methods

- (NSUInteger)count {
    [self doesNotRecognizeSelector:_cmd];
    
    return 0;
}

- (NSString *)objectAtIndexedSubscript:(NSUInteger)index {
    [self doesNotRecognizeSelector:_cmd];
    
    return nil;
}

- (NSSet *)set {
    __block NSMutableSet *set = [NSMutableSet object];
    
    [self enumerateObjectsUsingSimpleBlock:^(id<IDPComparison> object) {
        [set addObject:object];
    }];
    
    return [[set copy] autorelease];
}

- (void)enumerateObjectsUsingSimpleBlock:(void(^)(id<IDPComparison>))block {
    if (!block) {
        return;
    }
    
    [self enumerateObjectsUsingBlock:^(id<IDPComparison> object, NSUInteger index, BOOL *stop) {
        block(object);
    }];
}

- (void)enumerateObjectsUsingBlock:(void(^)(id<IDPComparison> object, NSUInteger index, BOOL *stop))block {
    
    if (!block) {
        return;
    }
    
    NSUInteger index = 0;
    BOOL stop = NO;
    for (id<IDPComparison> object in self) {
        block(object, index, &stop);
        
        if (stop) {
            break;
        }
        
        index++;
    }
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id *)stackbuf
                                    count:(NSUInteger)resultLength
{
    state->mutationsPtr = (unsigned long *)self;
    
    NSUInteger length = MIN(state->state + resultLength, [self count]);
    resultLength = length - state->state;
    
    if (0 != resultLength) {
        for (NSUInteger index = 0; index < resultLength; index++) {
            stackbuf[index] = self[index + state->state];
        }
    }
    
    state->itemsPtr = stackbuf;
    
    state->state += resultLength;
    
    return resultLength;
}

@end
