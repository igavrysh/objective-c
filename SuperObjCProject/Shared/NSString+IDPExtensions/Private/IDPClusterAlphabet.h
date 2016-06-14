//
//  IDPClusterAlphabet.h
//  Test
//
//  Created by Ievgen on 6/9/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPAlphabet.h"

@interface IDPClusterAlphabet : IDPAlphabet
@property (nonatomic, readonly) NSArray *alphabets;

- (instancetype)initWithAlphabets:(NSArray *)alphabets;

@end
