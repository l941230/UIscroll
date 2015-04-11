//
//  FindType_2.m
//  UIScroll1
//
//  Created by eddie on 15-4-6.
//  Copyright (c) 2015年 Test. All rights reserved.
//

#import "FindType_2.h"

@implementation FindType_2
@synthesize name;
@synthesize subArray;
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        name = [aDecoder decodeObjectForKey:@"name"];
        subArray=[aDecoder decodeObjectForKey:@"array"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeObject:subArray forKey:@"array"];
    
}

@end
