//
//  navController.m
//  UIScroll1
//
//  Created by eddie on 15-3-23.
//  Copyright (c) 2015年 Test. All rights reserved.
//

#import "navController.h"
#import "mainViewController.h"
@interface navController ()

@end

@implementation navController
@synthesize delegatemain;
@synthesize delegateroot;
float DEVICE_WIDTH,DEVICE_HEIGHT;
- (void)viewDidLoad {
    [super viewDidLoad];
  mainViewController *mc=[[mainViewController alloc]init];
    mc.navdelegate=self;
    self.delegatemain=mc;
    DEVICE_WIDTH=[UIScreen mainScreen].bounds.size.width;
    DEVICE_HEIGHT=[UIScreen mainScreen].bounds.size.height;
    

    [mc.view setFrame:CGRectMake(0, self.navigationBar.frame.size.height, DEVICE_WIDTH, DEVICE_HEIGHT-self.navigationBar.frame.size.height)];
    
    [self addChildViewController:mc];
    self.navigationBarHidden=YES;
    
    
    
    }

//-(instancetype)initWithRootViewController:(UIViewController *)rootViewController
//{
//    
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
