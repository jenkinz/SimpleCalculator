//
//  ViewController.m
//  SimpleCalculator
//
//  Created by Brian Jenkins on 8/31/12.
//  Copyright (c) 2012 Brian Jenkins. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController ()

@property (nonatomic) BOOL userCurrentlyEnteringDigit;
@property (nonatomic) BOOL userHasEnteredDecimalPoint;
@property (nonatomic, strong) CalculatorBrain *calculatorBrain;

@end

@implementation ViewController

@synthesize display = _display;
@synthesize userCurrentlyEnteringDigit = _userCurrentlyEnteringDigit;
@synthesize userHasEnteredDecimalPoint = _userHasEnteredDecimalPoint;
@synthesize calculatorBrain = _calculatorBrain;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setDisplay:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (CalculatorBrain *)calculatorBrain
{
    if (_calculatorBrain == nil) {
        _calculatorBrain = [[CalculatorBrain alloc] init];
    }
    return _calculatorBrain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = [sender currentTitle];
    BOOL isDecimalPoint = NO;
    
    if ([@"." isEqualToString:digit]) {
        isDecimalPoint = YES;
        if (self.userHasEnteredDecimalPoint) {
            return; // don't allow more than one decimal point!
        }
        self.userHasEnteredDecimalPoint = YES;
    }
    
    if (self.userCurrentlyEnteringDigit) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    }
    else {
        self.display.text = digit;
        self.userCurrentlyEnteringDigit = YES;
        if (!isDecimalPoint) {
            self.userHasEnteredDecimalPoint = NO;
        }
    }
}

- (IBAction)operationPressed:(UIButton *)sender
{
    if (self.userCurrentlyEnteringDigit) {
        [self enterPressed]; 
    }
    double result = [self.calculatorBrain performOperation:sender.currentTitle];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}

- (IBAction)enterPressed
{
    [self.calculatorBrain pushOperand:[self.display.text doubleValue]];
    self.userCurrentlyEnteringDigit = NO;
    self.userHasEnteredDecimalPoint = NO;
}

- (IBAction)clearPressed
{
    self.display.text = @"0";
    [self.calculatorBrain reset];
    self.userCurrentlyEnteringDigit = NO;
    self.userHasEnteredDecimalPoint = NO;
}
@end
