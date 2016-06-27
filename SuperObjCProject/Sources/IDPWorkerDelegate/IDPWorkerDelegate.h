//
//  IDPWorkerDelegate.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/24/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPWorker;
@protocol IDPCashOwner;

@protocol IDPWorkerDelegate <NSObject>

- (void)workerDidFinishProcessingObject:(IDPWorker *)worker;

@end