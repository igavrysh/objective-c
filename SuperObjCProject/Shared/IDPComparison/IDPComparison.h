//
//  IDPComparison.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDPComparison;

typedef void(^IDPObjectBlock)(id<IDPComparison>);

typedef void(^IDPArrayIteratrionBlock)(id<IDPComparison> object, NSUInteger index, BOOL *stop);

@protocol IDPComparison <NSObject>

- (NSComparisonResult)compareToObject:(id<IDPComparison>)object;

@end


