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
    return [[[self alloc] init] autorelease];
}

@end
