//
//  TableViewController.m
//  UIScroll1
//
//  Created by eddie on 15-3-29.
//  Copyright (c) 2015年 Test. All rights reserved.
//

#import "TableController.h"
#import "imageViewCell.h"
#import "usualViewCell.h"
#import "mainViewController.h"
#import "TitleViewController.h"
#import "AppDelegate.h"
@interface TableController ()
{
    AppDelegate* appDelegate;
    NSURLConnection *connection;
    
}

@end

@implementation TableController
@synthesize mainDelegate;
float DEVICE_WIDTH,DEVICE_HEIGHT;
- (void)viewDidLoad {
    [super viewDidLoad];
    DEVICE_WIDTH=[UIScreen mainScreen].bounds.size.width;
    DEVICE_HEIGHT=[UIScreen mainScreen].bounds.size.height;
    
    self.tableView=[[UITableView alloc]initWithFrame:
                    CGRectMake(0, 160, DEVICE_WIDTH, DEVICE_HEIGHT-35)];
    self.tableView.rowHeight=200;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    appDelegate = [UIApplication sharedApplication].delegate;

    
    // [self addChildViewController:titleCtr];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TitleViewController *tc=[[TitleViewController alloc]init];
    tc.navdelegate=self.mainDelegate;
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    //[self.navigationController.view.layer addAnimation:transition forKey:nil];
    [tc.view.layer addAnimation:transition forKey:nil];
    //使用AFHTTPRequestOperationManager发送GET请求
    [appDelegate.manager
     GET:@"http://192.168.31.195:8080/UEditorDemo/ueditorGet"
     parameters:nil // 指定无需请求参数
     // 获取服务器响应成功时激发的代码块
     success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         // 当使用HTTP响应解析器时，服务器响应数据被封装在NSData中
         NSLog(@"此处将NSData转换成NSString、并使用UIWebView将响应字符串显示出来");
         [tc.webView loadHTMLString:[[NSString alloc] initWithData:
                                                responseObject encoding:NSUTF8StringEncoding] baseURL:nil];
     }
     // 获取服务器响应失败时激发的代码块
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"获取服务器响应出错！");
     }];
    [self.navigationController pushViewController:tc animated:NO];


        NSString *paramURLAsString= @"http://192.168.31.195:8080/UEditorDemo/ueditorGet";
        if ([paramURLAsString length] == 0){
            NSLog(@"Nil or empty URL is given");
            return;
        }
        NSURLCache *urlCache = [NSURLCache sharedURLCache];
        /* 设置缓存的大小为1M*/
        [urlCache setMemoryCapacity:1*1024*1024];
        //创建一个nsurl
        NSURL *url = [NSURL URLWithString:paramURLAsString];
        //创建一个请求
        NSMutableURLRequest *request =
        [NSMutableURLRequest
         requestWithURL:url
         cachePolicy:NSURLRequestUseProtocolCachePolicy
         timeoutInterval:60.0f];
        //从请求中获取缓存输出
        NSCachedURLResponse *response =
        [urlCache cachedResponseForRequest:request];
        //判断是否有缓存
        if (response != nil){
            NSLog(@"如果有缓存输出，从缓存中获取数据");
            [request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
        }
         self->connection = nil;
        /* 创建NSURLConnection*/
        NSURLConnection *newConnection =
        [[NSURLConnection alloc] initWithRequest:request
                                        delegate:self
                                startImmediately:YES];
        self->connection = newConnection;
        //    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory,NSUserDomainMask, YES);
        //       NSString *docunmentsDirecyory=[paths objectAtIndex:0];
   
        //NSLog(@"%@",docunmentsDirecyory);
}
- (void)  connection:(NSURLConnection *)connection
      didReceiveResponse:(NSURLResponse *)response{
        NSLog(@"将接收输出");
}
- (NSURLRequest *)connection:(NSURLConnection *)connection
                 willSendRequest:(NSURLRequest *)request
                redirectResponse:(NSURLResponse *)redirectResponse{
        NSLog(@"即将发送请求");
        return(request);
}
- (void)connection:(NSURLConnection *)connection
        didReceiveData:(NSData *)data{
        NSLog(@"接受数据");
        NSLog(@"数据长度为 = %lu", (unsigned long)[data length]);
}
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                      willCacheResponse:(NSCachedURLResponse *)cachedResponse{
        NSLog(@"将缓存输出");
        return(cachedResponse);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
        NSLog(@"请求完成");
}
- (void)connection:(NSURLConnection *)connection
      didFailWithError:(NSError *)error{
        NSLog(@"请求失败");
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if(indexPath.row%3==0)
    {
        static NSString *ImageIdentifier=@"ImageIdentifier";
        cell=[tableView dequeueReusableCellWithIdentifier:ImageIdentifier];
        if(cell==nil)
        {
            cell=[[imageViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ImageIdentifier];
            
        }
    }
    else
    {
        
        static NSString *UsualIdentifier=@"UsualIdentifier";
        cell=[tableView dequeueReusableCellWithIdentifier:UsualIdentifier];
        if(cell==nil)
        {
            cell=[[usualViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UsualIdentifier];
        }
        
    }
    return cell;
}

@end
