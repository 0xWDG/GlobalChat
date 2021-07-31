//
//  Smilie.h
//  BIHappy.eu
//
//  Created by wesley de groot on 14-09-12.
//  Copyright (c) 2001-2012 WesDeGroot Projects. All rights reserved.
//  Copyright (c) 2012-2013 WDG.P. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (mxcl) {
}

-(NSArray *)arrayByRemovingObject:(id)anObject;
-(NSArray *)arrayByRemovingID:(int)anObject;
@end

@interface NSString (stringutils) {

}

- (NSString *) stringByReplacingOccurrencesOfString:(NSDictionary *)dict;
- (NSString *) smile;
- (NSString *) translate;
- (NSString *) translateAllSep;
- (NSString *) load;

@end
