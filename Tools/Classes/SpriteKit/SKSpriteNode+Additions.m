//
//  SKSpriteNode+positionext.m
//  Tools
//
//  Created by 宋祥 on 2021/3/28.
//

#import "SKSpriteNode+Additions.h"

@implementation SKSpriteNode (Additions)

- (void)setLeft:(CGFloat)left {
    self.position = CGPointMake(left + self.anchorPoint.x * self.size.width, self.position.y);
}

- (CGFloat)left {
    return self.position.x - self.anchorPoint.x * self.size.width;
}

- (void)setRight:(CGFloat)right {
    self.position = CGPointMake(right - (1 - self.anchorPoint.x) * self.size.width, self.position.y);
}

- (CGFloat)right {
    return self.position.x + (1 - self.anchorPoint.x) * self.size.width;
}

- (void)setTop:(CGFloat)top {
    self.position = CGPointMake(self.position.x, top - (1 - self.anchorPoint.y) * self.size.height);
}

- (CGFloat)top {
    return self.position.y + (1 - self.anchorPoint.y) * self.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    self.position = CGPointMake(self.position.x, bottom + self.anchorPoint.y * self.size.height);
}

- (CGFloat)bottom {
    return self.position.y - self.anchorPoint.y * self.size.height;
}

- (CGFloat)centerX {
    return self.left + self.size.width / 2.0;
}

- (CGFloat)centerY {
    return self.bottom + self.size.height / 2.0;
}

- (void)setCenterX:(CGFloat)centerX {
    self.position = CGPointMake(centerX - self.size.width / 2.0 + self.anchorPoint.x * self.size.width, self.position.y);
}

- (void)setCenterY:(CGFloat)centerY {
    self.position = CGPointMake(self.position.x, centerY - self.size.height /2.0 + self.anchorPoint.y * self.size.height);
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
