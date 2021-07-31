//
//  Smilie.m
//  BIHappy.eu
//
//  Created by wesley de groot on 14-09-12.
//  Copyright (c) 2001-2012 WesDeGroot Projects. All rights reserved.
//  Copyright (c) 2012-2013 WDG.P. All rights reserved.
//

//TODO: FIX THIS SHIT THING
//FIXME: FIX THIS SHIT THING
//!!!: KEEP OUT OF ERRORS
//???: HOW DO WE FIX THIS?

#import "Smilie.h"

@implementation NSArray (mxcl)

-(NSArray *)arrayByRemovingObject:(id)anObject
{
    if (anObject == nil) { return [self copy]; } //dodge an exception
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:self];
    [newArray removeObject:anObject];
    return [NSArray arrayWithArray:newArray];
}

-(NSArray *)arrayByRemovingID:(int)anObject
{
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:self];
    [newArray removeObjectAtIndex:anObject];
    return [NSArray arrayWithArray:newArray];
}

@end


@implementation NSString (stringutils)

-(NSString *) stringByReplacingOccurrencesOfString:(NSDictionary *)dict
{
    NSMutableString *str = [[NSMutableString alloc] initWithString:self];
    
    for (NSString *key in [dict allKeys])
    {
        [str replaceOccurrencesOfString:key
             withString:[dict valueForKey:key]
         
             options:NSLiteralSearch
             range:NSMakeRange(0, [str length])
        ];
    }
    return str;
}

static NSDictionary *smileys = nil;

-(NSString *) smile {
    if (smileys == nil) {
        smileys = @{
            @":)"          : @"\ue415",
            @":'("         : @"\ue411",
            @":("          : @"\ue058",
            @"(l)"         : @"\ue022",
            @"(L)"         : @"\ue022",
            @"(u)"         : @"\ue023",
            @":$"          : @"\ue414",
            @"(0)"         : @"\ue225",
            @"(1)"         : @"\ue21c",
            @"(2)"         : @"\ue21d",
            @"(3)"         : @"\ue21e",
            @"(4)"         : @"\ue21f",
            @"(5)"         : @"\ue220",
            @"(6)"         : @"\ue221",
            @"(7)"         : @"\ue222",
            @"(8)"         : @"\ue223",
            @"(9)"         : @"\ue224",
            @"(#)"         : @"\ue210",
            @"(new)"       : @"\ue212",
            @"(top)"       : @"\ue24c",
            @"(wc)"        : @"\ue309",
            @"(atm)"       : @"\ue154",
            @"(work)"      : @"\ue137",
            @"(!)"         : @"\ue252",
            @"(cookie)"    : @"\ue252",
            @"(rice)"      : @"\ue342",
            @"(sushi)"     : @"\ue344",
            @"(patat)"     : @"\ue33b",
            @"(burger)"    : @"\ue120",
            @"(coffe)"     : @"\ue045",
            @"(smoke)"     : @"\ue30e",
            @"(sigarette)" : @"\ue30e",
            @"(presend)"   : @"\ue112",
            @"(xmas)"      : @"\ue033",
            @"(santa)"     : @"\ue448",
            @"(haloween)"  : @"\ue445",
            @"(palm)"      : @"\ue307",
            @"(chicken)"   : @"\ue52e",
            @"(snake)"     : @"\ue52d",
            @"(elephant)"  : @"\ue526",
            @"(horse)"     : @"\ue01a",
            @"(monkey)"    : @"\ue528",
            @"(frog)"      : @"\ue531",
            @"(dog)"       : @"\ue52a",
            @"(cat)"       : @"\ue04f",
            @"(snowmen)"   : @"\ue048",
            @"(cloud)"     : @"\ue049",
            @"(sun)"       : @"\ue04a",
            @"(bl)"        : @"\ue32a",
            @"(lb)"        : @"\ue32a",
            @"(sick)"      : @"\ue40c",
            @"(kiss)"      : @"\ue418",
            @"(zzz)"       : @"\ue13c",
            @"(music)"     : @"\ue326",
            @"(poop)"      : @"\ue05a",
            @"(like)"      : @"\ue00e",
            @"(dislike)"   : @"\ue421",
            @"(c)"         : @"\ue24e",
            @"(r)"         : @"\ue24f",
            @"(tm)"        : @"\ue537"
            //SMILIES
        };
    }

    return [self stringByReplacingOccurrencesOfString:smileys];
}

- (NSString *) load
{
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    NSString *cl = self;
    cl           = [cl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL  *eurl = [NSURL URLWithString: cl];
    NSData *data = [NSData dataWithContentsOfURL:eurl];
    NSString* WD = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    return WD;
}

- (NSString *) translate
{
    return NSLocalizedString(self, nil);
}

- (NSString *) translateAllSep
{
    NSArray *stringArray = [self componentsSeparatedByString:@" "];
    NSString *returnString = @"";
    
    if ([stringArray count] > 0)
    {
        for (int i=0; i < [stringArray count]; i++)
        {
//            NSLog(@"Check %d: %@; T:%@", i, [stringArray objectAtIndex:i],                     NSLocalizedString([[stringArray objectAtIndex:i] uppercaseString],[stringArray objectAtIndex:i]));
            returnString = [[NSString alloc] initWithFormat:@"%@%@",returnString,
                    NSLocalizedString(
                                      [stringArray objectAtIndex:i],
                                      [stringArray objectAtIndex:i]
                                     )
            ];
            
            if ([stringArray count] != i)
                returnString = [[NSString alloc] initWithFormat:@"%@ ", returnString]; //Add The Space Back
        }
    }
    else
    {
        returnString = NSLocalizedString(self, self);
    }
    
    if (returnString == nil)
        returnString = self;
    
    returnString = [returnString stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[returnString substringToIndex:1] uppercaseString]];

    return returnString;
}

@end
