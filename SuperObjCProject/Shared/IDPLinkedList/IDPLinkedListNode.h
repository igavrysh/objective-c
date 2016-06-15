//
//  IDPLinkedListNode.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPLinkedListNode : NSObject
@property (nonatomic, retain) IDPLinkedListNode     *nextNode;
@property (nonatomic, assign) IDPLinkedListNode     *previousNode;
@property (nonatomic, retain) id                    object;

- (instancetype)initWithObject:(id)object
                previousNode:(IDPLinkedListNode *)previousNode
                    nextNode:(IDPLinkedListNode *)nextNode;

@end
