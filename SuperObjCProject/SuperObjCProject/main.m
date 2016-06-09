//
//  main.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPCreatureTest.h"
#import "IDPCarwashTest.h"

#import "IDPRandom.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        IDPCreatureTest *test1 = [[IDPCreatureTest new] autorelease];
        
        [test1 execute];
        
        IDPCarwashTest *test2 = [[IDPCarwashTest new] autorelease];
        
        [test2 execute];
    }
    
    return 0;
}
