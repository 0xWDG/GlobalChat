//
//  gcSetupAppViewController.m
//  GlobalChat
//
//  Created by Wesley de Groot on 16-03-15.
//  Copyright (c) 2015 wdgwv. All rights reserved.
//

#import "gcSetupAppViewController.h"

@interface gcSetupAppViewController ()

@end

@implementation gcSetupAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    txtUser.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
}

- (IBAction)btnClose:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnSave:(id)sender
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@"done" forKey:@"setup"];
    
    [defaults setObject:txtUser.text forKey:@"username"];
    
    if (actChannel.selectedSegmentIndex == 0)
        [defaults setObject:@"#Chat4You" forKey:@"channel"];
    else
        [defaults setObject:@"#Trivia-Chat" forKey:@"channel"];
    
    NSLog(@"User: %@\nChan: %@\n- DONE!", [defaults objectForKey:@"username"], [defaults objectForKey:@"channel"]);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
