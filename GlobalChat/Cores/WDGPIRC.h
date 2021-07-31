//
//  WDGPConfig.h
//  iWebTools
//
//  Created by wesley de groot on 20-05-13.
//  Copyright (c) 2013 WDG.P. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

@protocol WDGPIRCDelegate <NSObject>
@required
- (void) returnVal: (BOOL)success;
@end

@interface WDGPIRC : NSObject
{
    NSMutableDictionary *configdb;
    id <WDGPIRCDelegate> delegate;

}
@property (retain) id delegate;

+ (WDGPIRC *)sharedInstance;

- (WDGPIRC *) test:(NSString *)key;

@end
