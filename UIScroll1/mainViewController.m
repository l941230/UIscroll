//
//  mainViewController.m
//  UIScroll1
//
//  Created by eddie on 15-3-21.
//  Copyright (c) 2015年 Test. All rights reserved.
//

#import "mainViewController.h"
#import "PageScroll.h"
#import "rootViewController.h"
#import "navViews.h"
#import "navController.h"
#import "FindViewController.h"
typedef enum :NSInteger {
    
    kCameraMoveDirectionNone,
    
    kCameraMoveDirectionUp,
    
    kCameraMoveDirectionDown,
    
    kCameraMoveDirectionRight,
    
    kCameraMoveDirectionLeft
    
} CameraMoveDirection;
@interface mainViewController ()
{
    navViews *navView;
    UIButton *btn;
     CameraMoveDirection direction;
    UIView *sliderView;
    NSMutableArray  *tableViewArray;
    
}
@end

@implementation mainViewController
@synthesize navdelegate;
@synthesize scrol;
@synthesize oldButton;
CGFloat const gestureMinimumTranslation = 20.0;
float DEVICE_WIDTH,DEVICE_HEIGHT;


- (void)viewDidLoad {
  // UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
//    UIPanGestureRecognizer *res=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
//    [self.view addGestureRecognizer:res];
  //  [self.view  addGestureRecognizer:recognizer];
  
    // Do any additional setup after loading the view from its nib.
    DEVICE_WIDTH=[[UIScreen mainScreen]bounds].size.width;
    DEVICE_HEIGHT=[[UIScreen mainScreen]bounds].size.height;
    
  
 //   self.view setFrame:CGRectMake(0,
    // Do any additional setup after loading the view.
  
   navView=[[navViews alloc]initWithFrame:CGRectMake(0, 70, DEVICE_WIDTH, 30)];
    navView.delegate=self;
    
    oldButton= [navView.subviews objectAtIndex:0];
    [oldButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view setFrame:CGRectMake(0*DEVICE_WIDTH, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    
     scrol=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 105, DEVICE_WIDTH, DEVICE_HEIGHT-35)];
    [scrol setContentSize:CGSizeMake(6*DEVICE_WIDTH, DEVICE_HEIGHT-35)];
    scrol.bounces=YES;
    scrol.delegate=self;
    scrol.pagingEnabled=YES;
  
    scrol.showsVerticalScrollIndicator=NO;
     [scrol setContentOffset:CGPointMake(0, 0)];
    scrol.directionalLockEnabled=YES;
    sliderView=[[UIView alloc]initWithFrame:CGRectMake(0,100, DEVICE_WIDTH/6.0, 5)];
    sliderView.backgroundColor=[UIColor blueColor];
    sliderView.layer.masksToBounds=YES;
    sliderView.layer.cornerRadius=3.0;
tableViewArray=[[NSMutableArray alloc]init];
    for(int i=0;i<6;i++)
    {
//        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(i*DEVICE_WIDTH, 300, DEVICE_WIDTH, DEVICE_HEIGHT-120)];
        
        
         TableController *tableController=[[TableController alloc]init];
        PageScroll *parentScView=[[PageScroll alloc]initWithFrame:CGRectMake(i*DEVICE_WIDTH, 0, DEVICE_WIDTH, DEVICE_HEIGHT-35)];
        tableController.mainDelegate=self.navdelegate;
        UIScrollView *scView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 160)];
        scView.bounces=NO;
        scView.pagingEnabled=YES;
        parentScView.parentScrollDelegate=scrol;
        parentScView.bounces=NO;
        parentScView.showsVerticalScrollIndicator=NO;
        [scView setContentSize:CGSizeMake(DEVICE_WIDTH*2, 0)];
        [parentScView setContentSize:CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT+125)];
        [parentScView setContentOffset:CGPointMake(0, 160)];
        parentScView.tableDelegate=tableController;
        
       
        
    
        
        for (int j=0; j<6; j++)
        {
            UILabel *l=[[UILabel alloc]initWithFrame:CGRectMake(70*j, 10, 60, 30)];
            l.text=[NSString stringWithFormat:@"第%d个页面",j];
            [scView addSubview:l];
            
        }
        [tableViewArray addObject:tableController.tableView];
        //        [tableViewArray addObject:view];
        
            [parentScView addSubview:tableController.tableView];
        [parentScView addSubview:scView];
    
       [scrol addSubview:parentScView];
        [self addChildViewController:tableController];

                    }
  //[self.navigationController.navigationBar=
    UINavigationBar *bar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 60)];
    
    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    leftBtn.layer.cornerRadius=20;
    [leftBtn setBackgroundColor:[UIColor blackColor]];
    [leftBtn addTarget:self action:@selector(scroll) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
  
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self  action:@selector(pushFindView)];
    UINavigationItem *item=[[UINavigationItem alloc]init];
    
    
    [bar setBackgroundColor:[UIColor purpleColor]];
    UIImageView *titleLogoView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIImage *logoImage=[UIImage imageNamed:@"logo.png"];
    
    [titleLogoView setImage:logoImage];
    
   
    item.titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    item.rightBarButtonItem=rightItem;
    [item setLeftBarButtonItem:leftItem];
  [item.titleView addSubview: titleLogoView];
    
    [bar pushNavigationItem:item animated:YES];
   [self.view addSubview:navView];
    
   [self.view addSubview:sliderView];
  [self.view addSubview:scrol];
    [self.view addSubview:bar];
    
    
 [scrol addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld context:nil];
    
    
    
    
    }
