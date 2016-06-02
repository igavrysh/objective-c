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

+ (NSArray *)objectsOfClass:(Class)objClass createdWith:(SEL)selector count:(NSUInteger)count
{
    NSMutableArray *array = [NSMutableArray object];
    
    if ([objClass respondsToSelector:selector]) {
        for (NSUInteger index = 0; index < count; index++) {
            [array addObject:[objClass performSelector:selector]];
        }
    }
    
    return [array copy];
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
