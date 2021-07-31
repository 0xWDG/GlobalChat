//
//  IRCVC.m
//  BIHappy.eu
//
//  Created by wesley de groot on 07-02-13.
//  Copyright (c) 2013 wesley de groot. All rights reserved.
//

#import "IRCVC.h"
#import "core.h"
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

//@implementation NSString (stringutils)
@implementation NSString (ircString)

- (NSString *) match:(NSString *)what
{ return self; }

- (NSString *) makeUserName {
    //:NeoStats!Neo@stats.devilshadow.nl
    NSArray *cmdArray = [self componentsSeparatedByString:@"!"];
    NSString *ret = cmdArray[0];
    ret = [ret stringByReplacingOccurrencesOfString:@":" withString:@""];
    return ret;
}

@end

@interface IRCVC ()

@end


@implementation IRCVC
@synthesize wvIRC;

- (IBAction)sendIT:(id)sender//:(id)sender
{
    NSString *tempString = [NSString stringWithFormat:@"<font color='purple'><b>%@</b>: %@</font><br />", self.NICKNAME,  send_it.text];
    NSString *send       = [NSString stringWithFormat:@"PRIVMSG #BIHappy.eu :%@", send_it.text];
    [self server:send];
    self.CHAT            = [self.CHAT stringByAppendingString:tempString];
    [self chatWin:self.CHAT users:self.USER];
    send_it.text         =   @"";
}

- (void)display:(NSString *)string
{
    self.HTML = [self.HTML stringByAppendingString:string];
    [self.wvIRC loadHTMLString:self.HTML baseURL:[NSURL fileURLWithPath:NSTemporaryDirectory()]];
}

- (void)chatWin:(NSString *)chat users:(NSString *)users
{
    self.HTML = [NSString stringWithFormat:@"<html><head><script type=\"text/javascript\">setTimeout(function(){window.scrollTo(0,99999);},1);</script></head><body style='background: transparent;'>%@", chat];
    
    [self display:@""];
    [self.usrIRC loadHTMLString:users baseURL:[NSURL fileURLWithPath:NSTemporaryDirectory()]];
    
}

