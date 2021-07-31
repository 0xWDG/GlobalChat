//
//  gcChatViewController.m
//  GlobalChat
//
//  Created by Wesley de Groot on 12-03-15.
//  Copyright (c) 2015 wdgwv. All rights reserved.
//

#import "gcChatViewController.h"
#import "core.h"
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

//@implementation NSString (stringutils)
@implementation NSString (ircString)

- (NSString *) match:(NSString *)what
{ return self; }

- (NSString *) makeUserName {
    NSArray *cmdArray = [self componentsSeparatedByString:@"!"];
    NSString *ret = cmdArray[0];
    ret = [ret stringByReplacingOccurrencesOfString:@":" withString:@""];
    return ret;
}

@end

@interface gcChatViewController ()
{
}
@end

@implementation gcChatViewController
@synthesize wvIRC;

#pragma mark send message
- (IBAction)sendIT:(id)sender
{
    NSString *tempString = [NSString stringWithFormat:@"<font color='purple'><b>%@</b>: %@</font><br />", self.NICKNAME,  send_it.text];
    NSString *send       = [NSString stringWithFormat:@"PRIVMSG %@ :%@", self.CHANNEL, send_it.text];
                           [self server:send];
    self.CHAT            = [self.CHAT stringByAppendingString:tempString];
                           [self chatWin:self.CHAT users:self.USER];
    send_it.text         = @"";
}

#pragma mark display to screen
- (void)display:(NSString *)string
{
    self.HTML = [self.HTML stringByAppendingString:string];
    [self.wvIRC loadHTMLString:self.HTML baseURL:[NSURL fileURLWithPath:NSTemporaryDirectory()]];
}

