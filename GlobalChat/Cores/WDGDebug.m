//
//  WDGDebug.m
//  BIHappy.eu
//
//  Created by wesley de groot on 31-01-13.
//  Copyright (c) 2013 wesley de groot. All rights reserved.
//
#define RELEASE

#import "WDGDebug.h"

@implementation WDGDebug
{
    
}

- (void) l:(NSString *)log
{
#ifndef RELEASE
    NSLog(@"%@", log);
#endif
}

- (BOOL) e:(NSString *)empty
{
        if (empty != nil)
            return TRUE;
        else
            return FALSE;
}

- (void) printConfig
{
    NSArray *keys = [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys];
    NSArray *values = [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allValues];
    
    for (int i = 0; i < [keys count]; i++) {
        NSLog(@"%@: %@", [keys objectAtIndex:i], [values objectAtIndex:i]);
    }
}

@end
