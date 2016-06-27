//
//  IDPReference.h
//  Test
//
//  Created by Ievgen on 6/24/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPReference : NSObject <NSCopying>
@property (nonatomic, readonly) id target;

+ (instancetype)referenceWithTarget:(id)target;

- (instancetype)initWithTarget:(id)target;

- (BOOL)isEqualToRefence:(IDPReference *)reference;

@end
