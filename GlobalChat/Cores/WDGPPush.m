//
//  WDGPPush.m
//  BIHappy.eu
//
//  Created by wesley de groot on 26-01-13.
//  Copyright (c) 2013 wesley de groot. All rights reserved.
//

#import "WDGPPush.h"

@implementation WDGPPush

- (void)sendPush:(NSString *)username message:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *newMessage = [message stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        newMessage = [newMessage stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];

        // stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding

        NSString *urlString = [[NSString alloc] initWithFormat:@"%@push.php?send=%@&message=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"url"], username, newMessage];
        NSURL *url = [NSURL URLWithString: urlString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSString* superdata = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"%@: %@", urlString, superdata);
    });
    
}

@end
