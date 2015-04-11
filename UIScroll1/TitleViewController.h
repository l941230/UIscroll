//
//  TitleViewController.h
//  UIScroll1
//
//  Created by eddie on 15-3-31.
//  Copyright (c) 2015年 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleWebView.h"
#import "navController.h"
#import <ShareSDK/ShareSDK.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "JSON.h"
@class  AppDelegate;
@interface TitleViewController : UIViewController<ISSShareViewDelegate,UIWebViewDelegate,UIScrollViewDelegate>
{
    ASIHTTPRequest *request;
    ASINetworkQueue *networkQueue;
    UIActivityIndicatorView *activityIndicator;
    BOOL failed;
    
@private
    AppDelegate *_appDelegate;
}
@property id navdelegate;
@property UIToolbar *toolBar;
@property UIButton *btn;
@property TitleWebView * webView;
@property BOOL isShow;
@end
