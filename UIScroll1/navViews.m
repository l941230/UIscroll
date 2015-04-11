//
//  navViews.m
//  UIScroll1
//
//  Created by eddie on 15-3-23.
//  Copyright (c) 2015年 Test. All rights reserved.
//

#import "navViews.h"

@interface navViews ()

@end

@implementation navViews
@synthesize delegate;

float DEVICE_WIDTH,DEVICE_HEIGHT;
@synthesize views;
- (instancetype)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    // Do any additional setup after loading the view.
    DEVICE_WIDTH=[[UIScreen mainScreen]bounds].size.width;
    DEVICE_HEIGHT=[[UIScreen mainScreen]bounds].size.height;
   
    views=[[NSMutableArray alloc]init];
    
    for(int i=0;i<6;i++)
    {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
               btn.frame=CGRectMake(i*DEVICE_WIDTH/6.0, 0, DEVICE_WIDTH/6.0, 30);
       
        btn.adjustsImageWhenHighlighted=NO;
        [btn addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchDown];
      [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     
//        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
//         [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
//         [btn setTitleColor:[UIColor blueColor] forState:UIControlStateReserved];
//         [btn setTitleColor:[UIColor blueColor] forState:UIControlStateApplication];
//       
        [views addObject:btn];
      //  [btn setBackgroundColor:[UIColor grayColor]];
        
    }
   
    UIButton *btn1=[views objectAtIndex:0];
     UIButton *btn2=[views objectAtIndex:1];
     UIButton *btn3=[views objectAtIndex:2];
     UIButton *btn4=[views objectAtIndex:3];
     UIButton *btn5=[views objectAtIndex:4];
     UIButton *btn6=[views objectAtIndex:5];
    [btn1 setTitle:@"推荐" forState:UIControlStateNormal];
    [btn2 setTitle:@"通知" forState:UIControlStateNormal];
    [btn3 setTitle:@"专业" forState:UIControlStateNormal];
    [btn4 setTitle:@"能力" forState:UIControlStateNormal];
    [btn5 setTitle:@"规划" forState:UIControlStateNormal];
    [btn6 setTitle:@"兴趣" forState:UIControlStateNormal];
    for(int i=0;i<6;i++){
        
        [self addSubview:[views objectAtIndex:i]];
        
    }
    return self;
    
}

-(void)changeView:(UIButton *)btnn
{
 
    NSUInteger i=[self.views indexOfObject:btnn];
    
    [delegate.scrol setContentOffset:CGPointMake(i*DEVICE_WIDTH, 0) animated:YES];
  
   
    }






@end




