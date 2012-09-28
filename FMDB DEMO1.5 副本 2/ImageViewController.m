//
//  ImageViewController.m
//  Ratings
//
//  Created by Ibokan on 12-9-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImageViewController.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"
#import "ImageViewDetailController.h"
@implementation ImageViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


-(FMDatabase *) openDatabase
{
    
    //寻找路径
    NSString *doc_path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    //数据库路径
    NSString *sqlPath=[doc_path stringByAppendingPathComponent:@"ad.sqlite"];
    NSLog(@"%@",sqlPath);
    
    //原始路径
    NSString *orignFilePath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"sqlite"];
    
    NSLog(@"原始地址:%@",orignFilePath);
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if([fm fileExistsAtPath:sqlPath] == NO)//如果doc下没有数据库，从bundle里面拷贝过来
    {
        
        
        NSError *err = nil;
        if([fm copyItemAtPath:orignFilePath toPath:sqlPath error:&err] == NO)//如果拷贝失败
        {
            NSLog(@"open database error %@",[err localizedDescription]);
            return nil;
        }
        
        NSLog(@"document 下没有数据库文件，执行拷贝工作");
    }
    
    
    
    
    
    //初始化数据库
    FMDatabase *db=[FMDatabase databaseWithPath:sqlPath];
    
    //这个方法一定要执行
    if (![db open]) {
        NSLog(@"数据库打开失败！");
        return db;
    }
    
    
    NSLog(@"打开成功");
    NSLog(@"db=%@",db);
    return  db;
}

- (void) initData{
    
    FMDatabase *db=[self openDatabase];
    
    
    //    [db executeUpdate:@"drop table imageName"];
    
    if ([db tableExists:@"imageName"]) {
        NSLog(@"图片表已存在");
    } 
    else{
        NSLog(@"不存在");
        if ([db executeUpdate:@"CREATE TABLE imageName(id integer primary key AUTOINCREMENT  NOT NULL  UNIQUE,name text,image blob)"]) 
        {
            
            NSLog(@"图片表成功创建");
        }
        
        for (int i=1; i<=9; i++) {
            NSString *path=[[NSBundle mainBundle] pathForResource: [NSString stringWithFormat:@"%d",i] ofType:@"jpg"];
            
            NSLog(@"i=%d",i);
            NSData *data=[NSData dataWithContentsOfFile:path];
            
            NSString *name=[NSString stringWithFormat:@"图片%d",i];
            
            BOOL su=[db executeUpdate:@"insert into imageName(name,image) values (?,?)",name,data];
            if (su) {
                NSLog(@"插入成功");
            }
            
            
            
        }  
        
        
        
    }
    
    FMResultSet *set=[db executeQuery:@"select * from imageName"];
    
    while ([set next]) {
        
        
        NSLog(@"查询成功");
        
        NSData *tmp=[set dataForColumn:@"image"];
        
        NSString *name=[set stringForColumnIndex:1];
        NSLog(@"name=%@",name);
        
        [imageArray addObject:name];
        if (tmp) {
            [imageDataArray addObject:tmp];
            
            NSLog(@"添加图片数据成功");
        }
        
        
        
        
    }  
    
    
    NSLog(@"图片名字=%d",[imageArray count]);
    NSLog(@"图片数据=%d",[imageDataArray count]);
    
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    imageArray=[[NSMutableArray alloc] init];
    imageDataArray=[[NSMutableArray alloc] init];
   
    selectItem=0;
    [super viewDidLoad];
    
    
    [self initData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [imageArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell"];
    //    if (cell == nil) {
    //        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    //    }
    
    // Configure the cell...
    
    cell.textLabel.text=[imageArray objectAtIndex:indexPath.row];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    selectItem=indexPath.row;
    NSLog(@"选择的行 为：%d",selectItem);
    

}


//利用这个可以传值操作，彻底解放tableView，操作
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    
    if ([segue.identifier isEqualToString:@"imageDetail"]) {
        
        NSLog(@"用户选择的行为：%d",selectItem);
        NSLog(@"segue 匹配成功");
        
        NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
        
        NSLog(@"使用indexPathForSelectedRow得到的用户选择行为是：%d",indexPath.row);
        
        
        //使用这个方法传值，不需要再使用didSelect 方法传值了，关键地方是获得用户的当前选择行为，而indexPathForSelectedRow完美解决了这一个问题，
        ImageViewDetailController *con=[segue destinationViewController];
        
        NSData *image=[imageDataArray objectAtIndex:indexPath.row];
        tmpImage=[[UIImage alloc] initWithData:image];
        con.image=tmpImage;
        [tmpImage release];
        NSLog(@"赋值成功");
    }
    
    
    
    
}

@end
