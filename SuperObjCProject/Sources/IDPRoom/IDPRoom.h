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

- (void)addWorker:(IDPWorker *)worker;

- (IDPAccountant *)findAccountant;
- (IDPDirector *)findDirector;

@end
