//
//  NSObject+IDPObject.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSObject+IDPObject.h"

#import "NSArray+IDPArrayEnumerator.h"

@implementation NSObject (IDPObject)

+ (id)object  {
    return [[[self alloc] init] autorelease];
}

+ (NSArray *)objectsWithCount:(NSUInteger)count {
    return [NSArray objectsWithCount:count block:^id{
        return [self object];
    }];
}

@end
