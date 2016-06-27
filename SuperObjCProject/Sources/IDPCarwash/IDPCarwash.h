//
//  IDPCarwash.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "IDPBuilding.h"

@protocol IDPWorkerObserver;

@class IDPCar;

@interface IDPCarwash : NSObject <IDPWorkerObserver>
@property (nonatomic, readonly, getter=isQueueEmpty) BOOL queueEmpty;

- (void)processCar:(IDPCar *)car;

@end
