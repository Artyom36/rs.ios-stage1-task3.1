//
//  Item.m
//  RSSchool_T3
//
//  Copyright © 2020 Alexander Shalamov. All rights reserved.
//

#import "Item.h"

@interface Item()

@property (nonatomic, readwrite) BOOL *isPositive;
@property (nonatomic) NSInteger coefficient;
@property (nonatomic) NSInteger power;

@end

@implementation Item

- (instancetype)initWithCoefficient:(NSInteger)coefficient andPower:(NSInteger)power {
    if (coefficient == 0) {
        return nil;
    }
    if (self = [super init]) {
        self.coefficient = labs(coefficient);
        self.power = power;
        self.isPositive = coefficient > 0;
    }
    return self;
}

- (NSString*)coefficientWithPower {
    NSString *string;
    NSString *coefString = self.coefficient == 1 ? @"" : [NSString stringWithFormat:@"%ld", self.coefficient];
    if (self.power == 0) {
        string = coefString;
    } else if (self.power == 1) {
        string = [NSString stringWithFormat:@"%@x", coefString];
    } else {
        string = [NSString stringWithFormat:@"%@x^%ld", coefString, self.power];
    }
    return string;
}

@end
