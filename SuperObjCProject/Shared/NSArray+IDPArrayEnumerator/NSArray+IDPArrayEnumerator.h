//
//  NSArray+IDPArrayEnumerator.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (IDPArrayEnumerator)

+ (NSArray *)objectsWithCount:(NSUInteger)count block:(id(^)())block;

- (void)performBlockWithEachObject:(void (^)(id object))block;

- (id)objectAtRandomIndex;

@end
