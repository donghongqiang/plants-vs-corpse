//
//  GameLayer.m
//  plant vs corpose
//
//  Created by 红强 董 on 12-11-7.
//  Copyright 2012年 Ibokan. All rights reserved.
//

#import "GameLayer.h"


@implementation GameLayer
+(CCScene *) scene{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [GameLayer node];
    [scene addChild:layer];
    return scene;
}
-(id)init{
    self=[super init];
    if (self) {
        
    }
    return self;
}
@end
