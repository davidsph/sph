//
//  DetailViewController.h
//  Ratings
//
//  Created by Ibokan on 12-9-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GamePickerViewController.h"
@class DetailViewController;
@class Player;

@protocol DetailViewControllerDelegate <NSObject>

- (void) detailViewConrtrollerDidCancel:(DetailViewController *) controller;

- (void) detailViewConrtrollerDidSave:(DetailViewController *) controller DidAddPlayer:(Player *) player;


@end


@interface DetailViewController : UITableViewController<UITextFieldDelegate,GamePickerViewControllerDelegate>{
    
    //记录已经选择好的game名字
    NSString *theDisPlayGameName;
}
@property (retain, nonatomic) IBOutlet UILabel *DisplayGame_BySelecting;

@property(nonatomic,assign)id<DetailViewControllerDelegate> delegate;

@property (retain, nonatomic) IBOutlet UITextField *nameTextField;

- (IBAction)cancel:(id)sender;

- (IBAction)done:(id)sender;
@end