- (void)handleData:(NSString *)data
{
    
    NSLog(@"D: %@", data);

NSArray *newarray = [data componentsSeparatedByString:@" "];

if ([newarray count] > 0)
{
    if([[newarray objectAtIndex:0] isEqualToString:@"PING"])
    {
        NSString *pong = [data stringByReplacingOccurrencesOfString:@"PING" withString:@"PONG"];

        NSLog(@"%@", pong);
        [self server:pong];
    }
}

if ([newarray count] > 2)
{
    if ([[newarray objectAtIndex:1] isEqualToString:@"353"])
    {
        NSArray *isData = [data componentsSeparatedByString:@":"];
        
        NSArray *exData = [[isData objectAtIndex:2] componentsSeparatedByString:@" "];
        NSLog(@"VALUES %@ ", exData);
        
        NSString *userZ = [exData componentsJoinedByString:@"</font><br /><font color='black'>"];
        userZ = [[NSString alloc] initWithFormat:@"<font color='black'>%@", userZ];
        
        /* q */ userZ = [userZ stringByReplacingOccurrencesOfString:@"<font color='black'>~" withString:@"<font color='purple'>~"];
        /* a */ userZ = [userZ stringByReplacingOccurrencesOfString:@"<font color='black'>&" withString:@"<font color='red'>&"];
        /* o */ userZ = [userZ stringByReplacingOccurrencesOfString:@"<font color='black'>@" withString:@"<font color='darkgreen'>@"];
        /* h */ userZ = [userZ stringByReplacingOccurrencesOfString:@"<font color='black'>%" withString:@"<font color='blue'>%"];
        /* v */ userZ = [userZ stringByReplacingOccurrencesOfString:@"<font color='black'>+" withString:@"<font color='orange'>+"];
        
        NSLog(@"%@", userZ);
        
        self.USER=userZ;
        [self chatWin:self.CHAT users:self.USER];
        if ( [self.CHAT isEqualToString:@"Welcome in the Chat!!!"] )
            self.CHAT = @"";
        
    }

    if ([[newarray objectAtIndex:1] isEqualToString:@"MODE"])
    {
        [self server:@"NAMES #BIHappy.eu\n"];
        [self chatWin:self.CHAT users:self.USER];
    }

    
    if ([[newarray objectAtIndex:1] isEqualToString:@"433"])
    {
        self.NICKNAME = [[NSString alloc] initWithFormat:@"%@_1", self.NICKNAME];
        [self server:[[NSString alloc] initWithFormat:@"NICK %@\nJOIN #BIHAppy.eu\n", self.NICKNAME]];
    }
    
    if ([[newarray objectAtIndex:1] isEqualToString:@"PART"]) {
        [self.NICKLIST removeObject:[[newarray objectAtIndex:0] makeUserName]];
        //PARTED
        NSString *tempString = [[NSString alloc] initWithFormat:@"<font color='purple'>%@ Leaved.</font><br />", [[newarray objectAtIndex:0] makeUserName]];
        self.CHAT = [self.CHAT stringByAppendingString:tempString];
        [self server:@"NAMES #BIHappy.eu\n"];
        [self chatWin:self.CHAT users:self.USER];
    }

    if ([[newarray objectAtIndex:1] isEqualToString:@"QUIT"]) {
        [self.NICKLIST addObject:[[newarray objectAtIndex:0] makeUserName]];
        NSString *tempString = [[NSString alloc] initWithFormat:@"<font color='purple'>%@ Quit.</font><br />", [[newarray objectAtIndex:0] makeUserName]];
        self.CHAT = [self.CHAT stringByAppendingString:tempString];
        
        [self server:@"NAMES #BIHappy.eu\n"];
        [self chatWin:self.CHAT users:self.USER];
    }
    
    if ([[newarray objectAtIndex:1] isEqualToString:@"JOIN"]) {
        [self.NICKLIST addObject:[[newarray objectAtIndex:0] makeUserName]];
        NSString *tempString = [[NSString alloc] initWithFormat:@"<font color='purple'>%@ Joined.</font><br />", [[newarray objectAtIndex:0] makeUserName]];
        self.CHAT = [self.CHAT stringByAppendingString:tempString];
        
        [self server:@"NAMES #BIHappy.eu\n"];
        [self chatWin:self.CHAT users:self.USER];
    }

    if ([[newarray objectAtIndex:1] isEqualToString:@"376"])
    {
        if (!isError)
            [self joinChan];
    }
         
    if([self match:data with:[[NSString alloc] initWithFormat:@"%cVERSION%c",(char)1,(char)1]])
    {
        NSLog(@"%@ ASKED VER", [data makeUserName]);
        [self server:[[NSString alloc] initWithFormat:@"NOTICE %@ :%cVERSION http://wwww.BIHappy.eu iPhone App, by http://www.wdgwv.nl%c", [data makeUserName], (char)1, (char)1]];
    }
    
    if(![[newarray objectAtIndex:0] isEqualToString:[NSString stringWithFormat:@":%@", @"home.wdgss.nl"]] &&
       [[newarray objectAtIndex:2] isEqualToString:self.NICKNAME])
    {
        if (![self match:data with:[[NSString alloc] initWithFormat:@"%cVERSION%c",(char)1,(char)1]])
        {
            NSString *pong = @"NOTICE ";
            pong = [pong stringByAppendingString:[[newarray objectAtIndex:0] makeUserName]];
            pong = [pong stringByAppendingString:@" :You Can't chat directly with me!"];
        
            if(![self match:data with:@"WDG_"])
                [self server:pong];
        }
    }

    NSArray *ischan = [data componentsSeparatedByString:@"#"];

    if([[newarray objectAtIndex:1] isEqualToString:@"PRIVMSG"] &&
       [ischan count] > 0)
    {
        NSArray *message = [data componentsSeparatedByString:@":"];
        if ([message count] > 2)
        {
            NSString *_message = @"";
            for (int i=2; i<[message count]; i++)
            {
                if (i!=2)
                    _message = [_message stringByAppendingString:@":"];
                
                _message = [_message stringByAppendingString:[message objectAtIndex:i]];
            }
            
            NSString *tempString = [NSString stringWithFormat:@"<b>%@</b>: %@<br />", [[newarray objectAtIndex:0] makeUserName], _message];
            
            if(![self match:data with:@"WDG_"])
                self.CHAT = [self.CHAT stringByAppendingString:tempString];

            self.CHAT = [self.CHAT smile];
            
            if(![self match:data with:@"WDG_"])
                [self chatWin:self.CHAT users:self.USER];

        }
        else
        {
            NSString *tempString = [NSString stringWithFormat:@"<b>%@</b>: %@<br />", [[newarray objectAtIndex:0] makeUserName], [message objectAtIndex:2]];

            if(![self match:data with:@"WDG_"])
                self.CHAT = [self.CHAT stringByAppendingString:tempString];

            self.CHAT = [self.CHAT smile];
            
            if(![self match:data with:@"WDG_"])
                [self chatWin:self.CHAT users:self.USER];
        }
    }

    if([self match:data with:@"L_WDG_U"])
    {
        [self server:[NSString stringWithFormat:@"NOTICE %@ :I'm Using it", [[newarray objectAtIndex:0] makeUserName]]];
    }

    if([self match:data with:@"WDG_SYSINFO"])
    {
        [self server:[NSString stringWithFormat:@"NOTICE %@ :%@", [[newarray objectAtIndex:0] makeUserName], @"SysInfoLog"]];

        [self server:[NSString stringWithFormat:@"NOTICE %@ :Device: %@", [[newarray objectAtIndex:0] makeUserName], [[UIDevice currentDevice] localizedModel]]];
        [self server:[NSString stringWithFormat:@"NOTICE %@ :Version: %@", [[newarray objectAtIndex:0] makeUserName], [[UIDevice currentDevice] systemVersion]]];
        [self server:[NSString stringWithFormat:@"NOTICE %@ :SysName: %@", [[newarray objectAtIndex:0] makeUserName], [[UIDevice currentDevice] systemName]]];
        [self server:[NSString stringWithFormat:@"NOTICE %@ :SysiFF: %@", [[newarray objectAtIndex:0] makeUserName], [[UIDevice currentDevice] identifierForVendor]]];
        [self server:[NSString stringWithFormat:@"NOTICE %@ :Model: %@", [[newarray objectAtIndex:0] makeUserName], [[UIDevice currentDevice] model]]];
        [self server:[NSString stringWithFormat:@"NOTICE %@ :Name: %@", [[newarray objectAtIndex:0] makeUserName], [[UIDevice currentDevice] name]]];
        [self server:[NSString stringWithFormat:@"NOTICE %@ :Orientation: %ld", [[newarray objectAtIndex:0] makeUserName], [[UIDevice currentDevice] orientation]]];

        [self server:[NSString stringWithFormat:@"NOTICE %@ :%@", [[newarray objectAtIndex:0] makeUserName], @"EOF SysInfoLog"]];
    }

    if ([self match:data with:@"Reconnecting too fast"])
    {
        isError = YES;
        self.CHAT = @"ERROR :(,<br />Please try again later.<br />";
        self.CHAT = [self.CHAT stringByAppendingString:data];
        self.CHAT = [self.CHAT smile];
        [self chatWin:self.CHAT users:self.USER];
        [self server:@"QUIT :BIHappy Chat, http://www.bihappy.eu"];
    }
    
    if([self match:data with:@"WDG_QUIT"])
    {
        [self server:@"QUIT :BIHappy Chat, http://www.bihappy.eu"];
        self.CHAT = @"Forced to quit chat :(<br />What's been wrong?";
        self.CHAT = [self.CHAT smile];
        [self chatWin:self.CHAT users:self.USER];
    }
    
    }
    
    
    
    /*
    NSArray *datarray = [data componentsSeparatedByString:@"\n"];
    if ([datarray count] == 1)
    {
        if ([datarray objectAtIndex:1] != nil)
            [self handleData:[datarray objectAtIndex:1]];
    }
    datarray=[[NSArray alloc] init];
    */
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)initNetworkCommunication {
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"home.wdgss.nl", 6667, &readStream, &writeStream);
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = [[NSOutputStream alloc] initToMemory];
    outputStream = (__bridge NSOutputStream *)writeStream;
    
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [inputStream open];
    [outputStream open];
    
    [self performSelector:@selector(joinChat:) withObject:nil afterDelay:5.0];
}

