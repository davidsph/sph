//
//  CeshiViewController.m
//  Ratings
//
//  Created by Ibokan on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CeshiViewController.h"
#import "GamePickerViewController.h"
#import "Player.h"

@implementation CeshiViewController
@synthesize right_bar_bn;
@synthesize show_playerName;
@synthesize show_playerGame;
@synthesize player;
@synthesize delegate;


- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    //    [self.nameTextField resignFirstResponder];
    [self.show_playerName endEditing:YES];
    
    return  YES;
}
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    [super viewDidLoad];
    self.show_playerName.delegate=self;
    self.tableView.userInteractionEnabled=false;
    
    
    NSLog(@"接收到的值=%@",player);
    NSLog(@"传进来的player ID=%d",player.ID);
    self.show_playerName.text=player.name;
    self.show_playerGame.text=player.game;
    NSLog(@"当前显示的name=%@",self.show_playerGame.text);
    NSLog(@"当前显示的game=%@",self.show_playerName.text);
    
    
    NSLog(@"tag=%d",self.view.tag);
    
    
    
}

- (void)viewDidUnload
{
    [self setRight_bar_bn:nil];
    [self setShow_playerName:nil];
    [self setShow_playerGame:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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







#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (IBAction)back_bn:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)right_bar_bn_clicked:(id)sender {
    
    NSString *string=self.right_bar_bn.title;
    NSLog(@"当前标题为：%@",string);
    if ([string isEqualToString:@"修改"]) 
    {
        self.right_bar_bn.title=@"保存";
        self.tableView.userInteractionEnabled=true;
    }
    else{
        
         Player *thisPlayer=[[Player alloc] init];
        
        thisPlayer.name=self.show_playerName.text;
        thisPlayer.game=self.show_playerGame.text;
        thisPlayer.ID=player.ID;
        NSLog(@"传进来的player ID=%d",player.ID);
        
        
        
        //去掉空格
        NSCharacterSet *whiteSpace=[NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        thisPlayer.name=[thisPlayer.name stringByTrimmingCharactersInSet:whiteSpace];
        
        if ([thisPlayer.name isEqualToString:@""]) 
        {
            
            NSLog(@"名字为%@dd",player.name);
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"亲，姓名不能为空哦O(∩_∩)O" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            [alert show];
            [alert release];
            
        } 
        //姓名不为空 才能有效修改
        else
        {
            self.right_bar_bn.title=@"修改";
            self.tableView.userInteractionEnabled=false;
            [self.delegate CeshiViewControllerDidSaveWhenEditing:self DidSavePlayer:thisPlayer]; 
            
        }
        
    } //end大else
    
    
    
}
- (void)dealloc {
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    [right_bar_bn release];
    [show_playerName release];
    [show_playerGame release];
    [super dealloc];
}
#pragma mark -
#pragma mark gamePickerViewControllerDeleate
- (void)gamePickerViewController:(GamePickerViewController *)controller didSelectGame:(NSString *)game{
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSLog(@"选择的游戏名字为：%@",game);
    self.show_playerGame.text=game;
    
    
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"PickGame"]) {
        
        GamePickerViewController *gameController=[segue destinationViewController];
        
        gameController.game=self.show_playerGame.text;
        
        gameController.delegate=self;
        
        
    }
    
}
@end
