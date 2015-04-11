//
//  TitleViewController.m
//  UIScroll1
//
//  Created by eddie on 15-3-31.
//  Copyright (c) 2015年 Test. All rights reserved.
//

#import "TitleViewController.h"
#import "AppDelegate.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import  "WXApi.h"
#import "WeiboSDK.h"
#import <RennSDK/RennSDK.h>
#import "ASINetworkQueue.h"
@interface TitleViewController ()
{
    UIViewController *wbVC;
    UIView *shareView;
    UIView *blackView;
    NSMutableArray *html;
    NSString* content;
}
@end

@implementation TitleViewController
@synthesize navdelegate;
@synthesize toolBar;
@synthesize btn;
@synthesize webView;
@synthesize isShow;
float DEVICE_WIDTH,DEVICE_HEIGHT;
bool isShow=YES;
struct PPoint{
    float x,y;
};
struct PPoint touch_Begin;
struct PPoint touch_Current;
struct PPoint touch_End;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
webView=[[TitleWebView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    webView.controlDelegate=self;
    [self.view addSubview: webView];
    DEVICE_WIDTH=[UIScreen mainScreen].bounds.size.width;
    DEVICE_HEIGHT=[UIScreen mainScreen].bounds.size.height;
    

    UIButton *discussBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 0, 80, 60)];
    [discussBtn setTitle:@"评论" forState:UIControlStateNormal];
    [discussBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [discussBtn addTarget:self action:@selector(discuss:) forControlEvents:UIControlEventTouchDown];
    UIButton *likeBtn=[[UIButton alloc]initWithFrame:CGRectMake(100 , 0, 80, 60)];
    [likeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [likeBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [likeBtn addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchDown];
    
    UIButton *shareBtn=[[UIButton alloc]initWithFrame:CGRectMake(190 , 0, 80, 60)];
    [likeBtn addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchDown];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchDown];
    btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTintColor:[UIColor blackColor]];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchDown];
   
    toolBar=[[UIToolbar alloc]init];
   
    [toolBar setFrame:CGRectZero];
    [toolBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    toolBar.layer.masksToBounds=YES;
    toolBar.layer.cornerRadius=6;
    toolBar.layer.borderWidth=1;
     [self.view addSubview:btn];
    [toolBar addSubview:likeBtn];
    [toolBar addSubview:discussBtn];
    [toolBar addSubview:shareBtn];
    [self.view addSubview:toolBar];
 
    NSLayoutConstraint *constraint=[NSLayoutConstraint constraintWithItem:toolBar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1   constant:0];
    [self.view addConstraint:constraint];
    
    constraint=[NSLayoutConstraint constraintWithItem:toolBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1   constant:0];
    [self.view addConstraint:constraint];
    constraint=[NSLayoutConstraint constraintWithItem:toolBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1   constant:0];
    [self.view addConstraint:constraint];
    constraint=[NSLayoutConstraint constraintWithItem:toolBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1   constant:-50];
    [self.view addConstraint:constraint];

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
//    [UIView animateWithDuration:0.5 animations:^{
//        if(isShow)
//        [btn setAlpha:0];
//        else
//            [btn setAlpha:1];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    touch_Begin.x=touchPoint.x;
    touch_Begin.y=touchPoint.y;
    
//    }];
    
}
-(void)discuss:(id)sender{
    NSLog(@"1");
    [activityIndicator startAnimating];
    //NSString *googleURL = @"http://www.weather.com.cn/data/cityinfo/101280101.html";
    NSString *googleURL = @"http://192.168.31.195:8080/UEditorDemo/ueditorGet";//在这里修改你的服务器地址
    NSURL *url = [NSURL URLWithString:googleURL];
    request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIHTTPRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    //[request startAsynchronous];
    [request setDelegate:self];
    [request startAsynchronous];
    [activityIndicator startAnimating];
    
}
-(void)requestFinished:(ASIHTTPRequest  *)request
{
    NSLog(@"11");
    [activityIndicator stopAnimating];
    // NSString *responseString =[request responseString];
    NSData *responseData =[request responseData];
     content = [[NSString alloc] initWithData:responseData
                                              encoding:NSUTF8StringEncoding];
    NSLog(@"%@",content);
    if (!networkQueue) {
        networkQueue = [[ASINetworkQueue alloc] init];
    }
    failed = NO;
    [networkQueue reset];
    //[networkQueue setDownloadProgressDelegate:_downloadProgress];
    [networkQueue setRequestDidFinishSelector:@selector(DownLoadComplete:)];
    [networkQueue setRequestDidFailSelector:@selector(DownLoadFailed:)];
    //[networkQueue setShowAccurateProgress:[accurateProgress isOn]];
    [networkQueue setDelegate:self];
    //在doc文件下创建保存文件夹
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"documentsDirectory%@",documentsDirectory);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"baidu"];
    
    // 创建目录
    [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    NSString * textpath=[testDirectory stringByAppendingPathComponent:@"1.txt"];
    
    [content writeToFile:textpath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [self saveNSUserDefaults];
    [networkQueue go];

}
- (void)DownLoadComplete:(ASIHTTPRequest *)request
{
    NSLog(@"download complete");
}

- (void)DownLoadFailed:(ASIHTTPRequest *)request
{
    if (!failed) {
        NSLog(@"download failed");
        failed = YES;
    }
}


-(void)like{
//    UIWebView *wbv=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 0.5*DEVICE_WIDTH, 0.5*DEVICE_HEIGHT)];
//    [wbVC.view addSubview:wbv];
//    [wbVC.view setBackgroundColor:[UIColor blackColor]];
//    UIButton *btnn=[[UIButton alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT*0.5, 80, 50)];
//    [btnn setTitle:@"返回" forState:UIControlStateNormal];
//    [wbVC.view addSubview: btnn];
//    [btnn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
//    [self.navigationController pushViewController:wbVC animated:YES];
    UIWebView *wbv=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    [wbv setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:wbv];
    
    
    
    NSLog(@"bookviewcontroller");
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"documentsDirectory%@",documentsDirectory);
    //NSFileManager *fileManager = [NSFileManager defaultManager];
   // NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"1.txt"];
    
        //UTF8编码方式解码
//        NSData *data = [NSData dataWithContentsOfFile:filePath];         NSString * textFile  = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"path:%@",filePath);
    //NSString * texfile=[ NSString stringWithContentsOfFile:testDirectory encoding:NSUTF8StringEncoding error:nil];
    //NSLog(@"%@",texfile);
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"1.text" ofType:nil];
//    NSLog(@"%@",path);
//    //NSURL *url = [NSURL fileURLWithPath:path];
//    
//    NSData *data = [NSData dataWithContentsOfFile:path];
//    NSLog(@"%@",data);
//
//    [wbv loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:nil];
//    NSURL *url=[NSURL fileURLWithPath:testDirectory];
//    NSLog(@"%@",url);
//    NSURLRequest * request1=[NSURLRequest requestWithURL:url];
//    self.webView.scalesPageToFit=YES;
//
//    [wbv loadRequest:request1];
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"1.txt" ofType:nil];
    NSString *path=[NSString stringWithFormat:@"%@/baidu/1.txt",documentsDirectory];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *str=[[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
    NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!%@",str);
    [wbv loadHTMLString:str baseURL:nil];
}
-(void)back{
    [wbVC.navigationController popViewControllerAnimated:YES];
    
    
}
#pragma localdata save
-(void)saveNSUserDefaults
{
    NSLog(@"111");
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:html forKey:@"baidu"];
    [userDefaults synchronize];
}

