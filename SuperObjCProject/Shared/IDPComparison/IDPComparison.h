//
//  IDPComparison.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDPComparison;

typedef id<IDPComparison> IDPComparisonId;

@protocol IDPComparison <NSObject>

- (NSComparisonResult)compare:(IDPComparisonId)object;

@end


