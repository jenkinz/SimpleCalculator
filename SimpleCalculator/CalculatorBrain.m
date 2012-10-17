//
//  CalculatorBrain.m
//  SimpleCalculator
//
//  Created by Brian Jenkins on 8/31/12.
//  Copyright (c) 2012 Brian Jenkins. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain ()

@property (nonatomic, strong) NSMutableArray *programStack;

@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;

- (NSMutableArray *)programStack
{
    if (!_programStack) {
        _programStack = [[NSMutableArray alloc] init];
    }
    return _programStack;
}

- (void)pushOperand:(double)operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)performOperation:(NSString *)operation
{
    if (!self.programStack) {
        return 0;
    }
    
    [self.programStack addObject:operation];
    
    return [CalculatorBrain runProgram:self.program];
}

- (id)program
{
    return [self.programStack copy]; // return a snapshot of the current programStack (an immutable NSArray*)
}

- (void)reset
{
    [self.programStack removeAllObjects];
}

+ (NSString *)descriptionOfProgram:(id)program
{
    if ([program isKindOfClass:[NSArray class]]) {
        NSString *description = @"";
        for (id sym in program) {
            description = [description stringByAppendingFormat:@"%@ ", sym];
        }
        return description;
    }
    return @"Invalid program";
}

+ (double)popThe:(NSMutableArray *)stack
{
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]]) { // operand
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]]) { // operation
        NSString *operation = topOfStack;
        if ([operation isEqualToString:@"×"]) {
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        }
        else if ([operation isEqualToString:@"÷"]) {
            double divisor = [self popOperandOffStack:stack];
            if (divisor) {
                result = [self popThe:stack] / divisor;
            }
        }
        else if ([operation isEqualToString:@"+"]) {
            result = [self popThe:stack] + [self popThe:stack];
        }
        else if ([operation isEqualToString:@"−"]) {
            double subtrahend = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] - subtrahend;
        }
        else if ([operation isEqualToString:@"sin"]) {
            result = sin([self popOperandOffStack:stack]);
        }
        else if ([operation isEqualToString:@"cos"]) {
            result = cos([self popOperandOffStack:stack]);
        }
        else if ([operation isEqualToString:@"√"]) { // sqrt
            result = sqrt([self popOperandOffStack:stack]);
        }
        else if ([operation isEqualToString:@"π"]) { // pi
            result = 3.14159;
        }
    }
    
    return result;
}

+ (double)runProgram:(id)program
{
    NSMutableArray *stack;
     
    
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    
    return [self popThe:stack];  
}

@end
