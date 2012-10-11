//
//  sdsViewController.h
//  URL
//
//  Created by david on 12-9-19.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sdsViewController : UIViewController<NSURLConnectionDataDelegate>
{
    
    NSDictionary *weatherDetail;
}
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@property (retain, nonatomic) IBOutlet UILabel *DateLabel;
@property (retain, nonatomic) IBOutlet UILabel *CityLabel;
@property (retain, nonatomic) IBOutlet UILabel *weatherLabel;
@property (retain, nonatomic) IBOutlet UILabel *temLabel;

@property (retain, nonatomic) IBOutlet UILabel *windLabel;
@property (retain, nonatomic) IBOutlet UITextView *clothes;
@property (retain, nonatomic) IBOutlet UILabel *clothesLabel;

@property(nonatomic,retain)NSMutableData  *receiveData;
- (IBAction)YiBuGet:(id)sender;

- (IBAction)YibuPost:(id)sender;

- (IBAction)TongBuGET:(id)sender;
- (IBAction)TongBuPOST:(id)sender;

- (IBAction)getWeatherFromWeb:(id)sender;
- (IBAction)getWeatherInShanghai:(id)sender;

@end
