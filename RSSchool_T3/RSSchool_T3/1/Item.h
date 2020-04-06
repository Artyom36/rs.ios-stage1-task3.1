//
//  Item.h
//  RSSchool_T3
//
//  Copyright © 2020 Alexander Shalamov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Item : NSObject

@property (nonatomic, readonly, assign) BOOL *isPositive;

- (instancetype)initWithCoefficient:(NSInteger)coefficient andPower:(NSInteger)power;

- (NSString*)coefficientWithPower;

@end

NS_ASSUME_NONNULL_END
