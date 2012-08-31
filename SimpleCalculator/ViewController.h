//
//  ViewController.h
//  SimpleCalculator
//
//  Created by Brian Jenkins on 8/31/12.
//  Copyright (c) 2012 Brian Jenkins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *display;

- (IBAction)digitPressed:(UIButton *)sender;

- (IBAction)operationPressed:(UIButton *)sender;

- (IBAction)enterPressed;

- (IBAction)clearPressed;

@end
