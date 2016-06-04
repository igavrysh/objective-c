//
//  IDPRoom.h
//  SuperObjCProject
//
//  Created by Student 104 on 6/1/16.
//  Copyright (c) 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPAccountant.h"
#import "IDPDirector.h"

@interface IDPRoom : NSObject
@property (nonatomic, copy, readonly) NSArray *workers;
@property (nonatomic, assign, readonly, getter=isFilled) BOOL filled;

- (void)addWorker:(IDPWorker *)worker;
- (void)removeWorker:(IDPWorker *)worker;

@end
