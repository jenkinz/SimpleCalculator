//
//  CalculatorBrain.m
//  SimpleCalculator
//
//  Created by Brian Jenkins on 8/31/12.
//  Copyright (c) 2012 Brian Jenkins. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain ()

@property (nonatomic, strong) NSMutableArray *operandQueue;

@end

@implementation CalculatorBrain

@synthesize operandQueue = _operandQueue;

- (NSMutableArray *)operandQueue
{
    if (_operandQueue == nil) {
        _operandQueue = [[NSMutableArray alloc] init];
    }
    return _operandQueue;
}

- (void)pushOperand:(double)operand
{
    [self.operandQueue addObject:[NSNumber numberWithDouble:operand]];
}

- (double)popOperand
{
    if (self.operandQueue) {
        NSNumber *popped = [self.operandQueue objectAtIndex:0];
        [self.operandQueue removeObjectAtIndex:0];
        return [popped doubleValue];
    }
    return 0;
}

- (double)performOperation:(NSString *)operation
{
    if ([self.operandQueue count] == 0) {
        return 0;
    }
    
    double result = [self popOperand];
    BOOL isOpMultiplication = NO, isOpDivision = NO, isOpAddition = NO, isOpSubtraction = NO;
    
    if ([operation isEqualToString:@"*"]) {
        isOpMultiplication = YES;
    }
    else if ([operation isEqualToString:@"/"]) {
        isOpDivision = YES;
    }
    else if ([operation isEqualToString:@"+"]) {
        isOpAddition = YES;
    }
    else if ([operation isEqualToString:@"-"]) {
        isOpSubtraction = YES;
    }
    
    while ([self.operandQueue count] > 0) {
        if (isOpMultiplication) {
            result *= [self popOperand];
        }
        else if (isOpDivision) {
            result /= [self popOperand];
        }
        else if (isOpAddition) {
            result += [self popOperand];
        }
        else if (isOpSubtraction) {
            result -= [self popOperand];
        }
    }
    
    return result;
}

- (void)reset
{
    [self.operandQueue removeAllObjects];
}

@end
