//
//  mainViewController.h
//  UIScroll1
//
//  Created by eddie on 15-3-21.
//  Copyright (c) 2015年 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageScroll.h"
#import "TableController.h"
@interface mainViewController : UIViewController
<UIScrollViewAccessibilityDelegate>



@property  UIScrollView *scrol;

@property UIButton *oldButton;
@property id navdelegate;
@end
