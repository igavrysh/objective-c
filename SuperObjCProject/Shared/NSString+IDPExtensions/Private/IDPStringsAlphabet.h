//
//  IDPStringsAlphabet.h
//  Test
//
//  Created by Ievgen on 6/9/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPAlphabet.h"

@interface IDPStringsAlphabet : IDPAlphabet
@property (nonatomic, readonly) NSArray *strings;

- (instancetype)initWithStrings:(NSArray *)string;

@end
