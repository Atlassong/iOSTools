//
//  SKSpriteNode+Additions.m
//  PetsLink
//
//  Created by Atlas on 9/29/19.
//  Copyright © 2019 Atlas. All rights reserved.
//

#import "SKSpriteNode+Additions.h"

@implementation SKSpriteNode (Additions)

- (void)width:(CGFloat)width {
    self.size = CGSizeMake(width, self.size.height);
}

- (void)height:(CGFloat)height {
    self.size = CGSizeMake(self.size.width, height);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)scale:(CGFloat)scale {
    self.xScale = scale;
    self.yScale = scale;
}
@end
