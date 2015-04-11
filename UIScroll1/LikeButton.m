//
//  LikeButton.m
//  UIScroll1
//
//  Created by eddie on 15-3-29.
//  Copyright (c) 2015年 Test. All rights reserved.
//

#import "LikeButton.h"

@implementation LikeButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setFrame:CGRectMake(150, 150, 50, 20)];
      
        [self setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
        [self setTitle:@"喜欢" forState:UIControlStateNormal];
        
        
    }
    return self;
}
@end
