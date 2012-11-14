//
//  ImageViewController.h
//  Ratings
//
//  Created by Ibokan on 12-9-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UITableViewController
{
    
    NSMutableArray *imageArray; //图片名字
    NSMutableArray *imageDataArray; //图片数据
   
        
    UIImage *tmpImage; //传值
    int selectItem; //选择要显示的图片索引
}
@end