#pragma mark set chatwindow + users.
- (void)chatWin:(NSString *)chat users:(NSString *)users
{
    self.HTML = [NSString stringWithFormat:@"<html><head><style type=\"text/css\">%@</style><script type=\"text/javascript\">setTimeout(function(){window.scrollTo(0,999999999);},1);</script><script type=\"text/javascript\">%@</script></head><body style='background: transparent;'>%@", @".bg0{background-color:#fff}.bg1{background-color:#000}.bg2{background-color:navy}.bg3{background-color:green}.bg4{background-color:red}.bg5{background-color:#a52a2a}.bg6{background-color:purple}.bg7{background-color:orange}.bg8{background-color:#ff0}.bg9{background-color:lime}.bg10{background-color:teal}.bg11{background-color:#e0ffff}.bg12{background-color:blue}.bg13{background-color:#ffc0cb}.bg14{background-color:grey}.bg15{background-color:#d3d3d3}.fg0{color:#fff}.fg1{color:#000}.fg2{color:navy}.fg3{color:green}.fg4{color:red}.fg5{color:#a52a2a}.fg6{color:purple}.fg7{color:orange}.fg8{color:#ff0}.fg9{color:lime}.fg10{color:teal}.fg11{color:#e0ffff}.fg12{color:blue}.fg13{color:#ffc0cb}.fg14{color:grey}.fg15{color:#d3d3d3}", @"document.writeln(unescape('%3C%73%63%72%69%70%74%20%6C%61%6E%67%75%61%67%65%3D%22%6A%61%76%61%73%63%72%69%70%74%22%3E%0A%66%75%6E%63%74%69%6F%6E%20%50%61%72%73%65%43%6F%6C%6F%72%73%28%74%65%78%74%29%20%7B%0A%20%20%20%20%76%61%72%20%72%65%78%20%3D%20%2F%5C%30%30%33%28%5B%30%2D%39%5D%7B%31%2C%32%7D%29%5B%2C%5D%3F%28%5B%30%2D%39%5D%7B%31%2C%32%7D%29%3F%28%5B%5E%5C%30%30%33%5D%2B%29%2F%2C%6D%61%74%63%68%65%73%2C%63%6F%6C%6F%72%73%3B%0A%20%20%20%20%69%66%20%28%72%65%78%2E%74%65%73%74%28%74%65%78%74%29%29%20%7B%0A%20%20%20%20%20%20%20%20%77%68%69%6C%65%20%28%63%70%20%3D%20%72%65%78%2E%65%78%65%63%28%74%65%78%74%29%29%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%69%66%20%28%63%70%5B%32%5D%29%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%76%61%72%20%63%62%67%20%3D%20%63%70%5B%32%5D%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20%20%20%20%20%76%61%72%20%74%65%78%74%20%3D%20%74%65%78%74%2E%72%65%70%6C%61%63%65%28%63%70%5B%30%5D%2C%27%3C%73%70%61%6E%20%63%6C%61%73%73%3D%22%66%67%27%2B%63%70%5B%31%5D%2B%27%20%62%67%27%2B%63%62%67%2B%27%22%3E%27%2B%63%70%5B%33%5D%2B%27%3C%2F%73%70%61%6E%3E%27%29%3B%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%7D%0A%20%20%20%20%76%61%72%20%62%75%69%20%3D%20%5B%0A%20%20%20%20%20%20%20%20%5B%2F%5C%30%30%32%28%5B%5E%5C%30%30%32%5D%2B%29%28%5C%30%30%32%29%3F%2F%2C%20%5B%22%3C%62%3E%22%2C%22%3C%2F%62%3E%22%5D%5D%2C%0A%20%20%20%20%20%20%20%20%5B%2F%5C%30%33%37%28%5B%5E%5C%30%33%37%5D%2B%29%28%5C%30%33%37%29%3F%2F%2C%20%5B%22%3C%75%3E%22%2C%22%3C%2F%75%3E%22%5D%5D%2C%0A%20%20%20%20%20%20%20%20%5B%2F%5C%30%33%35%28%5B%5E%5C%30%33%35%5D%2B%29%28%5C%30%33%35%29%3F%2F%2C%20%5B%22%3C%69%3E%22%2C%22%3C%2F%69%3E%22%5D%5D%0A%20%20%20%20%5D%3B%0A%20%20%20%20%66%6F%72%20%28%76%61%72%20%69%3D%30%3B%69%20%3C%20%62%75%69%2E%6C%65%6E%67%74%68%3B%69%2B%2B%29%20%7B%0A%20%20%20%20%20%20%20%20%76%61%72%20%62%63%20%3D%20%62%75%69%5B%69%5D%5B%30%5D%3B%0A%20%20%20%20%20%20%20%20%76%61%72%20%73%74%79%6C%65%20%3D%20%62%75%69%5B%69%5D%5B%31%5D%3B%0A%20%20%20%20%20%20%20%20%69%66%20%28%62%63%2E%74%65%73%74%28%74%65%78%74%29%29%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%77%68%69%6C%65%20%28%62%6D%61%74%63%68%20%3D%20%62%63%2E%65%78%65%63%28%74%65%78%74%29%29%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%76%61%72%20%74%65%78%74%20%3D%20%74%65%78%74%2E%72%65%70%6C%61%63%65%28%62%6D%61%74%63%68%5B%30%5D%2C%20%73%74%79%6C%65%5B%30%5D%2B%62%6D%61%74%63%68%5B%31%5D%2B%73%74%79%6C%65%5B%31%5D%29%3B%0A%20%20%20%20%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%7D%0A%20%20%20%20%72%65%74%75%72%6E%20%74%65%78%74%3B%0A%7D%0A%3C%2F%73%63%72%69%70%74%3E%0A%09%09%09'))", chat];
    
    [self display:@""];
    [self.usrIRC loadHTMLString:users baseURL:[NSURL fileURLWithPath:NSTemporaryDirectory()]];
    
}

