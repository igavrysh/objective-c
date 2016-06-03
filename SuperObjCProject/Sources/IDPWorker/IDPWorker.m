//
//  IDPWorker.m
//  SuperObjCProject
//
//  Created by Student 104 on 6/1/16.
//  Copyright (c) 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPWorker.h"

@interface IDPWorker ()
@property (nonatomic, assign) float cash;

@end

@implementation IDPWorker

- (void)receiveCashFromWorker:(IDPWorker *)worker {
    self.cash = self.cash + [worker giveAllCash];
}

- (float)giveAllCash {
    float cashToGive = self.cash;
    self.cash = 0;
    
    return cashToGive;
}

@end
