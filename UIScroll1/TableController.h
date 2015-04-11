//
//  TableViewController.h
//  UIScroll1
//
//  Created by eddie on 15-3-29.
//  Copyright (c) 2015年 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleViewController.h"
@interface TableController : UITableViewController<UIWebViewDelegate>
@property id mainDelegate;
@property TitleViewController *titleCtr;
@end
