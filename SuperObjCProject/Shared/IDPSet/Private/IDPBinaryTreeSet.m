//
//  IDPBinaryTreeSet.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPBinaryTreeSet.h"

#import "IDPBinaryTreeNode.h"

#import "NSObject+IDPObject.h"
#import "NSArray+IDPIndex.h"

@interface IDPBinaryTreeSet ()
@property (nonatomic, retain) IDPBinaryTreeNode *root;

- (void)addObject:(id<IDPComparison>)object key:(NSUInteger)key;

- (IDPBinaryTreeNode *)nodeWithObject:(id<IDPComparison>)object
                                  key:(NSUInteger)key
                                 node:(IDPBinaryTreeNode *)node;
@end

@implementation IDPBinaryTreeSet

#pragma mark -
#pragma mark Class Methods

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithSet:(NSSet *)set {
    self = [super init];
    [self addObjectsFromSet:set];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)addObjectsFromSet:(NSSet *)set {
    NSMutableArray *array = [[set allObjects] mutableCopy];
    [array sortUsingComparator:
     ^NSComparisonResult(id<IDPComparison> object1, id<IDPComparison> object2) {
         return [object1 compareToObject:object2];
     }];
    
    NSArray *indexes = [NSArray arrayWithUniformIndexesCount:[set count]];
    for (NSNumber *index in indexes) {
        [self addObject:array[[index unsignedIntegerValue]]];
    }
}

- (void)addObject:(id<IDPComparison>)object{
    self.root = [self nodeWithObject:object node:self.root];
}


- (IDPBinaryTreeNode *)nodeWithObject:(id<IDPComparison>)object
                                 node:(IDPBinaryTreeNode *)node
{
    if (!node) {
        self.count += 1;
        return [IDPBinaryTreeNode nodeWithObject:object leftChild:nil rightChild:nil];
    }
    
    IDPBinaryTreeNode *leftChild = node.leftChild;
    IDPBinaryTreeNode *rightChild = node.rightChild;
    if (NSOrderedAscending == [object compareToObject:node.object]) {
        node.leftChild = [self nodeWithObject:object node:leftChild];
    } else if (NSOrderedDescending == [object compareToObject:node.object]) {
        node.rightChild = [self nodeWithObject:object node:rightChild];
    } else {
        node.object = object;
        return node;
    }
    
    return nil;
}

#pragma mark -
#pragma mark Private Methods


@end
