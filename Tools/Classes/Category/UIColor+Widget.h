//
//  UIColor+Widget.h
//  SPWidget
//
//  Created by Atlas on 13-4-7.
//  Copyright (c) 2014年 Atlas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Widget)

+ (UIColor *)colorWithHexString: (NSString *)stringToConvert;
+ (UIColor *)colorWithHexString: (NSString *)stringToConvert withAlpha:(float)alpha;
- (NSString *)toHexString;
- (UIColor*)blendWithColor:(UIColor*)color2 alpha:(CGFloat)alpha2;
@end
