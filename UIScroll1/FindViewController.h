//
//  FindViewController.h
//  UIScroll1
//
//  Created by eddie on 15-4-2.
//  Copyright (c) 2015年 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "rootViewController.h"

@interface FindViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property  id  rootDelegate;
@end
