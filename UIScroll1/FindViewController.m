//
//  FindViewController.m
//  UIScroll1
//
//  Created by eddie on 15-4-2.
//  Copyright (c) 2015年 Test. All rights reserved.
//

#import "FindViewController.h"
#import "FindType_2.h"
#import "FIndType_3.h"
#import "ButtonCell.h"
@interface FindViewController ()
{
   // NSMutableArray *rootFindType;
    NSMutableArray *type1;
    NSMutableArray *Type1;
    NSMutableArray *Type2;
    NSMutableArray *Type3;
    NSMutableArray *Type4;
    NSMutableArray *Type5;
    NSMutableArray *Type6;
    FindType_2 *find2;
    NSMutableArray *subArray;
    FIndType_3 *find3;
    NSMutableArray *intrestArray;
     NSMutableArray *intresStringtArray;
    UITableView *tableview;
    UITableView *intrestTableView;
    BOOL isFilter;
    NSMutableArray *filterArray;
    NSMutableArray *allType3Array;
      NSMutableArray *allType3StringArray;
    NSMutableArray *searchTypeArray;
}
@end

@implementation FindViewController
@synthesize rootDelegate;
float DEVICE_WIDTH,DEVICE_HEIGHT;
- (void)viewDidLoad {
    [super viewDidLoad];
    DEVICE_WIDTH=[UIScreen mainScreen].bounds.size.width;
    DEVICE_HEIGHT=[UIScreen mainScreen].bounds.size.height;
    // Do any additional setup after loading the view.
    UINavigationBar *navBar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 60)];
    UINavigationItem *item=[[UINavigationItem alloc]init];
    UIBarButtonItem *leftBtn=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self     action:@selector(popself)];
    item.leftBarButtonItem=leftBtn;
    [navBar pushNavigationItem:item animated:NO];
    [self.view addSubview:navBar];
    
    
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 200, DEVICE_WIDTH, DEVICE_HEIGHT-200) style:UITableViewStyleGrouped];
    tableview.rowHeight=70;
    tableview.dataSource=self;
    tableview.delegate=self;
    tableview.tag=101;
    
    [self.view addSubview:tableview];
    
    
    UISearchBar *searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 60, DEVICE_WIDTH, 40)];
    searchBar.delegate=self;
    searchBar.showsCancelButton=YES;
    isFilter=false;
    
    for(UIView *view in [searchBar.subviews[0] subviews])
    {
        if([view isKindOfClass:[UIButton class]])
        {
            UIButton *cancelBtn=(UIButton *)view;
            [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
    
    [self.view addSubview:searchBar];
    
    

        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  //  NSString *plistpath=[[NSBundle allBundles]pathForResource:@"root" ofType:@"plist"];
      NSString *documentsDirectory=[paths objectAtIndex:0];
    NSString *allTypePath=[NSString stringWithFormat:@"%@/Type.data",documentsDirectory];
    NSString *intrestTypePath=[NSString stringWithFormat:@"%@/intrestType1.data",documentsDirectory];

    
    
    
    NSMutableArray *type2=[[NSMutableArray alloc]init];
    for (int j=0; j<3; j++)
    {
        FindType_2 *find_2=[[FindType_2 alloc]init];
        [find_2 setName:[NSString stringWithFormat:@"第%d个二级分类",j]];
        
        find_2.subArray=[[NSMutableArray alloc]init];
    
    for (int i=0; i<5; i++)
     {
        FIndType_3 *find_3=[[FIndType_3 alloc]init];
        [find_3 setName:[NSString stringWithFormat:@"第%d个二级分类中的第%d个三级",j,i]];
        [find_3 setIsIntrest:NO];
        [find_2.subArray addObject:find_3];
         find_3.parentFind_2Delegate=find_2;
     }
        [type2 addObject:find_2];
    }
    
  bool is=[NSKeyedArchiver archiveRootObject:type2 toFile:allTypePath];
    NSLog( @"%@",is?@"yes":@"no");
    
    
    
    type1=[NSKeyedUnarchiver unarchiveObjectWithFile:allTypePath];
    allType3Array=[[NSMutableArray alloc]init];
    allType3StringArray=[[NSMutableArray alloc]init];
    intresStringtArray=[[NSMutableArray alloc]init];
    searchTypeArray=[[NSMutableArray alloc]init];
    if([[NSFileManager defaultManager] fileExistsAtPath:intrestTypePath]){
         intrestArray=[NSKeyedUnarchiver unarchiveObjectWithFile:intrestTypePath];
        for (int i=0;i<intrestArray.count;i++)
        {
         find3=   [intrestArray objectAtIndex:i];
            [intresStringtArray addObject:find3.name];
        }
    }
    else{
        intrestArray=[[NSMutableArray alloc]init];
    }
  
    

    
    for (int i=0; i<type1.count; i++) {
        find2=[type1 objectAtIndex:i];
        for (int j=0; j<[find2.subArray count]; j++) {
            find3=[find2.subArray objectAtIndex:j];
            [allType3Array addObject:find3];
            [allType3StringArray addObject:find3.name];
        }
    }
    [allType3Array addObjectsFromArray:intrestArray];
    [allType3StringArray addObjectsFromArray:intresStringtArray];
    
}
-(void)popself
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(!isFilter)
    {
    if(section !=0)
        {
    FindType_2 *find_2=[type1 objectAtIndex:section-1];
    NSArray *array=find_2.subArray;
      
        return array.count;
        
        }
    
    else
        {
        
        return intrestArray.count;
        }
    }
    else
        return searchTypeArray.count;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (isFilter) {
        return 1;
        
    }
    else
    {
    NSInteger count1=type1.count+1;
    
    return count1;
    }
    
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!isFilter)
    {
        
    

        if(indexPath.section!=0){
    FindType_2 *find_2=[type1 objectAtIndex:(indexPath.section-1)];
    FIndType_3 *find_3=[find_2.subArray objectAtIndex:indexPath.row];
    UITableViewCell *cell;
    
    
        static NSString *FindAllIdentifier=@"FindAllIdentifier";
        cell=[tableView dequeueReusableCellWithIdentifier:FindAllIdentifier];
        if(cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:FindAllIdentifier];
            
        }
    cell.textLabel.textColor=[UIColor blackColor];
    cell.textLabel.text=find_3.name;
   ButtonCell  *btn=[[ButtonCell alloc]initWithFrame:CGRectMake(0, 5, 120, 60)];
    
    [btn setTitle:@"未关注" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addcell:) forControlEvents:UIControlEventTouchDown];
    btn.cellDelegate=cell;
    btn.findType_2Delegate=find_2;
    btn.findType_3Delegate=find_3;
    
    cell.accessoryView=btn;
    
  
    return cell;
    }
    else
    {
        UITableViewCell *cell;
        FIndType_3 *find_3=[intrestArray objectAtIndex:indexPath.row];
        
        static NSString *FindInterestIdentifier=@"FindInterestAllIdentifier";
        cell=[tableView dequeueReusableCellWithIdentifier:FindInterestIdentifier];
        if(cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:FindInterestIdentifier];
            
        }
        cell.textLabel.textColor=[UIColor blackColor];
        cell.textLabel.text=find_3.name;
        ButtonCell  *btn=[[ButtonCell alloc]initWithFrame:CGRectMake(0, 5, 120, 60)];
        
        [btn setTitle:@"已关注" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(removecell:) forControlEvents:UIControlEventTouchDown];
        btn.cellDelegate=cell;
       
        btn.findType_3Delegate=find_3;
        
        cell.accessoryView=btn;
        
        
        return cell;

    }
        
    }
    else
    {
       // FindType_2 *find_2=[type1 objectAtIndex:(indexPath.section-1)];
      //  FIndType_3 *find_3=[find_2.subArray objectAtIndex:indexPath.row];
        find3=[searchTypeArray objectAtIndex:indexPath.row];
        UITableViewCell *cell;
        
        
        static NSString *FindAdapterIdentifier=@"FindAdapterIdentifier";
        cell=[tableView dequeueReusableCellWithIdentifier:FindAdapterIdentifier];
        if(cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:FindAdapterIdentifier];
            
        }
        cell.textLabel.textColor=[UIColor blackColor];
        cell.textLabel.text=find3.name;
        ButtonCell  *btn=[[ButtonCell alloc]initWithFrame:CGRectMake(0, 5, 120, 60)];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.cellDelegate=cell;
        //   btn.findType_2Delegate=find_2;
        btn.findType_3Delegate=find3;
        
        if(find3.isIntrest==YES)
        {
        [btn setTitle:@"已关注" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(concentrate:) forControlEvents:UIControlEventTouchDown];
        }
        else
        {
            [btn setTitle:@"未关注" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(concentrate:) forControlEvents:UIControlEventTouchDown];
        }
       
        cell.accessoryView=btn;
        
        
        return cell;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(!isFilter)
    {
    if(section!=0)
    {
     FindType_2 *find_2=[type1 objectAtIndex:
                         (section-1)];
    
    return find_2.name;
    }
    else
        return  @"我的关注";
    }
    else
        return @"";
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(void)addcell:(ButtonCell *) buton{
    FIndType_3 *find_3=buton.findType_3Delegate;
    FindType_2 *find_2=find_3.parentFind_2Delegate;
    [find_2.subArray removeObject:find_3];
    [intrestArray addObject:find_3];
    
    [find_3 setIsIntrest:YES];
//    NSLog(@"%@",find_3.isIntrest?@"yes":@"no");
//    NSLog(@"addcell");
    [tableview reloadData];
    
}
-(void)removecell:(ButtonCell *) buton
{
    
    FindType_2 *find_2=buton.findType_2Delegate;
    FIndType_3 *find_3=buton.findType_3Delegate;
   
    
    [find_2.subArray addObject:find_3];
    [intrestArray removeObject:find_3];
    find_3.isIntrest=NO;
    [tableview reloadData];
    
}
-(void)concentrate:(ButtonCell *) buton
{
    FIndType_3 *find_3=buton.findType_3Delegate;
    if(find_3.isIntrest)
    {
        find_3.isIntrest=NO;
        FindType_2 *find_2=find_3.parentFind_2Delegate;
        [find_2.subArray removeObject:find_3];
        [intrestArray addObject:find_3];
        [buton setTitle:@"未关注" forState:UIControlStateNormal];
    }
    else
    {
        find_3.isIntrest=YES;
        FindType_2 *find_2=find_3.parentFind_2Delegate;
        [find_2.subArray addObject:find_3];
        [intrestArray removeObject:find_3];
        [buton setTitle:@"已关注" forState:UIControlStateNormal];
    }
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
   
    if(searchText.length==0)
    {
        isFilter=NO;
         [searchTypeArray removeAllObjects];
        [tableview reloadData];
    }
    else
    {
        isFilter=YES;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                  @"self contains [c] %@", searchBar.text];
        NSArray *arr=  [allType3StringArray filteredArrayUsingPredicate:predicate];
        for(int i;i<arr.count;i++)
        {
            NSString *adaptString=[arr objectAtIndex:i];
            NSInteger adaptIndex=  [allType3StringArray indexOfObject:adaptString];
            find3=[allType3Array objectAtIndex: adaptIndex];
            [searchTypeArray addObject:find3];
            
            
        }
        [tableview reloadData];
        
    }
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [searchTypeArray removeAllObjects];
    
}
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
