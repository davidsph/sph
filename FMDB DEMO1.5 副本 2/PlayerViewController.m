//
//  PlayerViewController.m
//  Ratings
//
//  Created by Ibokan on 12-9-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PlayerViewController.h"
#import "Player.h"
#import "DetailViewController.h"
#import "DetailViewController.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"
#import "CeshiViewController.h"
@implementation PlayerViewController


@synthesize searchBar;
@synthesize players;

- (id) initWithCoder:(NSCoder *)aDecoder{
    
    if (self=[super initWithCoder:aDecoder]) {
        
        count=0;
        
        NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
        
        NSLog(@"初始化方法");
        
    }
    
    return  self;
}

- (id) init
{
    
    self=[super init];
    
    if (self) {
        NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    }
    return self;
}


//dealloc方法
-(void) dealloc{
    //释放对象
    [players release ];
    [databaseArray release];
    
    NSLog(@"第一个页面被卸载了");
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    //调用父类dealloc方法
    [searchBar release];
    [super dealloc];
};

- (id)initWithStyle:(UITableViewStyle)style
{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
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

//这是不用数据时，加载数据的方法
/*
 - (void) initPlayersData{
 
 players = [[NSMutableArray alloc] init];
 Player *player1 = [[Player alloc] init];
 player1.name = @"Bill Evans";
 player1.game = @"Tic-Tac-Toe";
 player1.rating = 4;
 [players addObject:player1];
 [player1 release];
 
 Player *player2 = [[Player alloc] init];
 player2 = [[Player alloc] init];
 player2.name = @"Oscar Peterson";
 player2.game = @"Spin the Bottle";
 player2.rating = 5;
 [players addObject:player2];
 [player2 release];
 
 Player *player3 = [[Player alloc] init];
 player3 = [[Player alloc] init];
 player3.name = @"Dave Brubeck";
 player3.game = @"Texas Hold’em Poker";
 player3.rating = 2;
 [players addObject:player3];
 [player3 release];
 
 Player *player4 = [[Player alloc] init];
 player4 = [[Player alloc] init];
 player4.name = @"Dave Brubeck";
 player4.game = @"Texas Hold’em Poker";
 player4.rating = 2;
 [players addObject:player4];
 [player4 release]; 
 
 Player *player5 = [[Player alloc] init];
 player5 = [[Player alloc] init];
 player5.name = @"Dave Brubeck";
 player5.game = @"Texas Hold’em Poker";
 player5.rating = 2;
 [players addObject:player5];
 [player5 release];
 
 Player *player6 = [[Player alloc] init];
 player6 = [[Player alloc] init];
 player6.name = @"Dave Brubeck";
 player6.game = @"Texas Hold’em Poker";
 player6.rating = 2;
 [players addObject:player6];
 [player6 release];
 
 
 
 Player *player7 = [[Player alloc] init];
 player7 = [[Player alloc] init];
 player7.name = @"Dave Brubeck";
 player7.game = @"Texas Hold’em Poker";
 player7.rating = 2;
 [players addObject:player7];
 [players addObject:player7];
 [players addObject:player7];
 [players addObject:player7];
 [players addObject:player7];
 [players addObject:player7];
 [players addObject:player7];
 [players addObject:player7];
 [players addObject:player7];
 
 [player7 release];
 
 
 
 }
 */

#pragma mark -
#pragma mark 打开数据库
-(FMDatabase *) openDatabase
{
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    //寻找路径
    NSString *doc_path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    //数据库路径
    NSString *sqlPath=[doc_path stringByAppendingPathComponent:@"ad.sqlite"];
    NSLog(@"%@",sqlPath);
    
    //原始路径
    NSString *orignFilePath = [[NSBundle mainBundle] pathForResource:@"ad" ofType:@"sqlite"];
    
    NSLog(@"原始地址:%@",orignFilePath);
    
//    NSFileManager *fm = [NSFileManager defaultManager];
//    if([fm fileExistsAtPath:sqlPath] == NO)//如果doc下没有数据库，从bundle里面拷贝过来
//    {
//        
//        
//        NSError *err = nil;
//        if([fm copyItemAtPath:orignFilePath toPath:sqlPath error:&err] == NO)//如果拷贝失败
//        {
//            NSLog(@"open database error %@",[err localizedDescription]);
//            return nil;
//        }
//        
//        NSLog(@"document 下没有数据库文件，执行拷贝工作");
//    }
    
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


#pragma mark -
#pragma mark 初始化数据
//初始化数据，即从数据库加载数据
- (void) findAllPlayers
{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    FMDatabase *db=[self openDatabase];
    
    //删除旧的
    [databaseArray removeAllObjects];
    NSLog(@"数据库地址为：%p",db);
    
    
    if ([db tableExists:@"player"]) {
        NSLog(@"表已存在！！");
    } else{
        
        [db executeUpdate:@"CREATE TABLE player(id integer primary key AUTOINCREMENT  NOT NULL  UNIQUE ,name text,game text,ratingPic text)"];
        
        NSLog(@"创建一个新表");
    }
    
    
    
    FMResultSet *resultSet=[db executeQuery:@"select * from player"];
    
    
    
    NSLog(@"查询到的结果集%@",resultSet);
    NSLog(@"几列=%d",[resultSet columnCount]);
    NSLog(@"name列的下标=%d",[resultSet columnIndexForName:@"name"]);
    NSLog(@"错误信息：%@ 行数%d",[db lastErrorMessage], [db lastErrorCode]);
    
    while ([resultSet next])
    {
        
        Player *player=[[Player alloc] initWithName:[resultSet stringForColumnIndex:1] andGame:[resultSet stringForColumnIndex:2] andRatingPic:[resultSet stringForColumnIndex:3] andID:[resultSet intForColumnIndex:0]];
        NSLog(@"查询到的数据：%@",player);
        
        
        [databaseArray addObject:player];
        [player release];
        
        
    }
    
    
    
    NSLog(@"查找成功");
    [db close];
    
}


#pragma mark - View lifecycle

- (void) viewWillAppear:(BOOL)animated{
    
    
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    [super viewWillAppear:YES];
}

- (void) viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
}
- (void)viewDidLoad
{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    databaseArray=[[NSMutableArray alloc] init];
    filterArray=[[NSMutableArray alloc] init];
    
    count=0;
    
    
    //开始时从数据库，加载数据
    [self findAllPlayers];
   
    imageArray=[[NSArray alloc] initWithObjects:[UIImage imageNamed:@"11.jpg"],[UIImage imageNamed:@"12.jpg"],[UIImage imageNamed:@"13.jpg"] ,nil];
    
    //    [self initPlayersData];
    [super viewDidLoad];
    
}

- (void)viewDidUnload
{
    [self setSearchBar:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    
    //如果是选手视图
    if (tableView==self.tableView) {
        NSLog(@"行数为：%d",[databaseArray count]);
        return [databaseArray count];
    }
    //如果是查询视图
    else{
        
        FMDatabase *dbase=[self openDatabase];
        
        FMResultSet *re=nil;
        if ([dbase tableExists:@"player"]) {
            NSLog(@"存在表，可继续查询A！！");
            
            NSString *sql=[NSString stringWithFormat:@"select DISTINCT * from player where name like '%@%%'",self.searchBar.text];
            NSLog(@"sql=%@",sql);
            NSLog(@"查询词为：%@",self.searchBar.text);
            re=[dbase executeQuery:sql];
            
        }
        //这是关键 添加之前要删除之前的数据，否则会重复添加
        [filterArray removeAllObjects];
        
        while ([re next]) {
            Player *tmpPlayer1=[[Player alloc ] init];
            tmpPlayer1.name=[re stringForColumn:@"name"];
            tmpPlayer1.game=[re stringForColumn:@"game"];
            tmpPlayer1.ratingPic=[re stringForColumn:@"ratingPic"];
            NSLog(@"name=%@",tmpPlayer1.name);
            NSLog(@"game=%@",tmpPlayer1.game);
            [filterArray addObject:tmpPlayer1];
            NSLog(@"添加到查询数组成功");
            [tmpPlayer1 release];
            
        }
        NSLog(@"count =%d",[filterArray count]);
        return  [filterArray count];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PlayerCell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PlayerCell"];
    }
    
    
    UILabel *nameLabel=(UILabel *)[cell viewWithTag:100];
    UILabel *gameLabel=(UILabel *) [cell viewWithTag:101];
    UIImageView *ratingView=(UIImageView *)[cell viewWithTag:102];
    
    Player *player=nil;
    
    if (tableView==self.tableView) {
        //以下是 自定义实现
        player=[databaseArray objectAtIndex:indexPath.row];
        NSLog(@"显示数据列表");
        nameLabel.text=player.name;
        gameLabel.text=player.game;
        UIImage *ratingImage=[UIImage imageNamed:player.ratingPic];
        ratingView.image=ratingImage;
        
        
    }
    //查询视图
    else{
        
        NSLog(@"查询数据列表");
        
        player=[filterArray objectAtIndex:indexPath.row];
        cell.textLabel.text=player.name;
        cell.detailTextLabel.text=player.game;
        
    }
    
    return  cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        Player *p= [databaseArray objectAtIndex:indexPath.row];
        int selectID=p.ID;
        
        //        NSString *name=p.name;
        //打开数据库
        FMDatabase *db=[self openDatabase];
        
        //以id为主键删除数据
        if([db executeUpdate:@"delete from player where id=?",[NSNumber numberWithInt:selectID]])               
        {
            
            NSLog(@"删除成功");
            
            
        }
        
        
        //删除选定的选手的数据
        [databaseArray removeObjectAtIndex:indexPath.row];
        
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [db close];
        [self.tableView reloadData];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //传值的时候，这个方法什么也不做
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSLog(@"所选的行数为%d",indexPath.row);
    
}


#pragma mark -
#pragma mark DetailViewController delegate ****添加操作

//添加player成功后执行的方法，保存到数据库，更新视图
- (void) detailViewConrtrollerDidSave:(DetailViewController *)controller DidAddPlayer:(Player *)player{
    
    
    //用填写的相关信息，再新建一个player实例，然后加入到表格的数据源中
    //    [self.players addObject:player];
    count++;
    
    NSLog(@"count=%d",count);
    
    //显示更新的数目
    
    self.tabBarItem.badgeValue=[NSString stringWithFormat:@"%d",count];
    
    
    UITabBarItem *item=(UITabBarItem *)[self.view viewWithTag:500];
    item.badgeValue=[NSString stringWithFormat:@"%d",count];
    
    
    
    [databaseArray addObject:player];
    
    FMDatabase *db=[self openDatabase];
    
    if ( [db executeUpdate:@"insert into player(name,game,ratingPic) values(?,?,?)",player.name,player.game,player.ratingPic]) 
    {
        NSLog(@"插入成功");    
    }
    
    [db close];
    
    
    [self.tableView reloadData];
    
   NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"传递后已成功执行操作");
    
}

//协议中的 方法,点击取消进行的操作，此处为，什么也不做，直接返回到主场景中
- (void) detailViewConrtrollerDidCancel:(DetailViewController *)controller{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    //调用这个语句，将会使self这个控制器
    [controller dismissViewControllerAnimated:YES completion:nil];    
    
}

#pragma mark -
#pragma mark 准备场景****************实现代理的指定，以及传值
//这行是将要显示目标Controller之前要调用的代码，通知源Controller要跳转到那个位置
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
       NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    //寻找特定的segue，然后找到我们的Controller
    if ([segue.identifier isEqualToString:@"AddPlayer"]) {
        
        //找到segue的目标控制器
        UINavigationController *controller=segue.destinationViewController;
        //这个例子中目标控制器的控制的第一个控制器即为我们的详细信息控制器
        DetailViewController *detailViewController=[[controller viewControllers] objectAtIndex:0];
        
        //将找到的控制器的代理指定为本类的实例
        detailViewController.delegate=self;
        
    }
    if ([segue.identifier isEqualToString:@"ShowPlayer"]) {
        
        NSLog(@"执行showPlayer场景");
        
        UINavigationController *controller=[segue destinationViewController];
        
        CeshiViewController *ceshiViewController=[[controller viewControllers] objectAtIndex:0];
        //获取用户当前的选择
        NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
        //将代理指向本类
        ceshiViewController.delegate=self;
        
               
        //待传的值
        
        tmpPlayer=[[Player alloc] init];
        
        tmpPlayer= [databaseArray objectAtIndex:indexPath.row];
        
        NSLog(@"待传值=%@",tmpPlayer);
        NSLog(@"用户选择的play ID = %d",tmpPlayer.ID);
        NSLog(@"用户选择的name=%@",tmpPlayer.name);
        NSLog(@"用户选择的game=%@",tmpPlayer.game);
        
        //传值
        ceshiViewController.player=tmpPlayer;
        [tmpPlayer release];
        
               
    }
    
}



#pragma mark -
#pragma mark 搜索代理

//结束搜索后执行的方法
- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    [filterArray removeAllObjects];
    
}


//将要开始搜索时执行的方法
-(void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    [filterArray removeAllObjects];
}

#pragma mark -
#pragma mark ceshi代理方法 ********保存更新后的数据库，以及更新视图


//用户修改后的保存操作
- (void) CeshiViewControllerDidSaveWhenEditing:(CeshiViewController *)controller DidSavePlayer:(Player *)player{
    
    NSLog(@"执行更新数据库操作");
    
    FMDatabase *db=[self openDatabase];
    
    
    if([db executeUpdate:@"update player set name = ? ,game = ? where id=?",player.name,player.game,[NSNumber numberWithInt:player.ID]])
    {
        
        NSLog(@"数据库修改成功");
        
    [self findAllPlayers];
        
     [self.tableView reloadData];
    }
    else{
        
        NSLog(@"修改失败");
    }
     
    [controller dismissModalViewControllerAnimated:YES];
    
    
}
@end
