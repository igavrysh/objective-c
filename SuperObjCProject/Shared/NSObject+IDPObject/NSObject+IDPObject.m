//
//  NSObject+IDPObject.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSObject+IDPObject.h"

@implementation NSObject (IDPObject)

+ (id)object  {
    return [self objectWithInitBlock:^id(id object) {
        return [object init];
    }];
}

+ (id)newWithInitBlock:(id (^)(id object)) block {
    id object = [self alloc];
    return block(object);
}

+ (id)objectWithInitBlock:(id (^)(id object)) block {
    return [[self newWithInitBlock:block] autorelease];
}

@end
