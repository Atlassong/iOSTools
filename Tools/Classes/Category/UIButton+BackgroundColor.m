//
//  UIButton+BackgroundColor.m
//  Pods-Tools_Example
//
//  Created by Atlas on 11/24/19.
//

#import "UIButton+BackgroundColor.h"
#import <objc/runtime.h>

@interface UIButton (CS_BackgroundColor)
@property (nonatomic, strong) NSMutableDictionary *cs_dictBackgroundColor;
@end


@implementation UIButton (BackgroundColor)
static const NSString *key_cs_backgroundColor             = @"key_cs_backgroundColor";
static NSString *cs_stringForUIControlStateNormal         = @"cs_stringForUIControlStateNormal";
static NSString *cs_stringForUIControlStateHighlighted    = @"cs_stringForUIControlStateHighlighted";
static NSString *cs_stringForUIControlStateDisabled       = @"cs_stringForUIControlStateDisabled";
static NSString *cs_stringForUIControlStateSelected       = @"cs_stringForUIControlStateSelected";

- (NSMutableDictionary *)cs_dictBackgroundColor {
    return objc_getAssociatedObject(self, &key_cs_backgroundColor);
}

- (void)setCs_dictBackgroundColor:(NSMutableDictionary *)cs_dictBackgroundColor {
    objc_setAssociatedObject(self, &key_cs_backgroundColor, cs_dictBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    if (!self.cs_dictBackgroundColor) {
        self.cs_dictBackgroundColor = [[NSMutableDictionary alloc] init];
    }

    [self.cs_dictBackgroundColor setObject:backgroundColor forKey:[self cs_stringForUIControlState:state]];
    if (state == UIControlStateNormal) {
        self.backgroundColor = backgroundColor;
    }
}

- (NSString *)cs_stringForUIControlState:(UIControlState)state {
    NSString *cs_string;
    switch (state) {
        case UIControlStateNormal:
            cs_string = cs_stringForUIControlStateNormal;
            break;
        case UIControlStateHighlighted:
            cs_string = cs_stringForUIControlStateHighlighted;
            break;
        case UIControlStateDisabled:
            cs_string = cs_stringForUIControlStateDisabled;
            break;
        case UIControlStateSelected:
            cs_string = cs_stringForUIControlStateSelected;
            break;
        default:
            cs_string = cs_stringForUIControlStateNormal;
            break;
    }
    return cs_string;
}

#pragma mark - highlighted
- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        UIColor *highlightedColor = (UIColor *)[self.cs_dictBackgroundColor objectForKey:cs_stringForUIControlStateHighlighted];
        if (!highlightedColor) {
            highlightedColor = (UIColor *)[self.cs_dictBackgroundColor objectForKey:cs_stringForUIControlStateNormal];
        }
        self.backgroundColor = highlightedColor;
    } else {
        self.backgroundColor = (UIColor *)[self.cs_dictBackgroundColor objectForKey:cs_stringForUIControlStateNormal];
    }
}

@end
