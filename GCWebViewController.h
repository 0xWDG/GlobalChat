//
//  GCWebViewController.h
//  GlobalChat
//
//  Created by Wesley de Groot on 25-01-14.
//  Copyright (c) 2014 wdgwv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCWebViewController : UIViewController <UIWebViewDelegate>
{
    IBOutlet UIWebView *gcWeb;
    IBOutlet UILabel   *gcLabel;
    IBOutlet UIButton  *gcButton;
}

@property (nonatomic, retain) NSString *gcFile;

- (IBAction)closeWindow:(id)sender;

@end
