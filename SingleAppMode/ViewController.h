//
//  ViewController.h
//  SingleAppMode
//
//  Created by Martin Imobersteg on 28.10.14.
//  Copyright (c) 2014 Catnip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)startSingleMode:(id)sender;
- (IBAction)stopSingleMode:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *label;


@end

