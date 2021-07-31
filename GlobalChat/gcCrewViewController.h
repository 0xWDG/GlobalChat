//
//  gcCrewViewController.h
//  GlobalChat
//
//  Created by Wesley de Groot on 12-03-15.
//  Copyright (c) 2015 wdgwv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gcCrewViewController : UIViewController <UIWebViewDelegate>
{
    IBOutlet UIWebView *gcWeb;
    IBOutlet UILabel   *gcLabel;
    IBOutlet UIButton  *gcButton;
}

@property (nonatomic, retain) NSString *gcFile;

@end
