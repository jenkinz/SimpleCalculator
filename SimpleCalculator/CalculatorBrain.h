//
//  CalculatorBrain.h
//  SimpleCalculator
//
//  Created by Brian Jenkins on 8/31/12.
//  Copyright (c) 2012 Brian Jenkins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (void)reset;

@property (readonly) id program;

+ (double)runProgram:(id)program;
+ (NSString *)description:(id)program;

@end
