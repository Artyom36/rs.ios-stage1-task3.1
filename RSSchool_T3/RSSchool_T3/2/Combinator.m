#import "Combinator.h"

@implementation Combinator
- (NSNumber*)chechChooseFromArray:(NSArray <NSNumber*>*)array {
    if (array.count != 2) {
        return nil;
    }
    
    NSInteger m = array[0].integerValue;
    NSInteger n = array[1].integerValue;
    
    for (NSInteger i = 1; i <= n; i++) {
        NSInteger combinations = [self multiplicationFrom:n-i+1 to:n] / [self multiplicationFrom:1 to:i];
        if (combinations == m) {
            return @(i);
        }
    }
    return nil;
}

- (NSInteger)multiplicationFrom:(NSInteger)n to:(NSInteger)m {
    NSInteger result = n;
    while (m > n) {
        result *= m;
        m--;
    }
    return result;
}

@end
