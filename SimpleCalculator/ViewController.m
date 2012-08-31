//
//  ViewController.m
//  SimpleCalculator
//
//  Created by Brian Jenkins on 8/31/12.
//  Copyright (c) 2012 Brian Jenkins. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) BOOL userCurrentlyEnteringDigit;

@property (nonatomic, strong) NSMutableArray *digitStack;

@end

@implementation ViewController

@synthesize display = _display;
@synthesize userCurrentlyEnteringDigit = _userCurrentlyEnteringDigit;
@synthesize digitStack = _digitStack;

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

- (NSMutableArray *)digitStack
{
    if (_digitStack == nil) {
        _digitStack = [[NSMutableArray alloc] init];
    }
    return _digitStack;
}

- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = [sender currentTitle];
    
    if (self.userCurrentlyEnteringDigit) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    }
    else {
        self.display.text = digit;
        self.userCurrentlyEnteringDigit = YES;
    }
}

- (IBAction)operationPressed:(UIButton *)sender
{

}

- (IBAction)enterPressed
{
    [self.digitStack addObject:self.display.text];
    self.userCurrentlyEnteringDigit = NO;
}

- (IBAction)clearPressed
{
    NSLog(@"Clear pressed");
    self.userCurrentlyEnteringDigit = NO;
}
@end
