//
//  WDGDebug.h
//  BIHappy.eu
//
//  Created by wesley de groot on 31-01-13.
//  Copyright (c) 2013 wesley de groot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDGDebug : NSObject
{
    
}

- (void) l:(NSString *)log;
- (BOOL) e:(NSString *)empty;
- (void) printConfig;

@end
