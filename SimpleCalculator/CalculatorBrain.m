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
    if (!_operandStack) {
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
    if (self.operandStack) {
        NSNumber *popped = [self.operandStack lastObject];
        [self.operandStack removeLastObject];
        return [popped doubleValue];
    }
    return 0;
}

- (double)performOperation:(NSString *)operation
{
    if (!self.operandStack || [self.operandStack count] == 0) {
        return 0;
    }
    
    double result = 0;
    
    if ([operation isEqualToString:@"*"]) {
        result = [self popOperand] * [self popOperand];
    }
    else if ([operation isEqualToString:@"/"]) {
        double divisor = [self popOperand];
        if (divisor) {
            result = [self popOperand] / divisor;
        }
    }
    else if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    }
    else if ([operation isEqualToString:@"-"]) {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    }
    
    [self pushOperand:result]; // push result onto queue so it can be used successively
    return result;
}

- (void)reset
{
    [self.operandStack removeAllObjects];
}

@end
