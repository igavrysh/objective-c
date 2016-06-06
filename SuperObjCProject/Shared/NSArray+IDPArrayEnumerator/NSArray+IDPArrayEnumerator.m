//
//  NSArray+IDPArrayEnumerator.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSArray+IDPArrayEnumerator.h"

#import "NSObject+IDPObject.h"

@implementation NSArray (IDPArrayEnumerator)

+ (NSArray *)objectsWithCount:(NSUInteger)count block:(id(^)())block {
    NSMutableArray *array = [NSMutableArray object];
    
    for (NSUInteger index = 0; index < count; index++) {
        [array addObject:block()];
    }

    return [[array copy] autorelease];
}

- (void)performBlockWithEachObject:(void (^)(id object))block {
    if (!block) {
        return;
    }
    
    [self enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        block(object);
    }];
}

@end
