//
//  gcWelkomViewController.m
//  GlobalChat
//
//  Created by Wesley de Groot on 12-03-15.
//  Copyright (c) 2015 wdgwv. All rights reserved.
//

#import "gcWelkomViewController.h"
#import "gcSetupAppViewController.h"

@interface gcWelkomViewController ()

@end

@implementation gcWelkomViewController

- (IBAction)btnSetup:(id)sender
{
    gcSetupAppViewController *vc = [[gcSetupAppViewController alloc] initWithNibName:@"gcSetupAppViewController" bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)setUpApp {
        // SET UP THIS APP!
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ( [[defaults objectForKey:@"setup"] isEqualToString:@"done"] )
    {
        
    }
    else
    {
        gcSetupAppViewController *vc = [[gcSetupAppViewController alloc] initWithNibName:@"gcSetupAppViewController" bundle:nil];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSelector:@selector(setUpApp) withObject:nil afterDelay:1.0];
    
    // Do any additional setup after loading the view.
    NSString *url = [[NSBundle mainBundle] resourcePath];
    url = [url stringByAppendingString:@"/"];
    url = [url stringByAppendingString:@"welkom.html"];
    
    NSFileManager *fm = [NSFileManager alloc];
    if (![fm fileExistsAtPath:url isDirectory:false])
    {
        NSString *url = [[NSBundle mainBundle] resourcePath];
        url = [url stringByAppendingString:@"/error.html"];
    }
    
    
    NSString* content = [NSString stringWithContentsOfFile:url
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    UIWebView *web = [gcWeb init];
    [web loadHTMLString:content baseURL:[NSURL URLWithString:url]];
    
    NSString * jsCallBack = @"window.getSelection().removeAllRanges();";
    [web stringByEvaluatingJavaScriptFromString:jsCallBack];
    
    NSError *error;
    NSString *htmlCode = [NSString stringWithContentsOfFile:url encoding:NSASCIIStringEncoding error:&error];
    
    NSString *startPoint = @"<title>";  //7
    NSString *endPoint   = @"</title>"; //8
    
    NSRange startRange = [htmlCode rangeOfString:startPoint];
    NSRange endRange   = [htmlCode rangeOfString:endPoint];
    
    NSString *docTitle = [htmlCode substringWithRange:NSMakeRange(startRange.location + startRange.length, endRange.location - endRange.length - ( (8 * 3) + 1) )];
    
    NSLog(@"B: %lu, BL: %lu, E:%lu, EL:%lu, T:%@", (unsigned long)startRange.location, (unsigned long)startRange.length, (unsigned long)endRange.location, (unsigned long)endRange.length, docTitle);
    
    gcLabel.text = docTitle;
    
    [web setBackgroundColor:[UIColor clearColor]];
    [web setOpaque:NO];
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
