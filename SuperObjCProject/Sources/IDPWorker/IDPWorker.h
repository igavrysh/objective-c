//
//  IDPWorker.h
//  SuperObjCProject
//
//  Created by Student 104 on 6/1/16.
//  Copyright (c) 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPObservableObject.h"
#import "IDPCashOwner.h"

@class IDPWorker;

typedef NS_ENUM(NSUInteger, IDPWorkerState) {
    IDPWorkerFree,
    IDPWorkerBusy,
    IDPWorkerPending
};

@protocol IDPWorkerObserver <NSObject>
@optional
- (void)workerDidBecomeFree:(IDPWorker *)worker;
- (void)workerDidBecomeBusy:(IDPWorker *)worker;
- (void)workerDidBecomePending:(IDPWorker *)worker;

@end

@interface IDPWorker : IDPObservableObject <IDPCashOwner>
@property (nonatomic, assign) float                 salary;
@property (nonatomic, assign) float                 capital;
@property (nonatomic, assign) NSUInteger            experience;

- (void)processObject:(id<IDPCashOwner>) object;

@end
