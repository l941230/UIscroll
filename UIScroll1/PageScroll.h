//
//  PageScroll.h
//  UIScroll1
//
//  Created by eddie on 15-3-26.
//  Copyright (c) 2015年 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableController.h"
@interface PageScroll : UIScrollView<UIScrollViewDelegate>
@property id  parentScrollDelegate;
@property bool isTop;
@property id  tableDelegate;
@end
