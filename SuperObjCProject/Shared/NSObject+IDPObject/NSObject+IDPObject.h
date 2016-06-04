//
//  NSObject+IDPObject.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (IDPObject)

+ (id)object;

+ (id)objectWithInitBlock:(id (^)(id object)) block;

+ (id)newWithInitBlock:(id (^)(id object)) block;

@end
