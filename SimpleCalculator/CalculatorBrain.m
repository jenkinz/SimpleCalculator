//
//  CalculatorBrain.m
//  SimpleCalculator
//
//  Created by Brian Jenkins on 8/31/12.
//  Copyright (c) 2012 Brian Jenkins. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain ()

@property (nonatomic, strong) NSMutableArray *operandStack;

@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack
{
    if (_operandStack == nil) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

- (void)pushOperand:(double)operand
{
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)popOperand
{
    NSNumber *popped = [self.operandStack lastObject];
    if (self.operandStack) {
        [self.operandStack removeLastObject];
    }
    return [popped doubleValue];
}

- (double)performOperation:(NSString *)operation
{
    if ([self.operandStack count] == 0) {
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
    
    while ([self.operandStack count] > 0) {
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
    [self.operandStack removeAllObjects];
}

@end
