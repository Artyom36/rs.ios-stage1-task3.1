#import "PolynomialConverter.h"
#import "Item.h"

@implementation PolynomialConverter
- (NSString*)convertToStringFrom:(NSArray <NSNumber*>*)numbers {
    if (numbers.count == 0) {
        return nil;
    }
    
    NSMutableArray *components = [NSMutableArray new];
    
    for (NSInteger i = 0; i < numbers.count; i++) {
        NSInteger power = numbers.count - i - 1;
        NSNumber *coefficient = numbers[i];
        Item *item = [[Item alloc] initWithCoefficient:coefficient.integerValue andPower:power];
        if (item) {
            [components addObject:item];
        }
    }
    
    NSMutableString *result = [NSMutableString new];
    for (NSInteger i = 0; i < components.count; i++) {
        Item *item = components[i];
        NSString *value = [item coefficientWithPower];
        if (i == 0) {
            if (!item.isPositive) {
                [result appendString:@"-"];
            }
            [result appendString:value];
        } else {
            NSString *sign = item.isPositive ? @"+" : @"-";
            [result appendFormat:@"%@ %@", sign, value];
        }
        if (i < components.count - 1) {
            [result appendString: @" "];
        }
    }
    
    return result;
}
@end
