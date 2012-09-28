//
//  DetailViewController.m
//  Ratings
//
//  Created by Ibokan on 12-9-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "Player.h"
#import "GamePickerViewController.h"

@implementation DetailViewController


@synthesize DisplayGame_BySelecting;
@synthesize delegate;
@synthesize nameTextField;


- (id) initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
        
        NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
        NSLog(@"详细信息被加载了");
//        //默认选择的game
//        theDisPlayGameName=@"愤怒的小鸟";
        
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

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    //    [self.nameTextField resignFirstResponder];
    [self.nameTextField endEditing:YES];
    
    return  YES;
}

- (IBAction)cancel:(id)sender{
    
    [self.delegate detailViewConrtrollerDidCancel:self];
    
}

- (IBAction)done:(id)sender{
    Player *player=[[Player alloc] init];
    //用户输入的名字
    player.name=self.nameTextField.text;
    //用户选择的游戏名字
    player.game=theDisPlayGameName;
    //等级
    player.ratingPic=@"12.jpg";
    
    
    //去掉空格
    NSCharacterSet *whiteSpace=[NSCharacterSet whitespaceAndNewlineCharacterSet];
    player.name=[player.name stringByTrimmingCharactersInSet:whiteSpace ];
    
    
    
    if ([player.name isEqualToString:@""]) {
        
        NSLog(@"名字为%@dd",player.name);
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"亲，姓名不能为空哦O(∩_∩)O" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
        [alert show];
        [alert release];
        
    } else{
        
        
        NSLog(@"名字为%@dd",player.name);
        [self.delegate detailViewConrtrollerDidSave:self DidAddPlayer:player];

    }
    
    //这里可以release原始数据，经测试，会执行完代理方法后，才会执行这条语句，所以不会，造成野指针的问题，同时，也保证了内存管理的严密性
    [player release];
    
    NSLog(@"传递的原始数据release");
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    //默认选择项
    theDisPlayGameName=@"愤怒的小鸟";

    self.nameTextField.delegate=self;
    //将选择的游戏名字显示出来
    self.DisplayGame_BySelecting.text=theDisPlayGameName;
    
    
    [super viewDidLoad];
    
  
}

- (void)viewDidUnload
{
    [self setNameTextField:nil];
    [self setDisplayGame_BySelecting:nil];
    [super viewDidUnload];
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
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    
    if (indexPath.row==0) {
        [self.nameTextField becomeFirstResponder];
    }
    
    else{
        
        [self.nameTextField resignFirstResponder];
    }
    
}

#pragma mark -
#pragma mark prepareForSegue

//这是在下一个视图加载了之后但还没有显示的时候调用的方法，可以利用这个特点传一些参数
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    
    if ([segue.identifier isEqualToString:@"PickGame"]) {
        
        //取得目标控制器
        GamePickerViewController *gameViewController=segue.destinationViewController;
        
        
        //利用属性传值，将当前显示的游戏名字，传给下一个，好处是显示什么，选择菜单，就会默认选择哪一个列表项
        gameViewController.game=self.DisplayGame_BySelecting.text;
        
        //游戏选择视图的代理设置为本类的实例
        gameViewController.delegate=self;
    }
    
    
    
}

#pragma mark -
#pragma mark gamePickerViewControllerDeleate

- (void)gamePickerViewController:(GamePickerViewController *)controller didSelectGame:(NSString *)game{
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    //将用户选择的保存的到本场景中
    theDisPlayGameName=game;
    
    //显示用户的选择
    self.DisplayGame_BySelecting.text=game;
    
    
    //这里不用显示调用回到上一个视图，只是先选择，然后利用navigation来跳转到下一个界面
    //立马回到前一个视图
//    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}


- (void)dealloc {
    NSLog(@"详细信息被卸载了");
    
    [nameTextField release];
    [DisplayGame_BySelecting release];
    [super dealloc];
}
@end
