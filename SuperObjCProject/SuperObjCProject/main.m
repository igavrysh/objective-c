//
//  main.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPCreatureTest.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [IDPCreatureTest creaturesPerformGenderSpecificOperation];
        
        [IDPCreatureTest creaturesSayHi];
        
        [IDPCreatureTest creaturesChildrendSayHi];
    }
    
    return 0;
}
