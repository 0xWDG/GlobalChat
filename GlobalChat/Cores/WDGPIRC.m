//
//  WDGPIRC.m
//  
//
//  Created by wesley de groot on 20-05-13.
//  Copyright (c) 2013 WDG.P. All rights reserved.
//

#import "WDGPIRC.h"
#import "core.h"

@interface WDGPIRC()

// Make any initialization of your class.
- (id) init;
@end

@implementation WDGPIRC
@synthesize delegate;

- (id) init
{
    if ((self = [super init]))
        {
            //EERSTE INIT
            
        }
    
    return self;
}

- (WDGPIRC *) test:(NSString *)key//:(NSString *)key
{
    
    //moet aanroepen als voorbeeld
    //- [IRC gotdata:(NSSTring *)data];
    
    [[self delegate] returnVal:YES];

//    if ([self respondsToSelector:@selector(WDGPIRC_GET:)])
//    {
//        [self performSelector:@selector(WDGPIRC_GET:) withObject:key afterDelay:1.0];
//    }
    return nil;
}


+ (WDGPIRC *)sharedInstance {
    static dispatch_once_t pred;
    __strong static WDGPIRC *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[WDGPIRC alloc] init];
    });
    
	return shared;
}

@end