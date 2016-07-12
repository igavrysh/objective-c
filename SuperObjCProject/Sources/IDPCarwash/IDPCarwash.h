//
//  IDPCarwash.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDPWorkerObserver;

@class IDPCar;

@interface IDPCarwash : NSObject<IDPWorkerObserver>

- (void)processCar:(IDPCar *)car;

@end
