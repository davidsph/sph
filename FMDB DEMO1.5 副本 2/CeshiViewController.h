//
//  CeshiViewController.h
//  Ratings
//
//  Created by Ibokan on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Player;
@class CeshiViewController;
#import "GamePickerViewController.h"
@protocol CeshiViewControllerDelegate <NSObject>


//用户单击修改，然后保存操作之后执行的动作
- (void) CeshiViewControllerDidSaveWhenEditing:(CeshiViewController *) controller DidSavePlayer:(Player *) player;
//- (void) CeshiViewControllerDidCancel:(CeshiViewController *) controller;

@end

@interface CeshiViewController : UITableViewController<GamePickerViewControllerDelegate,UITextFieldDelegate>

- (IBAction)back_bn:(id)sender; //后退按钮
- (IBAction)right_bar_bn_clicked:(id)sender;

@property (retain, nonatomic) IBOutlet UIBarButtonItem *right_bar_bn;

@property (retain, nonatomic) IBOutlet UITextField *show_playerName;

@property (retain, nonatomic) IBOutlet UILabel *show_playerGame;
@property(nonatomic,retain)Player *player; //属性传值，显示用户的选择的详细信息



@property(nonatomic,assign)id<CeshiViewControllerDelegate> delegate; //代理
@end