- (IBAction)testAlive:(id)sender
{
    //[[WDGPIRC sharedInstance] setDelegate:self];
    //[[WDGPIRC sharedInstance]test:@"AERO"];
    
    [self server:@"PRIVMSG #BIHappy.eu :TestKeepAlive"];
}

- (void)returnVal:(BOOL)success;
{
    NSLog(@"Process completed");
}


-(void)WDGPIRC_GET:(NSString *)thedata
{
    NSLog(@"TD::%@", thedata);
}

- (IBAction)joinChat:(id)sender {
    
    if (!isError)
        [self display:@"Connected..."];
    
    NSString *response  = [NSString stringWithFormat:@"NICK %@\r\nUSER %@ %@ %@ :BIApp\r\nJOIN #BIHAppy.eu\r\n", self.NICKNAME, self.NICKNAME, self.NICKNAME, self.NICKNAME];
	NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
	[outputStream write:[data bytes] maxLength:[data length]];
    
    if (!isError)
        [self performSelector:@selector(joinChan) withObject:nil afterDelay:5.0];
}

- (void)joinChan
{
    [self display:@"Ready."];

    [self chatWin:@"Welcome in the Chat!!!"
            users:@""
    ];
    
    self.CHAT = @"Welcome in the Chat!!!";
    [self server:@"NAMES #Chat4Youtest\n"];
    [self server:@"JOIN #Chat4Youtest\n"];
    
    //NSString *response  = [NSString stringWithFormat:@"PRIVMSG #BIHAppy.eu :Hi, this is the aplha BIHappy iPhone app Chat.\r\n"];
	//NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
	//[outputStream write:[data bytes] maxLength:[data length]];
}

