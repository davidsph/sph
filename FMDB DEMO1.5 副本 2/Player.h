//
//  Player.h
//  Ratings
//
//  Created by Ibokan on 12-9-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject
@property(nonatomic,assign) int ID;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *game;
@property(nonatomic,assign) int rating;

@property(nonatomic,retain)NSString *ratingPic;


- (id) initWithName:(NSString *) aName andGame:(NSString *) aGame andRatingPic:(NSString *) pic andID:(int) newID;
@end
