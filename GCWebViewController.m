//
//  GCWebViewController.m
//  GlobalChat
//
//  Created by Wesley de Groot on 25-01-14.
//  Copyright (c) 2014 wdgwv. All rights reserved.
//

#import "GCWebViewController.h"

@interface GCWebViewController ()

@end

@implementation GCWebViewController
@synthesize gcFile;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (IBAction)closeWindow:(id)sender//:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self.gcFile isEqualToString:@""])
         self.gcFile = @"error.html";

    NSString *url = [[NSBundle mainBundle] resourcePath];
    url = [url stringByAppendingString:@"/"];
    url = [url stringByAppendingString:self.gcFile];

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
