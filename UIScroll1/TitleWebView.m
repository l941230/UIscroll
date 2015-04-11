//
//  TitleWebView.m
//  UIScroll1
//
//  Created by eddie on 15-3-31.
//  Copyright (c) 2015年 Test. All rights reserved.
//

#import "TitleWebView.h"
#import "TitleViewController.h"
@implementation TitleWebView
@synthesize controlDelegate;
static float newy= 0;
static float oldy = 0;

float DEVICE_WIDTH,DEVICE_HEIGHT;

struct PPoint{
    float x,y;
};
struct PPoint touch_Begin;
struct PPoint touch_Current;
struct PPoint touch_End;
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}
-(void)tap:(UITapGestureRecognizer *)gesture{
    NSLog(@"tap!!");
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    newy= scrollView.contentOffset.y ;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    oldy= scrollView.contentOffset.y ;
    
    TitleViewController *tc=self.controlDelegate;
 
    [tc.btn.layer removeAllAnimations];
    [tc.toolBar.layer removeAllAnimations];
    if(newy-oldy<0)
    {
        if(tc.isShow)
        {
            CATransition *transition = [CATransition animation];
            transition.duration = 1;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromRight;
            transition.delegate = self;
            [tc.self.btn.layer addAnimation:transition forKey:nil];
            [tc.btn setHidden:YES];
            CATransition *transition1 = [CATransition animation];
            transition1.duration = 1;
            transition1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition1.type = kCATransitionPush;
            transition1.subtype = kCATransitionFromBottom;
            transition1.delegate = self;
            [tc.self.toolBar.layer addAnimation:transition1 forKey:nil];
            [tc.toolBar setHidden:YES];
            
            NSLog(@"%@",tc.toolBar.layer.animationKeys);
            
            tc.isShow=NO;
        }
    }
    else
    {
        if(!tc.isShow)
        {
            tc.isShow=YES;
            CATransition *transition = [CATransition animation];
            transition.duration = 1;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            transition.delegate = self;
            
            [tc.btn.layer addAnimation:transition forKey:nil];
            
            [tc.btn setHidden:NO];
            CATransition *transition1 = [CATransition animation];
            transition1.duration = 1;
            transition1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition1.type = kCATransitionPush;
            transition1.subtype = kCATransitionFromTop;
            transition1.delegate = self;
            
            [tc.self.toolBar.layer addAnimation:transition1 forKey:nil];
            
            [tc.self.toolBar setHidden:NO];
            
        }
    }
    
    oldy = newy;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
}
@end
