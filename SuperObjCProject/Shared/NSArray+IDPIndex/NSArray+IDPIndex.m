//
//  NSArray+IDPIndex.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/18/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSArray+IDPIndex.h"

#import "NSObject+IDPObject.h"
#import "NSMutableArray+IDPIndex.h"

@implementation NSArray (IDPIndex)

#pragma mark -
#pragma mark Class Methods

+ (NSArray *)uniformIndexArrayWithCount:(NSUInteger)count {
    NSMutableArray *array = [NSMutableArray uniformIndexWithLowerBound:0 upperBound:count - 1];
    
    return [[array copy] autorelease];
}

@end
