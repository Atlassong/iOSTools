//
//  SKSpriteNode+Additions.h
//  PetsLink
//
//  Created by Atlas on 9/29/19.
//  Copyright © 2019 Atlas. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKSpriteNode (Additions)
- (void)width:(CGFloat)width;
- (void)height:(CGFloat)height;
- (CGFloat)width;
- (CGFloat)height;
- (void)scale:(CGFloat)scale;
@end

NS_ASSUME_NONNULL_END
