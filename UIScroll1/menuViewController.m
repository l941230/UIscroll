//
//  menuViewController.m
//  UIScroll1
//
//  Created by eddie on 15-3-21.
//  Copyright (c) 2015年 Test. All rights reserved.
//

#import "menuViewController.h"

@interface menuViewController ()

@end

@implementation menuViewController
@synthesize menuTableView;
float DEVICE_WIDTH,DEVICE_HEIGHT;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    DEVICE_WIDTH=[UIScreen mainScreen].bounds.size.width;
    DEVICE_HEIGHT=[UIScreen mainScreen].bounds.size.height;
    
//!!!!!!!!!!!!!!!!!!!!
//    UIButton *headViewBtn=[[UIButton alloc]initWithFrame:CGRectZero];
//     NSLayoutConstraint *constraint=[NSLayoutConstraint
//                                     constraintWithItem:headViewBtn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
//    [headViewBtn addConstraint:constraint];
//    constraint=[NSLayoutConstraint
//                constraintWithItem:headViewBtn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:tableView attribute:NSLayoutAttributeTop multiplier:1 constant:-30];
//    [headViewBtn addConstraint:constraint];
    
    
    
    
    
    menuTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0.4*DEVICE_HEIGHT, 0.75*DEVICE_WIDTH, 0.4*DEVICE_HEIGHT)];
    menuTableView.delegate=self;
    menuTableView.dataSource=self;
    menuTableView.rowHeight=70;
    [self.view addSubview:menuTableView];
    }
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
   
        
        static NSString *setterIdentifier=@"setterIdentifier";
        cell=[tableView dequeueReusableCellWithIdentifier:setterIdentifier];
        if(cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:setterIdentifier];
        }
    switch (indexPath.row) {
        case 0:
        
            cell.textLabel.text=@"消息";
            
            break;
        case 1:
            cell.textLabel.text=@"反馈";
            
            break;

        case 2:
            cell.textLabel.text=@"设置";
            
            break;
        case 3:
            cell.textLabel.text=@"关于";
            
            break;

        default:
            break;
    }
    
    return cell;

}
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
