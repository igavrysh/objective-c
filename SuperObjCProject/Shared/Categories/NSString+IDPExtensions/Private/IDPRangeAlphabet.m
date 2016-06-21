//
//  IDPRangeAlphabet.m
//  Test
//
//  Created by Ievgen on 6/9/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPRangeAlphabet.h"

@interface IDPRangeAlphabet ()
@property (nonatomic, assign) NSRange range;

@end


@implementation IDPRangeAlphabet

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithRange:(NSRange)range {
    self = [super init];
    if (self) {
        self.range = range;
    }
    return self;
}

#pragma mark - 
#pragma mark Public Methods

- (NSUInteger)count {
    return self.range.length;
}

- (NSString *)stringAtIndex:(NSUInteger)index {
    NSRange range = self.range;
    
    NSAssert(index <= range.length, NSRangeException);
    
    return [NSString stringWithFormat:@"%c", (unichar)(range.location + index)];
}

@end
