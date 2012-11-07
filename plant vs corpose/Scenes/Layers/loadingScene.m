//
//  loadingScene.m
//  plant vs corpose
//
//  Created by 红强 董 on 12-11-7.
//  Copyright 2012年 Ibokan. All rights reserved.
//

#import "loadingScene.h"
#import "GameLayer.h"

@implementation loadingScene
+(CCScene *) scene{
    CCScene *scene = [CCScene node];
    loadingScene *layer = [loadingScene node];
    [scene addChild:layer];
    return  scene;
}
-(id)init{
    self = [super init];
    if (self) {
        self.isTouchEnabled =YES;
        CGSize size = [[CCDirector sharedDirector] winSize];
        [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:@"loadingLogo.plist"];
        //CCSpriteBatchNode *sheet = [CCSpriteBatchNode batchNodeWithFile:@"loadingLogo.png"];
        //[self addChild:sheet];
        CCSprite *loading = [CCSprite spriteWithSpriteFrameName:@"titlescreen.png"];
        CCSprite *sroll = [CCSprite spriteWithSpriteFrameName:@"SodRollCap.png"];
        CCSprite *line = [CCSprite spriteWithSpriteFrameName:@"loading_tiao.png"];
        CCSprite *s  = [CCSprite spriteWithSpriteFrameName:@"LogoLine.png"];
        CCSprite *newline = [CCSprite spriteWithSpriteFrameName:@"tiao04.png"];
        loading.position = CGPointMake(size.width / 2, size.height / 2);
        s.position = ccp(size.width/2, 20);
        sroll.position = ccp(size.width/2-0.5*line.boundingBox.size.width, 50);
        line.position = ccp(size.width/2, 15);
        newline.position = ccp(size.width/2-0.5*line.boundingBox.size.width+20, 15);
        linePoint = ccp(size.width/2+0.5*line.boundingBox.size.width, 45);
        newline.scaleX = 0.3;
        [self addChild:s z:0 tag:114];
		[self addChild:loading z:-1 tag:111];
		[self addChild:sroll z:0 tag:112];
        [self addChild:line z:0 tag:113] ;
        [self addChild:newline z:0 tag:115];
        [CCMenuItemFont setFontName:@"Marker Felt"];
        [CCMenuItemFont setFontSize:16];
        CCMenuItemFont *menuBeginItem = [CCMenuItemFont itemWithString:@"点击开始" block:^(id sender) {
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeUp transitionWithDuration:1 scene:[GameLayer scene]]];
        }];
        CCMenu *lab = [CCMenu menuWithItems:menuBeginItem, nil];
        [lab setTag:116];
        lab.visible = NO;
        lab.isTouchEnabled = NO;
        [self addChild:lab];
        lab.position = ccp(size.width/2, 15);
        [self schedule:@selector(loading) interval:5 repeat:NO delay:1];
    }
    
    
    return self;
}
-(void)loading{
    [self scheduleOnce:@selector(begining) delay:3];
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *newline = (CCSprite*)[self getChildByTag:115];
    [newline runAction:[CCSpawn actions:[CCMoveTo actionWithDuration:3 position:ccp(size.width/2, 15)], [CCScaleTo actionWithDuration:3 scaleX:1.1 scaleY:1 ],nil]];
    CCSprite *sroll = (CCSprite*)[self getChildByTag:112];
    id roto = [CCRotateBy actionWithDuration:0.5 angle:180];
    CCRepeat *repeat1 = [CCRepeat actionWithAction:roto times:9];
    CCAction *move =[CCMoveTo actionWithDuration:3 position:linePoint];
    [sroll runAction:[CCSpawn actions:repeat1,move, nil]];
  
}
-(void)begining{
    CCMenu *menu = (CCMenu*)[self getChildByTag:116];
    menu.visible = YES;
    menu.isTouchEnabled = YES;
}
@end
