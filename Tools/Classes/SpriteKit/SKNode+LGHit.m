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
    if ([[SoundManager instance].preLoadHitSound objectForKey:fileName] && [Configuration instance].playActionMusic) {
        [self runAction:[[SoundManager instance].preLoadHitSound objectForKey:fileName]];
    }
}
@end
