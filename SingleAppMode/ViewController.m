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
    
    // Add Notification Center observer to be alerted of any change to NSUserDefaults.
    
    // Managed app configuration changes pushed down from an MDM server appear in NSUSerDefaults.
    
    [[NSNotificationCenter defaultCenter] addObserverForName:NSUserDefaultsDidChangeNotification
     
                                                      object:nil
     
                                                       queue:[NSOperationQueue mainQueue]
     
                                                  usingBlock:^(NSNotification *note) {
                                                      
                                                      [self readDefaultsValues];
                                                      
                                                  }];
    
    
    
    // Call readDefaultsValues to make sure default values are read at least once.
    
    [self readDefaultsValues];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The Managed app configuration dictionary pushed down from an MDM server are stored in this key.

static NSString * const kConfigurationKey = @"com.apple.configuration.managed";

// This sample application allows for a server url and cloud document switch to be configured via MDM

// Application developers should document feedback dictionary keys, including data types and valid value ranges.

static NSString * const kConfigurationLabelTextKey = @"labelText";

- (void)readDefaultsValues {
    

    NSDictionary *serverConfig = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kConfigurationKey];
    
    NSString *labelTextString = serverConfig[kConfigurationLabelTextKey];
    
    
    
    // Data coming from MDM server should be validated before use.
    
    // If validation fails, be sure to set a sensible default value as a fallback, even if it is nil.
    
    if (labelTextString && [labelTextString isKindOfClass:[NSString class]]) {
        
        self.label.text = labelTextString;
        
    } else {
        
        self.label.text = @"Default label text";
        
    }
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
