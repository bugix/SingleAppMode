//
//  ViewController.m
//  SingleAppMode
//
//  Created by Martin Imobersteg on 28.10.14.
//  Copyright (c) 2014 Catnip. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startSingleMode:(id)sender {
    
    NSLog(@"requesting guided access");

    UIAccessibilityRequestGuidedAccessSession(YES, ^(BOOL didSucceed) {
        if (didSucceed) {
            NSLog(@"entered guided access");
            //self.inGuidedSessionMode = YES;
            [[[UIAlertView alloc] initWithTitle:@"Entered single access mode" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        else {
            NSLog(@"failed to enter guided access");
            [[[UIAlertView alloc] initWithTitle:@"Unable to enter single access mode" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    });
    
}

- (IBAction)stopSingleMode:(id)sender {
    
    NSLog(@"requesting non guided access");

    UIAccessibilityRequestGuidedAccessSession(NO, ^(BOOL didSucceed) {
        if (didSucceed) {
            NSLog(@"left guided access");
            //self.inGuidedSessionMode = NO;
            [[[UIAlertView alloc] initWithTitle:@"Left single access mode" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        else {
            NSLog(@"failed to leave guided access");
            [[[UIAlertView alloc] initWithTitle:@"Unable to leave single access mode" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    });
}
@end
