//
//  IRCVC.h
//  BIHappy.eu
//
//  Created by wesley de groot on 07-02-13.
//  Copyright (c) 2013 wesley de groot. All rights reserved.
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

@interface IRCVC : UIViewController <NSStreamDelegate>
{
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
@property (nonatomic, retain) NSMutableArray *NICKLIST;


- (IBAction)closeIRCChatWindow:(id)sender;
- (IBAction)sendIT:(id)sender;

- (IBAction)testAlive:(id)sender;

@end