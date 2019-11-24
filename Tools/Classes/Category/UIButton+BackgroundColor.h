//
//  UIButton+BackgroundColor.h
//  Pods-Tools_Example
//
//  Created by Atlas on 11/24/19.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (BackgroundColor)
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
@end

NS_ASSUME_NONNULL_END
