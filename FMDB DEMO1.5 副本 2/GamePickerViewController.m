//
//  GamePickerViewController.m
//  Ratings
//
//  Created by Ibokan on 12-9-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GamePickerViewController.h"


@implementation GamePickerViewController

@synthesize game;
@synthesize delegate;

- (id) initWithCoder:(NSCoder *)aDecoder{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    self=[super initWithCoder:aDecoder];
    if (self) {
        
    }
    
    return  self;
}


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

-(void) dealloc{
    
    [games release];
    [game release];
    games=nil;
    game=nil;
    
    
    [super dealloc];
    
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    [super viewDidLoad];
       
    NSLog(@"索引为=%d",selectedIndex);
    //初始化游戏列表
    games=[[NSArray alloc] initWithObjects:@"愤怒的小鸟",@"小鸡快跑",@"纸牌",@"黑客帝国",@"极品风车", nil];

    
    //视图加载的时候，初始化选择索引
    selectedIndex=[games indexOfObject:self.game];

   
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    games=nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSLog(@"行数%d",[games count]);
    // Return the number of rows in the section.
    return [games count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GamePickerCell"];
        
    //显示表格内容
    cell.textLabel.text=[games objectAtIndex:indexPath.row];
    
    //取得用户上一次选择的游戏名字所在的索引
    selectedIndex=[games indexOfObject:self.game];
    
    //决定每行的状态
    
    if (indexPath.row==selectedIndex) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;

    }else{
        
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    
    
    // Configure the cell...
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        //取消选择
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (selectedIndex!=NSNotFound) {
        //取得之前选择的那个单元格
        UITableViewCell *cell=[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0]]; 
                               
            //然后将其选择来样式，置为无                   
          cell.accessoryType=UITableViewCellAccessoryNone;
        
    }
    
    //用户选择的是哪一行
    selectedIndex=indexPath.row;

    //取得选择的单元格
    UITableViewCell *tmpCell=[tableView cellForRowAtIndexPath:indexPath];
    //标示为选择状态
    tmpCell.accessoryType=UITableViewCellAccessoryCheckmark;
    
    //取得选择的是哪一个游戏名字
    NSString *theGame=[games objectAtIndex:indexPath.row];
    
        
    NSLog(@"开始传递选择的游戏名字");
    //调用代理方法，返回视图，并返回用户选择的游戏名字
    [self.delegate gamePickerViewController:self didSelectGame:theGame];
 
}


//从前往后显示界面会调用这个方法，从后往前 则不会调用


//-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    
//    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
//    
//    if ([segue.identifier isEqualToString:@"PickGame"]) {
//        
//        DetailViewController *controller=[[DetailViewController alloc] init];
//        
//                
//        self.game=controller.DisplayGame_BySelecting.text;
//        
//        
//        
//        NSLog(@"gameName=%@",self.game);
//    }
    
//    
//    
//}


@end
