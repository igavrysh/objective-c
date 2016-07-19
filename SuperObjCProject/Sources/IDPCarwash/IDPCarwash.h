//
//  IDPCarwash.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPWorker.h"

@class IDPCar;

@interface IDPCarwash : NSObject<IDPWorkerObserver>

- (void)processCar:(IDPCar *)car;

@end
