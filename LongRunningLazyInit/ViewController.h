//
//  ViewController.h
//  LongRunningLazyInit
//
//  Created by Sven A. Schmidt on 12.03.12.
//  Copyright (c) 2012 abstracture GmbH & Co. KG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)buttonPressed:(id)sender;

@end
