//
//  IDPWorkerDispatcher.h
//  SuperObjCProject
//
//  Created by Ievgen on 7/11/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPWorker.h"

@interface IDPWorkerDispatcher : NSObject <IDPWorkerObserver>
@property (nonatomic, readonly) NSArray *workers;

+ (instancetype)dispatcherWithName:(NSString *)name workers:(NSArray *)workers;

- (instancetype)initWithName:(NSString *)name workers:(NSArray *)workers;

- (void)processObject:(id<IDPCashOwner>)object;

- (BOOL)isWorkerInProcessors:(IDPWorker *)worker;

@end
