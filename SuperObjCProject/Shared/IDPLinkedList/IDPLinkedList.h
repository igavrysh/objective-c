//
//  IDPLinkedList.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPLinkedList : NSObject<NSFastEnumeration>
@property (nonatomic, assign, readonly) NSUInteger count;

- (void)addObject:(id)object;

- (id)getFirstObject;
- (id)getObjectBeforeObject:(id)object;
- (id)getObjectAfterObject:(id)object;

- (id)removeFirstObject;
- (id)removeObject:(id)object;
- (id)removeAllObjects;

- (BOOL)containsObject:(id)object;

@end