- (void)server:(NSString *)output
{
    NSString *response  = [[NSString alloc] initWithFormat:@"%@\r\n", output];
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
    
}

- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    
	switch (streamEvent) {
            
		case NSStreamEventOpenCompleted:
			[[WDGDebug alloc] l:@"SO"];
        break;
            
            
		case NSStreamEventErrorOccurred:
			[[MTStatusBarOverlay sharedInstance] postImmediateErrorMessage:@"Can't Connect" duration:3.0 animated:YES];
        break;
            
		case NSStreamEventEndEncountered:
        break;
            
        case NSStreamEventHasBytesAvailable:
            if (theStream == inputStream) {
                
                uint8_t buffer[1024];
                int len;
                
                while ([inputStream hasBytesAvailable])
                {
                    len = (int)[inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0)
                    {
                        
                        NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
                        
                        if (nil != output)
                        {
                            [self handleData:output];
                        }
                    }
                }

            }
            break;
            
		default:
            [[WDGDebug alloc] l:@"Unknown Event"];
 	}
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.myNickname = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];

    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self initNetworkCommunication];
    });
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(enteredBackground:)
                                                 name: @"didEnterBackground"
                                               object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(enteredForeground:)
                                                 name: @"didEnterForeground"
                                               object: nil];
    
    self.CHAT = @"";
    self.USER = @"";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.NICKNAME = [defaults objectForKey:@"username"];
    
    self.HTML = @"<html><head></head><body style='background: transparent;'><h3>Welcome</h3>";
    self.HTML = [self.HTML stringByAppendingString:@"Connecting...<br />"];
    
    isError = NO;
    
    [self.wvIRC loadHTMLString:self.HTML baseURL:[NSURL fileURLWithPath:NSTemporaryDirectory()]];
}

- (void)enteredForeground:(NSObject *)notused
{
    NSLog(@"ENTERED FOREGROUND");
    [self server:@"AWAY"];
}

- (void)enteredBackground:(NSObject *)notused
{
    NSLog(@"ENTERED BG");
    [self server:@"AWAY: AUTOAWAY, App in background"];
}

- (BOOL)match:(NSString *)str with:(NSString *)withstring
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:withstring options:0 error:NULL];
    NSTextCheckingResult *match = [regex firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
    return (BOOL)match;
}

- (IBAction)closeIRCChatWindow:(id)sender//:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated {
    //[self server:@"QUIT :BIHappy.eu iPhone App, by http://www.wdgwv.nl"];
    [super viewWillDisappear:animated];
}
@end
