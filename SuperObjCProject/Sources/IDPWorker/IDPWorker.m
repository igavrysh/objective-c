//
//  IDPWorker.m
//  SuperObjCProject
//
//  Created by Student 104 on 6/1/16.
//  Copyright (c) 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPWorker.h"

#import "IDPRandom.h"

@interface IDPWorker ()
@property (nonatomic, assign) float cash;

@end

@implementation IDPWorker

#pragma mark -
#pragma mark Initializtions and Deallocations

- (id)init {
    return [self initWithSalaray:IDPRandomFloatWithMinAndMaxValue(0, 100)
                         capital:IDPRandomFloatWithMinAndMaxValue(0, 100000)
                      experience:IDPRandomUIntWithMaxValue(10)];
}

- (id)initWithSalaray:(float)salary capital:(float)capital experience:(NSUInteger)experience {
    self = [super init];
    if (self) {
        self.cash = 0;
        self.salary = salary;
        self.capital = capital;
        self.experience = experience;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)receiveCashFromWorker:(IDPWorker *)worker {
    self.cash = self.cash + [worker giveAllCash];
}

- (float)giveAllCash {
    float cashToGive = self.cash;
    self.cash = 0;
    
    return cashToGive;
}

@end