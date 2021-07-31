//
//  gcChatViewController.h
//  GlobalChat
//
//  Created by Wesley de Groot on 12-03-15.
//  Copyright (c) 2015 wdgwv. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

@interface NSString (ircString) {
    
}
- (NSString *) makeUserName;
- (NSString *) match:(NSString *)what;
@end

@interface gcChatViewController : UIViewController <UITextFieldDelegate, NSStreamDelegate>
{
    BOOL isOpen;
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
    NSMutableArray *messages;
    IBOutlet UITextField *send_it;
    BOOL isError;
}

@property (nonatomic, retain) IBOutlet UIWebView *wvIRC;
@property (nonatomic, retain) IBOutlet UIWebView *usrIRC;

@property (nonatomic, retain) NSString *HTML;
@property (nonatomic, retain) NSString *CHAT;
@property (nonatomic, retain) NSString *USER;
@property (nonatomic, retain) NSString *NICKNAME;
@property (nonatomic, retain) NSString *CHANNEL;
@property (nonatomic, retain) NSMutableArray *NICKLIST;


- (IBAction)sendIT:(id)sender;

@end
