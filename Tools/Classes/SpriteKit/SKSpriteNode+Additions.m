//
//  SKSpriteNode+positionext.m
//  Tools
//
//  Created by 宋祥 on 2021/3/28.
//

#import "SKSpriteNode+Additions.h"

@implementation SKSpriteNode (Additions)

- (void)setLeft:(CGFloat)left {
    self.position = CGPointMake(left, self.position.y);
}

- (CGFloat)left {
    return self.position.x;
}

- (void)setRight:(CGFloat)right {
    self.position = CGPointMake(right - self.size.width, self.position.y);
}

- (CGFloat)right {
    return self.position.x + self.size.width;
}

- (void)setTop:(CGFloat)top {
    self.position = CGPointMake(self.position.x, top - self.size.height);
}

- (CGFloat)top {
    return self.position.y + self.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    self.position = CGPointMake(self.position.x, bottom);
}

- (CGFloat)bottom {
    return self.position.y;
}

- (void)setCenterX:(CGFloat)centerX {
    self.position = CGPointMake(centerX - self.size.width / 2.0, self.position.y);
}

- (CGFloat)centerX {
    return self.position.x + self.size.width / 2.0;
}

- (void)setCenterY:(CGFloat)centerY {
    self.position = CGPointMake(self.position.x, centerY - self.size.height /2.0);
}

- (CGFloat)centerY {
    return self.position.y + self.size.height / 2.0;
}

- (void)setWidth:(CGFloat)width {
    self.size = CGSizeMake(width, self.size.height);
}

- (CGFloat)width {
    return self.size.width;
}

- (void)setHeight:(CGFloat)height {
    self.size = CGSizeMake(self.size.width, height);
}

- (CGFloat)height {
    return self.size.height;
}

- (void)setScale:(CGFloat)scale {
    self.xScale = scale;
    self.yScale = scale;
}

- (CGFloat)scale {
    return self.xScale;
}

@end
