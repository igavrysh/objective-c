//
//  IDPLinkedListNode.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPLinkedListNode.h"

@implementation IDPLinkedListNode

- (void)dealloc {
    self.object = nil;
    self.nextNode.previousNode = nil;
    self.nextNode = nil;
    
    [super dealloc];
}

- (instancetype)initWithObject:(id)object
                  previousNode:(IDPLinkedListNode *)previousNode
                      nextNode:(IDPLinkedListNode *)nextNode
{
    self = [super init];
   
    self.object = object;
    self.previousNode = previousNode;
    self.nextNode = nextNode;
    
    return self;
}

@end
