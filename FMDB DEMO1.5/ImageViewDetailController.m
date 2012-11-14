//
//  ImageViewDetailController.m
//  Ratings
//
//  Created by Ibokan on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImageViewDetailController.h"

@implementation ImageViewDetailController
@synthesize detail_ImageView;

@synthesize image;
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

- (void)viewDidLoad
{
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    self.detail_ImageView.image=image;
    [super viewDidLoad];
    
    
}
- (void) viewWillAppear:(BOOL)animated{
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
//    self.detail_ImageView.image=image;
    [super viewWillAppear:YES];
}

- (void) viewDidAppear:(BOOL)animated{
    
    
    NSLog(@"function %s line=%d",__FUNCTION__,__LINE__);
    [super viewDidAppear:YES];
}
- (void)viewDidUnload
{
    [self setDetail_ImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [detail_ImageView release];
    if (image) {
        NSLog(@"image详细 不为空");
        [image release];
        NSLog(@"image release");
    }
    else{
        NSLog(@"为空");
    }
    [super dealloc];
}
@end
