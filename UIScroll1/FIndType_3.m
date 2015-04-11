//
//  FIndType_3.m
//  UIScroll1
//
//  Created by eddie on 15-4-6.
//  Copyright (c) 2015年 Test. All rights reserved.
//

#import "FIndType_3.h"

@implementation FIndType_3
@synthesize isIntrest;
@synthesize parentFind_2Delegate;
@synthesize name;
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        name = [aDecoder decodeObjectForKey:@"name_3"];
        isIntrest=[aDecoder decodeObjectForKey:@"isIntrest"];
        parentFind_2Delegate=[aDecoder decodeObjectForKey:@"parent"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:name forKey:@"name_3"];
    [aCoder encodeBool:isIntrest forKey:@"isIntrest"];
    [aCoder encodeObject:parentFind_2Delegate forKey:@"parent" ];
}
@end
