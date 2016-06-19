//
//  IDPComparison.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDPComparison;

typedef void(^IDPProcessComparisonObject)(id<IDPComparison>);

typedef void(^IDPProcessComparisonObjectWithIndexStop)(id<IDPComparison> object, NSUInteger index, BOOL *stop);

@protocol IDPComparison <NSObject>

- (NSComparisonResult)compare:(id<IDPComparison>)object;

@end


