//
//  ASIHttp.m
//  URL
//
//  Created by david on 12-9-24.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import "ASIHttp.h"
#import "ASIHTTPRequest.h"
#import "ASIHTTPReauest/ASIHTTPRequest.h"
#import "ASIHTTPReauest/ASIFormDataRequest.h"
@implementation ASIHttp

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)Tongbu:(id)sender {
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSURL *url=[NSURL URLWithString:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/loginmgr/login.aspx"];
   ASIFormDataRequest *dataRe=[ASIFormDataRequest requestWithURL:url];
    
    
    NSMutableString *string1=[[NSMutableString alloc] initWithString:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/loginmgr/login.aspx"];
    
    
    NSString *string=@"http://wapinterface.zhaopin.com/iphone/myzhaopin/loginmgr/login.aspx?email=daviddjy@163.com&password=abc123589";
    
    NSString *newString=[dataRe encodeURL:@"daviddjy@163.com"];
    NSString *newString1=[dataRe encodeURL:@"abc123589"];
    
    [string1 appendString:@"?email="];
    [string1 appendString:newString];
    
    [string1 appendString:@"&password="];
    
    [string1 appendString:newString1];
    
    
    NSLog(@"编码之后的URL为：%@",string1);
    
    ASIFormDataRequest *newRequest=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:string1]];
    
    [newRequest setRequestMethod:@"GET"];
    
    [newRequest startSynchronous];
    
       NSError *error=[newRequest error];
    
    if (!error) {
        NSLog(@"w无错误");
        NSString *response=[newRequest responseString];
        NSLog(@"%@",response);
        
        NSData *data=[newRequest responseData];
        
        NSString *dataString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"收到的数据为：%@",dataString);
    }

    
    
}

- (IBAction)Yibu:(id)sender {
    
    NSURL *url=[NSURL URLWithString:@"http://baidu.com"];
    
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
    
    
}

- (void)  requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSError *error=[request error];
}

- (void) requestFinished:(ASIHTTPRequest *)request{
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    NSString *reponse_String=[request responseString];
    NSLog(@"收到：%@",reponse_String);

    
}
@end
