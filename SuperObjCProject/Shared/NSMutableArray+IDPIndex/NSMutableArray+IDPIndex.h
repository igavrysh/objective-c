//
//  NSMutableArray+IDPIndex.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/18/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (IDPIndex)

- (void)addUniformIndexWithLowerBound:(NSUInteger)lowerBound
                           upperBound:(NSUInteger)upperBound;

@end
