//
//  GamePickerViewController.h
//  Ratings
//
//  Created by Ibokan on 12-9-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GamePickerViewController;

//这是利用代理传值
@protocol GamePickerViewControllerDelegate <NSObject>

- (void) gamePickerViewController:(GamePickerViewController *) controller didSelectGame:(NSString *) game;

@end

@interface GamePickerViewController : UITableViewController
{
    NSArray *games; //游戏列表
    NSUInteger selectedIndex; //选择的列表索引
}

@property(nonatomic,retain)NSString  *game; //选择的游戏的名字
@property(nonatomic,assign)id<GamePickerViewControllerDelegate> delegate; //代理
@end 
