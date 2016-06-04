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

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        /*
        IDPCreatureTest *test = [[IDPCreatureTest new] autorelease];
        
        [test execute];
        */
        
        IDPCarwashTest *test = [[IDPCarwashTest new] autorelease];
        
        [test execute];
    }
    
    return 0;
}
