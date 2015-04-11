//
//  PageScroll.m
//  UIScroll1
//
//  Created by eddie on 15-3-26.
//  Copyright (c) 2015年 Test. All rights reserved.
//

#import "PageScroll.h"

@implementation PageScroll
@synthesize parentScrollDelegate;
float DEVICE_WIDTH,DEVICE_HEIGHT;
struct PPoint{
    float x,y;
};
struct PPoint touch_Begin;
struct PPoint touch_Current;
struct PPoint touch_End;
@synthesize isTop;
@synthesize tableDelegate;
- (instancetype)initWithFrame:(CGRect )frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate=self;
        isTop=NO;
        [self setDecelerationRate:0.9];
    }
    [self addObserver:self forKeyPath:@"isTop" options:NSKeyValueObservingOptionNew context:nil];
    return self;
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
   
   if(isTop)
   {
       TableController *table=self.tableDelegate;
       table.tableView.userInteractionEnabled=NO;
   }
   else{
       TableController *table=self.tableDelegate;
       table.tableView.userInteractionEnabled=YES;
   }

}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    UIScrollView *parent=self.parentScrollDelegate;
    if(isTop)
    {
        
        if (scrollView.contentOffset.y>20) {
            targetContentOffset->y=160;
            self.isTop=NO;
            parent.scrollEnabled=YES;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"SCROLL_ENABLE" object:nil];
        }
        else
        {
//            [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            targetContentOffset->y=0;
        }
    }
    else
    {
        if (scrollView.contentOffset.y<140) {
//            [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            targetContentOffset->y=0;
            self.isTop=YES;
            
            parent.scrollEnabled=NO;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"SCROLL_DISABLE" object:nil];
        }
        else
        {
//            [scrollView setContentOffset:CGPointMake(0, 160) animated:YES];
            targetContentOffset->y=160;
        }
        
    }

    
}

@end