#pragma localdata load

-(void)readNSUserDefaults
{
    NSLog(@"1111");
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    html =[userDefaults objectForKey:@"baidu"];
    
    
    
}
-(void)share:(id)sender{
 
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
    
    //构造分享内容[webView.request url]
    id<ISSContent> publishContent = [ShareSDK content:@"jinyu"
                                       defaultContent:@"测试一下"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"document.title"
                                                  url:@"http://www.baidu.com"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    //    //定制人人网分享
    //    [publishContent addRenRenUnitWithName:NSLocalizedString(@"TEXT_HELLO_RENREN", @"Hello 人人网")
    //                              description:INHERIT_VALUE
    //                                      url:INHERIT_VALUE
    //                                  message:INHERIT_VALUE
    //                                    image:INHERIT_VALUE
    //                                  caption:nil];
    //
    //    //定制QQ空间分享
    //    [publishContent addQQSpaceUnitWithTitle:NSLocalizedString(@"TEXT_HELLO_QZONE", @"Hello QQ空间")
    //                                        url:INHERIT_VALUE
    //                                       site:nil
    //                                    fromUrl:nil
    //                                    comment:INHERIT_VALUE
    //                                    summary:INHERIT_VALUE
    //                                      image:INHERIT_VALUE
    //                                       type:INHERIT_VALUE
    //                                    playUrl:nil
    //                                       nswb:nil];
    //
    //    //定制微信好友内容
    //    [publishContent addWeixinSessionUnitWithType:INHERIT_VALUE
    //                                         content:NSLocalizedString(@"TEXT_HELLO_WECHAT_SESSION", @"Hello 微信好友!")
    //                                           title:INHERIT_VALUE
    //                                             url:INHERIT_VALUE
    //                                           image:INHERIT_VALUE
    //                                    musicFileUrl:INHERIT_VALUE
    //                                         extInfo:nil
    //                                        fileData:nil
    //                            emoticonData:nil];
    //    //定制微信朋友圈内容
    //    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInteger:SSPublishContentMediaTypeMusic]
    //                                          content:NSLocalizedString(@"TEXT_HELLO_WECHAT_TIMELINE", @"Hello 微信朋友圈!")
    //                                            title:INHERIT_VALUE
    //                                              url:INHERIT_VALUE
    //                                            image:INHERIT_VALUE
    //                                     musicFileUrl:INHERIT_VALUE
    //                                          extInfo:nil
    //                                         fileData:nil
    //                                     emoticonData:nil];
    //    //定制QQ分享内容
    //    [publishContent addQQUnitWithType:INHERIT_VALUE
    //                              content:@"Hello QQ!"
    //                                title:INHERIT_VALUE
    //                                  url:INHERIT_VALUE
    //                                image:INHERIT_VALUE];
    //
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    //自定义标题栏相关委托
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:NO
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    //自定义标题栏相关委托
    id<ISSShareOptions> shareOptions = [ShareSDK defaultShareOptionsWithTitle:@"Share"
                                                              oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                               qqButtonHidden:YES
                                                        wxSessionButtonHidden:YES
                                                       wxTimelineButtonHidden:YES
                                                         showKeyboardOnAppear:NO
                                                            shareViewDelegate:self
                                                          friendsViewDelegate:nil
                                                        picViewerViewDelegate:nil];
    //创建自定义分享列表
    NSArray* shareList = [ShareSDK getShareListWithType:
                          ShareTypeSinaWeibo,
                          ShareTypeRenren,
                          ShareTypeWeixiSession,
                          ShareTypeWeixiTimeline,
                          ShareTypeQQ,nil];
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"跬步"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    nil]];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
    
    
}
-(void)pop{
//    navController *nav=self.navdelegate;
//  
//    [nav popViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)sinaShare{
    
}
-(void)wechatShare{
    
}
-(void)wechatFriendsShare{
    
}
-(void)renrenShare{
    
}
-(void)qqShare{
    
}
-(void)qqZoneShare{
    
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
