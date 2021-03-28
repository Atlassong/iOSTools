//
//  LGButtonNode.h
//  PetsLink
//
//  Created by Atlas on 9/22/19.
//  Copyright © 2019 Atlas. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class LGButtonNode;
NS_ASSUME_NONNULL_BEGIN
typedef void(^NodeTouchBlock)(LGButtonNode *);
@interface LGButtonNode : SKSpriteNode
@property (nonatomic, strong) SKSpriteNode *activeSprite;
@property (nonatomic, strong) SKSpriteNode *normalSprite;
@property (nonatomic, strong) SKLabelNode *labelNode;
@property (nonatomic, readwrite) BOOL buttonPressed;
@property (nonatomic, readwrite) BOOL buttonActive;
@property (nonatomic, assign, readonly) BOOL usableStatus;
@property (nonatomic, assign) BOOL enable;
@property (nonatomic, assign) BOOL disableCanTouch;
@property (nonatomic, copy) NSString *actionMusicName;

+ (instancetype)buttonWithActiveImage:(nullable NSString *)image normalImage:(NSString *)normalImage btnClick:(NodeTouchBlock)nodeClick;

+ (instancetype)buttonWithActiveImage:(nullable NSString *)image normalImage:(NSString *)normalImage disableImage:(nullable NSString *)disableImage disableNormalImage:(NSString *)disableNormalImage enable:(BOOL)enable btnClick:(NodeTouchBlock)nodeClick;

+ (instancetype)buttonWithActiveImage:(nullable NSString *)image normalImage:(NSString *)normalImage;

+ (instancetype)buttonWithTextLabel:(NSString *)label btnClick:(NodeTouchBlock)nodeClick;


- (void)buttonWithActiveImage:(nullable NSString *)image normalImage:(NSString *)normalImage btnClick:(NodeTouchBlock)nodeClick;
@end

NS_ASSUME_NONNULL_END
