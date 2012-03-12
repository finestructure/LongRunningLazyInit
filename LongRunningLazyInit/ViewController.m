//
//  ViewController.m
//  LongRunningLazyInit
//
//  Created by Sven A. Schmidt on 12.03.12.
//  Copyright (c) 2012 abstracture GmbH & Co. KG. All rights reserved.
//

#import "ViewController.h"
#import "Globals.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize textView = _textView;


- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  self.textView.text = @"";
  [[NSNotificationCenter defaultCenter] addObserverForName:@"ValuesUpdated" object:nil queue:nil usingBlock:^(NSNotification *note) {
    NSString *key = note.object;
    NSString *value = [[Globals shared] valueForKey:key];
    NSMutableString *text = [NSMutableString stringWithString:self.textView.text];
    [text appendString:[NSString stringWithFormat:@"key %@ : %@\n", key, value]];
    self.textView.text = text;
  }];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (IBAction)buttonPressed:(id)sender {
  NSLog(@"pressed");
  [Globals shared];
}

@end
