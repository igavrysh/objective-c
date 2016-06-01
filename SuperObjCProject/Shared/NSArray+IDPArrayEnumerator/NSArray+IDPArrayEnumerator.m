//
//  NSArray+IDPArrayEnumerator.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSArray+IDPArrayEnumerator.h"

@implementation NSArray (IDPArrayEnumerator)

- (void)performBlockWithEachObject:(void (^)(id object))block {
    [self enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        block(object);
    }];
}

@end
