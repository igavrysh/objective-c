//
//  IDPMaleCreature.m
//  SuperCProject
//
//  Created by Ievgen on 5/31/16.
//  Copyright © 2016 Ievgen Gavrysh. All rights reserved.
//

#import "IDPMaleCreature.h"

@interface IDPMaleCreature ()

- (void)goToWar;

@end

@implementation IDPMaleCreature

#pragma mark -
#pragma mark Public Methods

- (void)performGenderSpecificOperation {
    [self goToWar];
}


#pragma mark -
#pragma mark Privte Methods

- (void)goToWar {
    [self printMessage:@"I am going to war!"];
}


@end