#pragma mark handle server data
- (void)handleData:(NSString *)data
{
    
    NSLog(@"D: %@", data);
    
    NSArray *newarray = [data componentsSeparatedByString:@" "];
    
    if ([newarray count] > 0)
    {
#pragma mark :SERV PING :RAND (PING? PONG!)
        if([[newarray objectAtIndex:0] isEqualToString:@"PING"])
        {
            NSString *pong = [data stringByReplacingOccurrencesOfString:@"PING" withString:@"PONG"];
            
            NSLog(@"%@", pong);
            [self server:pong];
        }
    }
    
    if ([newarray count] > 2)
    {
#pragma mark :SERVER 353 (Userlist)
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
        
#pragma mark :SERV/USR MODE USR/#CHANNEL MODES
        if ([[newarray objectAtIndex:1] isEqualToString:@"MODE"])
        {
            [self server:[[NSString alloc] initWithFormat:@"NAMES %@\n", self.CHANNEL]];
            [self chatWin:self.CHAT users:self.USER];
        }
        
#pragma mark :SERVER 433 NICK IN USE!
        if ([[newarray objectAtIndex:1] isEqualToString:@"433"])
        {
            self.NICKNAME = [[NSString alloc] initWithFormat:@"%@_1", self.NICKNAME];
            [self server:[[NSString alloc] initWithFormat:@"NICK %@\nJOIN %@\n", self.NICKNAME, self.CHANNEL]];
        }
        
#pragma mark :USER PART #CHANNEL
        if ([[newarray objectAtIndex:1] isEqualToString:@"PART"]) {
            [self.NICKLIST removeObject:[[newarray objectAtIndex:0] makeUserName]];
            NSString *tempString = [[NSString alloc] initWithFormat:@"<font color='purple'>%@ Leaved.</font><br />", [[newarray objectAtIndex:0] makeUserName]];
            self.CHAT = [self.CHAT stringByAppendingString:tempString];
            [self server:[[NSString alloc] initWithFormat:@"NAMES %@\n", self.CHANNEL]];
            [self chatWin:self.CHAT users:self.USER];
        }
        
#pragma mark :USER QUIT :MESSAGE
        if ([[newarray objectAtIndex:1] isEqualToString:@"QUIT"]) {
            [self.NICKLIST addObject:[[newarray objectAtIndex:0] makeUserName]];
            NSString *tempString = [[NSString alloc] initWithFormat:@"<font color='purple'>%@ Quit.</font><br />", [[newarray objectAtIndex:0] makeUserName]];
            self.CHAT = [self.CHAT stringByAppendingString:tempString];
            
            [self server:[[NSString alloc] initWithFormat:@"NAMES %@\n", self.CHANNEL]];
            [self chatWin:self.CHAT users:self.USER];
        }
        
#pragma mark :USER JOIN #CHANNEL
        if ([[newarray objectAtIndex:1] isEqualToString:@"JOIN"])
        {
            [self.NICKLIST addObject:[[newarray objectAtIndex:0] makeUserName]];
            NSString *tempString = [[NSString alloc] initWithFormat:@"<font color='purple'>%@ Joined.</font><br />", [[newarray objectAtIndex:0] makeUserName]];
            self.CHAT = [self.CHAT stringByAppendingString:tempString];
            
            [self server:[[NSString alloc] initWithFormat:@"NAMES %@\n", self.CHANNEL]];
            [self chatWin:self.CHAT users:self.USER];
        }
        
#pragma mark :SERVER 396 (END OF MOTD)
        if ([[newarray objectAtIndex:1] isEqualToString:@"396"])
        {
            if (!isError)
                [self joinChan];
        }
        
#pragma mark :SERV/USR NOTICE :VERSION
        if([self match:data with:[[NSString alloc] initWithFormat:@"%cVERSION%c",(char)1,(char)1]])
        {
            NSLog(@"%@ ASKED VER", [data makeUserName]);
            [self server:[[NSString alloc] initWithFormat:@"NOTICE %@ :%cVERSION GC App https://itunes.apple.com/us/app/globalchat/id977018602?ls=1&mt=8 by http://wdgwv.com%c", [data makeUserName], (char)1, (char)1]];
        }
        
#pragma mark talk: private
        if(![[newarray objectAtIndex:0] isEqualToString:[NSString stringWithFormat:@":%@", @"irc2.GlobalChat.nl"]] &&
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
        
#pragma mark talk: channel
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
                
                _message = [_message stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                _message = [_message stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                
                NSString *tempString = [NSString stringWithFormat:@"<b>%@</b>: <script type=\"text/javascript\">document.writeln(ParseColors('%@'));</script><br />", [[newarray objectAtIndex:0] makeUserName], _message];
                
                if(![self match:data with:@"WDG_"])
                    self.CHAT = [self.CHAT stringByAppendingString:tempString];
                
                self.CHAT = [self.CHAT smile];
                
                if(![self match:data with:@"WDG_"])
                    [self chatWin:self.CHAT users:self.USER];
                
            }
            else
            {
                NSString *_message = [message objectAtIndex:2];
                _message = [_message stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                _message = [_message stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                
                NSString *tempString = [NSString stringWithFormat:@"<b>%@</b>: <script type=\"text/javascript\">document.writeln(ParseColors('%@'));</script><br />", [[newarray objectAtIndex:0] makeUserName], _message];
                
                if(![self match:data with:@"WDG_"])
                    self.CHAT = [self.CHAT stringByAppendingString:tempString];
                
                self.CHAT = [self.CHAT smile];
                
                if(![self match:data with:@"WDG_"])
                    [self chatWin:self.CHAT users:self.USER];
            }
        }
#pragma mark L_WDG_U (List Users)
        if([self match:data with:@"L_WDG_U"])
        {
            [self server:[NSString stringWithFormat:@"NOTICE %@ :I'm Using it", [[newarray objectAtIndex:0] makeUserName]]];
        }
#pragma mark WDG_SYSINFO (Sysinfo)
        if([self match:data with:@"WDG_SYSINFO"])
        {
            [self server:[NSString stringWithFormat:@"NOTICE %@ :%@",               [[newarray objectAtIndex:0] makeUserName], @"SysInfoLog"]];
            [self server:[NSString stringWithFormat:@"NOTICE %@ :Device: %@",       [[newarray objectAtIndex:0] makeUserName], [[UIDevice currentDevice] localizedModel]]];
            [self server:[NSString stringWithFormat:@"NOTICE %@ :Version: %@",      [[newarray objectAtIndex:0] makeUserName], [[UIDevice currentDevice] systemVersion]]];
            [self server:[NSString stringWithFormat:@"NOTICE %@ :SysName: %@",      [[newarray objectAtIndex:0] makeUserName], [[UIDevice currentDevice] systemName]]];
            [self server:[NSString stringWithFormat:@"NOTICE %@ :SysiFF: %@",       [[newarray objectAtIndex:0] makeUserName], [[UIDevice currentDevice] identifierForVendor]]];
            [self server:[NSString stringWithFormat:@"NOTICE %@ :Model: %@",        [[newarray objectAtIndex:0] makeUserName], [[UIDevice currentDevice] model]]];
            [self server:[NSString stringWithFormat:@"NOTICE %@ :Name: %@",         [[newarray objectAtIndex:0] makeUserName], [[UIDevice currentDevice] name]]];
            [self server:[NSString stringWithFormat:@"NOTICE %@ :Orientation: %ld", [[newarray objectAtIndex:0] makeUserName], (long)[[UIDevice currentDevice] orientation]]];
            [self server:[NSString stringWithFormat:@"NOTICE %@ :%@",               [[newarray objectAtIndex:0] makeUserName], @"EOF SysInfoLog"]];
        }
#pragma mark Reconnecting too fast
        if ([self match:data with:@"Reconnecting too fast"])
        {
            isError = YES;
            self.CHAT = @"ERROR :(,<br />Please try again later.<br />";
            self.CHAT = [self.CHAT stringByAppendingString:data];
            self.CHAT = [self.CHAT smile];
            [self chatWin:self.CHAT users:self.USER];
            [self server:@"QUIT :Died."];
        }
#pragma mark WDG_QUIT (Quit all pepole)
        if([self match:data with:@"WDG_QUIT"])
        {
            [self server:@"QUIT :WDGWV Chat, http://www.wdgwv.com"];
            self.CHAT = @"Forced to quit chat :(<br />What's been wrong?";
            self.CHAT = [self.CHAT smile];
            [self chatWin:self.CHAT users:self.USER];
        }
#pragma mark -
        
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark init network communication
- (void)initNetworkCommunication
{
    CFReadStreamRef  readStream;
    CFWriteStreamRef writeStream;
    
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"irc.globalchat.nl", 6667, &readStream, &writeStream);
    inputStream  = (__bridge NSInputStream *)readStream;
    outputStream = [[NSOutputStream alloc] initToMemory];
    outputStream = (__bridge NSOutputStream *)writeStream;
    
    [inputStream  setDelegate:self];
    [outputStream setDelegate:self];
    
    [inputStream  scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [inputStream  open];
    [outputStream open];
    
    [self performSelector:@selector(joinChat:) withObject:nil afterDelay:5.0];
}

#pragma mark NEEDED?
-(void)WDGPIRC_GET:(NSString *)thedata
{
    NSLog(@"TD::%@", thedata);
}

#pragma mark identify and join the channel
- (IBAction)joinChat:(id)sender {
    
    if (!isError)
        [self display:@"Connected..."];
    
    NSString *response  = [NSString stringWithFormat:@"NICK %@\r\nUSER %@ %@ %@ :GCApp\r\nJOIN %@\r\n", self.NICKNAME, self.NICKNAME, self.NICKNAME, self.NICKNAME, self.CHANNEL];
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
    
    if (!isError)
        [self performSelector:@selector(joinChan) withObject:nil afterDelay:2.0];
}

#pragma mark joinChan timer
- (void)joinChan2
{
    [self server:[[NSString alloc] initWithFormat:@"JOIN %@\n", self.CHANNEL]];
    [self server:[[NSString alloc] initWithFormat:@"NAMES %@\n", self.CHANNEL]];
    
    [self performSelector:@selector(joinChan2) withObject:nil afterDelay:5.0];
}

#pragma mark joinChan
- (void)joinChan
{
    [self display:@"Ready."];
    
    [self chatWin:@"Welcome in the Chat!!!<br />"
            users:@""
     ];
    
    self.CHAT = @"Welcome in the Chat!!!<br />";
    [self joinChan2];
}

#pragma mark server function
- (void)server:(NSString *)output
{
    NSString *response  = [[NSString alloc] initWithFormat:@"%@\r\n", output];
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
    
}

#pragma mark read out stream...
- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    
    switch (streamEvent) {
            
        case NSStreamEventOpenCompleted:
            [[WDGDebug alloc] l:@"SO"];
            break;
            
            
        case NSStreamEventErrorOccurred:
            NSLog(@"FAIL2CONNECT");
            //RETRY...
            [self display:[@"Kan niet verbinden :'(" smile]];
            [self initNetworkCommunication];
        
        break;
            
        case NSStreamEventEndEncountered:
            break;
            
        case NSStreamEventHasBytesAvailable:
            if (theStream == inputStream)
            {
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

#pragma mark viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardFrameDidChange:)
                                                 name:UIKeyboardDidChangeFrameNotification object:nil];
    isOpen = NO;

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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];if(defaults){}
    self.NICKNAME = [defaults objectForKey:@"username"];
    self.CHANNEL  = [defaults objectForKey:@"channel"];
//#warning remove ME!
//    self.CHANNEL  = [self.CHANNEL stringByAppendingString:@"TEST"];
    
    self.HTML = @"<html><head></head><body style='background: transparent;'><h3>Welcome</h3>";
    self.HTML = [self.HTML stringByAppendingString:@"Connecting...<br />"];
    
    isError = NO;
    
    [self.wvIRC loadHTMLString:self.HTML baseURL:[NSURL fileURLWithPath:NSTemporaryDirectory()]];
}

#pragma mark enteredForeground
- (void)enteredForeground:(NSObject *)notused
{
    NSLog(@"ENTERED FOREGROUND");
    [self server:@"AWAY"];
}

#pragma mark enteredBackground
- (void)enteredBackground:(NSObject *)notused
{
    NSLog(@"ENTERED BG");
    [self server:@"AWAY: AUTOAWAY, App in background"];
}

#pragma mark match
- (BOOL)match:(NSString *)str with:(NSString *)withstring
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:withstring options:0 error:NULL];
    NSTextCheckingResult *match = [regex firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
    return (BOOL)match;
}

#pragma mark didReceiveMemoryWarning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark viewWillDisappear
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark keyboardFrameDidChange
-(void)keyboardFrameDidChange:(NSNotification*)notification
{
    NSDictionary* info = [notification userInfo];
    NSLog(@"%@", notification);
    
    CGRect kKeyBoardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self.view setFrame:CGRectMake(0, kKeyBoardFrame.origin.y-self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    //+50px onOpen; -50px onClose;
}
@end
