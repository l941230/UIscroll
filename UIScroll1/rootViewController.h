//
//  rootViewController.h
//  UIScroll1
//
//  Created by eddie on 15-3-20.
//  Copyright (c) 2015年 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainScroll.h"
#import "FindViewController.h"
@interface rootViewController : UIViewController <UIScrollViewDelegate>
{
    UIView *view1;
    UIView *view2;
    UIView *view3;
    UITapGestureRecognizer *tap;
    UIView *view4;
    
}
-(void)returnMain;
-(void)scrollToMenu;

@property MainScroll *scView;
@end
