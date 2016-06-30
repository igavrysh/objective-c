//
//  IDPQueue.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/9/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPQueue : NSObject
@property (nonatomic, readonly) NSUInteger count;

- (void)enqueue:(id)object;

- (id)dequeue;

@end