-(void)pushFindView{
    FindViewController *findCtr=[[FindViewController alloc]init];
    [self.navigationController pushViewController:findCtr animated:NO];
}
-(void)scroll{
    navController *nan=  self.navdelegate;
    rootViewController *root=nan.delegateroot;
    [root scrollToMenu];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if(scrol.contentOffset.x>0)
    [sliderView setFrame:CGRectMake(scrol.contentOffset.x/6, 100, DEVICE_WIDTH/6.0, 5)];
    int i=(int)(scrol.contentOffset.x/DEVICE_WIDTH+0.5);
    [oldButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    oldButton=[navView.views objectAtIndex:i];
      [oldButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

}


/*
- (void)handleSwipe:(UIPanGestureRecognizer *)gesture
{
    
    CGPoint translation = [gesture translationInView:self.view];
    
    if (gesture.state ==UIGestureRecognizerStateBegan)
        
    {
        
        direction = kCameraMoveDirectionNone;
        
    }
    
    else if (gesture.state == UIGestureRecognizerStateChanged && direction == kCameraMoveDirectionNone)
        
    {
        
        direction = [self determineCameraDirectionIfNeeded:translation];
        
    }
        // ok, now initiate movement in the direction indicated by the user's gesture
    
    else if (gesture.state == UIGestureRecognizerStateEnded)
        
    {
        
        // now tell the camera to stop
//        
//        if(root.scView.contentOffset.x<0.7*DEVICE_WIDTH)
//        {
//            [root scroll];
//            // NSLog(@"scroll");
//            
//            
//        }
//        else {
//            [root returnMain];
//        }
        NSLog(@"Stop");
        direction=kCameraMoveDirectionNone;

    }
        switch (direction) {
                
            case kCameraMoveDirectionDown:
                
                NSLog(@"Start moving down");
                
                break;
                
            case kCameraMoveDirectionUp:
                
                NSLog(@"Start moving up");
                
                break;
                
            case kCameraMoveDirectionRight:
            {
                NSLog(@"Start moving right");
              
              
                
          }
                break;
                
            case kCameraMoveDirectionLeft:
                
                
                
                
                break;
                
            default:
                
                break;
                
        }
        
    
    

}


- (CameraMoveDirection) determineCameraDirectionIfNeeded:(CGPoint)translation
{
    
    if (direction != kCameraMoveDirectionNone)
        
        return direction;
        if (fabs(translation.x) > gestureMinimumTranslation)
        
    {
        
        BOOL gestureHorizontal = NO;
        
        if (translation.y ==0.0)
            
            gestureHorizontal = YES;
        
        else
            
            gestureHorizontal = (fabs(translation.x / translation.y) >5.0);
        
        if (gestureHorizontal)
            
        {
            
            if (translation.x >0.0)
                
                return kCameraMoveDirectionRight;
            
            else
                
                return kCameraMoveDirectionLeft;
            
        }
        
    }
    
    // determine if vertical swipe only if you meet some minimum velocity
    
    else if (fabs(translation.y) > gestureMinimumTranslation)
        
    {
        
        BOOL gestureVertical = NO;
        
        if (translation.x ==0.0)
            
            gestureVertical = YES;
        
        else
            
            gestureVertical = (fabs(translation.y / translation.x) >5.0);
        
        if (gestureVertical)
            
        {
            
            if (translation.y >0.0)
                
                return kCameraMoveDirectionDown;
            
            else
                
                return kCameraMoveDirectionUp;
            
        }
        
    }
    
    return direction;
    
}
*/

-(void)didReceiveMemoryWarning {
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
