//
//  imageCache
//  "A Small ImageCache solution"
//
//  !!! You need md5.h, get it from: https://github.com/wesdegroot/iOS-Snippets
//
//
//  Created by wesley de groot on 19-01-13.
//  Copyright (c) 2013 WDG.P. All rights reserved.
//  http://www.wdgp.nl                info@wdgp.nl
//
//  Free for non-comercial use.

#import <Foundation/Foundation.h>

@interface UIImage (imageCache)
{
    
}

- (void) cacheImage: (NSString *) ImageURLString;
- (UIImage *) getImage: (NSString *) ImageURLString;
- (void) resetImage: (NSString *) iURL;
- (UIImage *) imageExists: (NSString *) ImageURLString;
@end

@implementation UIImage (imageCache)

#define TMP NSTemporaryDirectory()

- (void) cacheImage: (NSString *) ImageURLString
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    NSURL *ImageURL = [NSURL URLWithString: ImageURLString];
    NSString *filename = [ImageURLString MD5String];
    NSString *uniquePath = [TMP stringByAppendingPathComponent: filename];
    NSData *data = [[NSData alloc] initWithContentsOfURL: ImageURL];
    [data writeToFile:uniquePath atomically:YES];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void) resetImage: (NSString *) iURL
{
    NSString *filename = [iURL MD5String];
    NSString *uniquePath = [TMP stringByAppendingPathComponent: filename];
    NSFileManager* fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:uniquePath error:nil];
}

- (UIImage *) imageExists: (NSString *) ImageURLString
{
    NSString *filename = [ImageURLString MD5String];
    NSString *uniquePath = [TMP stringByAppendingPathComponent: filename];
    UIImage *image;
    if([[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
    {
        NSFileManager* fm = [NSFileManager defaultManager];
        NSDictionary* attrs = [fm attributesOfItemAtPath:uniquePath error:nil];
        
        if (attrs != nil) {
            NSDate *date = (NSDate*)[attrs objectForKey: NSFileCreationDate];
            NSDate* timeNow = [NSDate date];
            
            if ([timeNow timeIntervalSinceDate:date] < 86400.0f) //3600
            {
                image = [UIImage imageWithContentsOfFile: uniquePath];
            }
            else
            {
                image = nil;
            }
        }
        else
        {
            image = nil;
        }
    }
    else
    {
        image = nil;
    }
    return image;
}


- (UIImage *) getImage: (NSString *) ImageURLString
{
    NSString *filename = [ImageURLString MD5String];
    NSString *uniquePath = [TMP stringByAppendingPathComponent: filename];

    UIImage *image;
    if([UIImage imageWithContentsOfFile: uniquePath] != nil)
    {
        NSFileManager* fm = [NSFileManager defaultManager];
        NSDictionary* attrs = [fm attributesOfItemAtPath:uniquePath error:nil];
        
        if (attrs != nil) {
            NSDate *date = (NSDate*)[attrs objectForKey: NSFileCreationDate];
            NSDate* timeNow = [NSDate date];
            
            if ([timeNow timeIntervalSinceDate:date] < 86400.0f) //3600
            {
                // less than a day old.
                image = [UIImage imageWithContentsOfFile: uniquePath];
            }
            else
            {
                // more then a day old.
                [fm removeItemAtPath:uniquePath error:nil];
                [self cacheImage: ImageURLString];
                image = [UIImage imageWithContentsOfFile: uniquePath];
            }
        }
        else
        {
            // possible a error reading the file
            [fm removeItemAtPath:uniquePath error:nil];
            [self cacheImage: ImageURLString];
            image = [UIImage imageWithContentsOfFile: uniquePath];
        }
    }
    else
    {
        [self cacheImage: ImageURLString];
        image = [UIImage imageWithContentsOfFile: uniquePath];
    }
    return image;
}
@end