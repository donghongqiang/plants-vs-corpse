//
//  LoadingScene.m
//  ScenesAndLayers
//
//  Created by Steffen Itterheim on 27.07.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "LoadingScene.h"
#import "HelloWorldLayer.h"


@interface LoadingScene (PrivateMethods)
-(void) update:(ccTime)delta;
@end

@implementation LoadingScene

+(id) sceneWithTargetScene:(TargetScenes)targetScene;
{
	CCLOG(@"===========================================");
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);

	// This creates an autorelease object of self (the current class: LoadingScene)
	return [[[self alloc] initWithTargetScene:targetScene] autorelease];
	
	// Note: this does the exact same, it only replaced self with LoadingScene. The above is much more common.
	//return [[[LoadingScene alloc] initWithTargetScene:targetScene] autorelease];
}

-(id) initWithTargetScene:(TargetScenes)targetScene
{
	if ((self = [super init]))
	{
		targetScene_ = targetScene;
        CGSize size = [[CCDirector sharedDirector] winSize];
        [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:@"loadingLogo.plist"];
        CCSprite *loading = [CCSprite spriteWithSpriteFrameName:@"titlescreen.png"];
        CCSprite *sroll = [CCSprite spriteWithSpriteFrameName:@"SodRollCap.png"];
        CCSprite *line = [CCSprite spriteWithSpriteFrameName:@"loading_tiao.png"];
        loading.position = CGPointMake(size.width / 2, size.height / 2);
        sroll.position = ccp(size.width/6, 30);
        line.position = ccp(size.width/4, 30);

		[self addChild:loading z:-1 tag:111];
		[self addChild:sroll z:0 tag:112];
        [self addChild:line z:0 tag:113] ;
		// Must wait one frame before loading the target scene!
		// Two reasons: first, it would crash if not. Second, the Loading label wouldn't be displayed.
		[self scheduleUpdate];
	}
	
	return self;
}

-(void) update:(ccTime)delta
{
	// It's not strictly necessary, as we're changing the scene anyway. But just to be safe.
	[self unscheduleAllSelectors];
	
	// Decide which scene to load based on the TargetScenes enum.
	// You could also use TargetScene to load the same with using a variety of transitions.
	switch (targetScene_)
	{
		case TargetSceneFirstScene:
			[[CCDirector sharedDirector] replaceScene:[CCTransitionMoveInB transitionWithDuration:5 scene:[HelloWorldLayer scene] ]];
			break;
		case TargetSceneOtherScene:
			//[[CCDirector sharedDirector] replaceScene:[OtherScene scene]];
			break;
			
		default:
			// Always warn if an unspecified enum value was used. It's a reminder for yourself to update the switch
			// whenever you add more enum values.
			NSAssert2(nil, @"%@: unsupported TargetScene %i", NSStringFromSelector(_cmd), targetScene_);
			break;
	}
	
	// Tip: example usage of the INVALID and MAX enum values to iterate over all enum values
	for (TargetScenes i = TargetSceneINVALID + 1; i < TargetSceneMAX; i++)
	{
	}
}

-(void) dealloc
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
