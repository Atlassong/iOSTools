//
//  SKScene+LGHit.h
//  PetsLink
//
//  Created by Atlas on 9/24/19.
//  Copyright © 2019 Atlas. All rights reserved.
//
#import <SpriteKit/SpriteKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKNode (LGHit)
- (void)beepByName:(NSString *)fileName waitForCompletion:(BOOL)waitForCompletion;
@end

NS_ASSUME_NONNULL_END
