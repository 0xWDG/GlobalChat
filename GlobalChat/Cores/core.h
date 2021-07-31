//
//  wdgp.app.cores
//  BIHappy.eu
//
//  Created by wesley de groot on 13-08-12.
//  Copyright (c) 2001-2012 WesDeGroot Projects. All rights reserved.
//  Copyright (c) 2012-2013 WDG.P. All rights reserved.
//
#ifndef deb
#define deb
#include "WDGDebug.h"
#endif

#ifndef iSmilieLoaded
#define iSmilieLoaded
#include "Smilie.h"
#endif

#ifndef iNetLoaded
#define iNetLoaded
#import "CheckInternetConnection.h"
#endif

#ifndef MTLoaded
#define MTLoaded
#import "MTStatusBarOverlay.h"
#endif

#ifndef Base64
#define Base64
#include "base64.h"
#endif

#ifndef MD5
#define MD5
#include "md5.h"
#endif

#ifndef ImageWebCache
#define ImageWebCache
#import "imageCache.h"
#endif

#ifndef WDGPConfigSingleton
#define WDGPConfigSingleton
#import "WDGPConfig.h"
#endif

#ifndef WDGPIRCSingleton
#define WDGPIRCSingleton
#import "WDGPIRC.h"
#endif

#ifndef SimpleInputBoxReader_core_h
#define SimpleInputBoxReader_core_h

@interface NSDictionary(JSONCategories)
+(NSDictionary*)    dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress;
-(NSData*)          toJSON;
@end

@implementation NSDictionary(JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress
{    
    NSData* data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString: urlAddress] ];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

-(NSData*)toJSON
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}
@end
#endif
