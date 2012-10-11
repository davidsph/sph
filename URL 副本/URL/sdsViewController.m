//
//  sdsViewController.m
//  URL
//
//  Created by david on 12-9-19.
//  Copyright (c) 2012年 davidsph. All rights reserved.
//

#import "sdsViewController.h"
#import "GDataXMLNode.h"
#import "JSON.h"
@implementation sdsViewController

@synthesize activityView;
@synthesize DateLabel;
@synthesize CityLabel;
@synthesize weatherLabel;
@synthesize temLabel;
@synthesize windLabel;
@synthesize clothes;
@synthesize clothesLabel;
@synthesize receiveData;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidUnload
{
    [self setDateLabel:nil];
    [self setCityLabel:nil];
    [self setWeatherLabel:nil];
    [self setTemLabel:nil];
    [self setWindLabel:nil];
    [self setClothesLabel:nil];
    [self setClothes:nil];
    [self setActivityView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)YiBuGet:(id)sender {
    
    
    //GET方式把参数以key/value形式直接拼接到URL后面，参数之间用&分割
    //第一步，设置访问的URL
    NSURL *url=[NSURL URLWithString:@"http://api.hudong.com/iphonexml.do?type=focus-c"];
    
    //第二部创建请求
    
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    //第三部，连接服务器
    NSURLConnection *con=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [con release];
    
}

- (IBAction)YibuPost:(id)sender {
    
    //异步POST方式请求数据
    //POST 方式把URL和参数分开，参数作为postBody发送给服务器
    NSURL *url=[NSURL URLWithString:@"http://api.hudong.com/iphonexml.do"];
    //第二步。创建请求
    NSMutableURLRequest *re=[[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    [re setHTTPMethod:@"POST"];//设置请求方式，默认是GET
    
    NSString *string=@"type=focus-c";//参数
    
    NSData *data=[string dataUsingEncoding:NSUTF8StringEncoding]; //封装成data
    
    [re setHTTPBody:data]; 
    
    //建立连接
    NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:re delegate:self];
    
    
    [connection release];
}

- (IBAction)TongBuGET:(id)sender {
    
    /*
    //GET方式把参数以key/value形式直接拼接到URL后面，参数之间用&分割
    //第一步，设置访问的URL
    NSURL *url=[NSURL URLWithString:@"http://api.hudong.com/iphonexml.do?type=focus-c"];
    
    //第二部创建请求
    
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    
    //第三步
    
    NSURLResponse *response=nil;
    NSError *error=nil;
    
    NSData *receive= [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *str=[[NSString alloc] initWithData:receive encoding:NSUTF8StringEncoding];
    
    NSLog(@"使用同步GET方式收到的数据为：%@",str);
     */
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"myxml" ofType:@"xml"];
    
    NSString *str=[NSString stringWithContentsOfFile: path encoding:NSUTF8StringEncoding error:nil];
    
    
    //解析内容,把结果放在document中
    GDataXMLDocument *document=[[GDataXMLDocument alloc] initWithXMLString:str options:0 error:nil];
    //取数据
    GDataXMLElement *root=[document rootElement]; //获得根节点
    
    //获得孩子节点
//    NSArray *children=[root children];
    GDataXMLNode *channel = [root childAtIndex:0];
    NSString *name =[channel stringValue];
    
    
    NSLog(@"取出来的全部信息为:%@",name);
    
    GDataXMLElement *nameRoot=[[channel children] objectAtIndex:0];
    
    
    NSLog(@"name=%@",[nameRoot stringValue]);
    
    //简单方法
    for(GDataXMLElement *element in [root children]){
        
        GDataXMLElement *name=[[element elementsForName:@"name"] objectAtIndex:0];
        GDataXMLElement *age=[[element elementsForName:@"age"] objectAtIndex:0];
        GDataXMLElement *phone=[[element elementsForName:@"phone"] objectAtIndex:0];
        
        NSLog(@"name=%@ age=%@ phone=%@",[name stringValue],[age stringValue],[phone stringValue]);
               
    }
    
    
    
  NSArray *array = [root nodesForXPath:@"student/name" error:nil];
    
    for(GDataXMLElement *name in  array){
        
        NSLog(@"name=%@",[name stringValue]);
    }
    
    
    NSString *tmp=@"[{\"name\":\"李华\",\"age\":\"20\",\"sex\":\"m\"},{\"name\":\"david\",\"age\":\"21\",\"sex\":\"man\"}]";
    
    
    NSArray *tmparr =[tmp JSONValue];
    
    NSDictionary *dic=[tmparr objectAtIndex:0];
    
//    NSString *stringName=[dic objectForKey:@"name"];
    
    NSLog(@"通过字典解析出来的name=%@",[dic objectForKey:@"name"]);
    
    NSLog(@"JSON解析出来的数据为：%@",tmparr);
    
   
}

- (IBAction)TongBuPOST:(id)sender {
    
    //POST 方式把URL和参数分开，参数作为postBody发送给服务器
    NSURL *url=[NSURL URLWithString:@"http://api.hudong.com/iphonexml.do"];
    //第二步。创建请求
    NSMutableURLRequest *re=[[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    [re setHTTPMethod:@"POST"];//设置请求方式，默认是GET
    
    NSString *string=@"type=focus-c";//参数
    
    NSData *data=[string dataUsingEncoding:NSUTF8StringEncoding]; //封装成data
    
    [re setHTTPBody:data]; 
    
    
    NSData *receive=[NSURLConnection sendSynchronousRequest:re returningResponse:nil error:nil];
    
    NSString *str=[[NSString alloc] initWithData:receive encoding:NSUTF8StringEncoding];
    NSLog(@"通过使用同步POST获取到的数据为：%@",str);
    [str release];
    
    
}

- (IBAction)getWeatherFromWeb:(id)sender {
    
    [self.activityView startAnimating];
    NSURL *url1=[NSURL URLWithString:@"http://m.weather.com.cn/data/101010100.html"];
    //第二部创建请求
    NSURLRequest *requ=[[NSURLRequest alloc] initWithURL:url1 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //
    
    NSURLConnection *con=[[NSURLConnection alloc] initWithRequest:requ delegate:self];
    [con release];
    
       
}

- (IBAction)getWeatherInShanghai:(id)sender {
    
    [self.activityView startAnimating];
    NSURL *url1=[NSURL URLWithString:@"http://m.weather.com.cn/data/101020100.html"];
    //第二部创建请求
    NSURLRequest *requ=[[NSURLRequest alloc] initWithURL:url1 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //
    
    NSURLConnection *con=[[NSURLConnection alloc] initWithRequest:requ delegate:self];
    [con release];
    
  
}

//时候收到服务器回应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    NSHTTPURLResponse *res=(NSHTTPURLResponse *) response;
    
    self.receiveData=[NSMutableData data];
    
    
    NSLog(@"服务器回应是：%@",[res allHeaderFields]);
    
    
}

//是否接收到数据
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    NSLog(@"接收到数据");
    [self.receiveData appendData:data];
    
    
}


- (void) initWeatherView{
    
    NSDictionary *cityInfo=[weatherDetail objectForKey:@"weatherinfo"];
    NSString *cityStr=[cityInfo description];
    NSLog(@"解析的详细信息为%@",cityStr);
    
    NSString  *city=[cityInfo objectForKey:@"city"];
    NSLog(@"city=%@",city);
    
    NSLog(@"日期=%@",[cityInfo objectForKey:@"date_y"]);
    
    self.DateLabel.text=[[cityInfo objectForKey:@"date_y"]  stringByAppendingString:[cityInfo objectForKey:@"week"]];
    self.CityLabel.text=[cityInfo objectForKey:@"city"];
    self.weatherLabel.text=[cityInfo objectForKey:@"weather1"];
    self.temLabel.text=[cityInfo objectForKey:@"temp1"];
    self.windLabel.text=[cityInfo objectForKey:@"wind1"];
    self.clothes.text=[cityInfo objectForKey:@"index_d"];
    
    
    
    
    
}

//是否完成接收
- (void) connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSLog(@"数据接受完成");
    
    
    NSString *string=[[NSString alloc] initWithData:receiveData encoding:NSUTF8StringEncoding];
    NSLog(@"接收到的数据为：%@",string);
    [string release];
    
    NSLog(@"解析前");
    
    NSString *weatherString=[[NSString alloc] initWithData:self.receiveData encoding:NSUTF8StringEncoding];
    NSLog(@"通过网络解析的天气数据为：%@",weatherString);
      
    
    
    
    NSLog(@"解析后");
    
     weatherDetail
    =[weatherString JSONValue];
    
    //更新天气显示视图
    [self initWeatherView];
    [self.activityView stopAnimating];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    
    NSLog(@"错误信息：%@",[error localizedDescription]);
}


- (void)dealloc {
    [DateLabel release];
    [CityLabel release];
    [weatherLabel release];
    [temLabel release];
    [windLabel release];
    [clothesLabel release];
    [clothes release];
    [activityView release];
    [super dealloc];
}
@end
