//
//  IDPLinkedListNode.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPLinkedListNode.h"

#import "NSObject+IDPObject.h"

@implementation IDPLinkedListNode

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.object = nil;
    self.nextNode.previousNode = nil;
    self.nextNode = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Class Methods

+ (instancetype)nodeWithObject:(id<IDPComparison>)object
                      nextNode:(IDPLinkedListNode *)nextNode
                  previousNode:(IDPLinkedListNode *)previousNode
{
    IDPLinkedListNode *node = [IDPLinkedListNode object];
   
    node.object = object;
    node.previousNode = previousNode;
    node.nextNode = nextNode;
    
    return node;
}

@end
