//
//  gcSetupAppViewController.h
//  GlobalChat
//
//  Created by Wesley de Groot on 16-03-15.
//  Copyright (c) 2015 wdgwv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gcSetupAppViewController : UIViewController
{
    IBOutlet UITextField *txtUser;
    IBOutlet UISegmentedControl *actChannel;
}

- (IBAction)btnSave:(id)sender;
- (IBAction)btnClose:(id)sender;

@end
