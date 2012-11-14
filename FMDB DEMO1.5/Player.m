//
//  Player.m
//  Ratings
//
//  Created by Ibokan on 12-9-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Player.h"

@implementation Player
@synthesize name,game,rating;
@synthesize ratingPic;
@synthesize ID;
- (id) initWithName:(NSString *) aName andGame:(NSString *) aGame andRatingPic:(NSString *) pic andID:(int) newID
{
    self=[super init];
    if (self) {
        self.name=aName;
        self.game=aGame;
        self.ratingPic=pic;
        self.ID=newID;
    }
    
    
    return self;
    
}

@end
