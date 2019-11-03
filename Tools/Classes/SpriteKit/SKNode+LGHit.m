//
//  SKScene+LGHit.m
//  PetsLink
//
//  Created by Atlas on 9/24/19.
//  Copyright © 2019 Atlas. All rights reserved.
//
#import "SKNode+LGHit.h"

@implementation SKNode (LGHit)
- (void)hitByFileName:(NSString *)fileName waitForCompletion:(BOOL)waitForCompletion {
	[self runAction:[SKAction playSoundFileNamed:fileName waitForCompletion:waitForCompletion]];
}
@end
