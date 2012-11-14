//
//  PlayerViewController.h
//  Ratings
//
//  Created by Ibokan on 12-9-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "CeshiViewController.h"
@class Player;
@interface PlayerViewController : UITableViewController<DetailViewControllerDelegate,UITabBarControllerDelegate,CeshiViewControllerDelegate>
{
    
    CeshiViewController *tmpCeshiController;
    
    
    
    int count; //显示更新的数目，目前还没有找到解决方法
    
    NSArray *imageArray; //保存图片的数组，暂时用不到
    
    NSMutableArray *databaseArray; //保存选手的数组
    NSMutableArray *filterArray; //查询结果
    Player *tmpPlayer; //传给测试视图的player，即选择什么，下一个视图显示什么
    
}

@property (retain, nonatomic) IBOutlet UISearchBar *searchBar; //搜索框，实时获取用户输入，以备搜索

@property(nonatomic,retain)NSMutableArray *players; //不用数据库时，保存数据的数组
@end
