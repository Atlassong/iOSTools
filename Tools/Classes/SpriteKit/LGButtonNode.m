//
//  LGButtonNode.m
//  PetsLink
//
//  Created by Atlas on 9/22/19.
//  Copyright © 2019 Atlas. All rights reserved.
//

#import "LGButtonNode.h"
#import <objc/message.h>
#import "SKNode+LGHit.h"

@interface LGButtonNode()
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *normalImage;
@property (nonatomic, copy) NSString *disableImage;
@property (nonatomic, copy) NSString *disableNormalImage;
@property (nonatomic, copy) NodeTouchBlock nodeTouchBlock;
@end

@implementation LGButtonNode
//init with sks file
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

- (void)buttonWithActiveImage:(nullable NSString *)image normalImage:(NSString *)normalImage btnClick:(NodeTouchBlock)nodeClick {
    _enable = YES;
    self.userInteractionEnabled = YES;
    self.buttonPressed = NO;
    
    self.normalSprite = [SKSpriteNode spriteNodeWithImageNamed:normalImage];
    self.normalSprite.position = CGPointMake(self.normalSprite.size.width / 2.0, self.normalSprite.size.height / 2.0);
    self.activeSprite = [self activeSpriteWithActiveImage:image normalImage:normalImage];
    self.activeSprite.position = CGPointMake(self.normalSprite.size.width / 2.0, self.normalSprite.size.height / 2.0);

    [self addChild:self.activeSprite];
    [self addChild:self.normalSprite];
    
    self.activeSprite.hidden = YES;
    self.normalSprite.hidden = NO;
    
    _nodeTouchBlock = nodeClick;
    self.size = self.normalSprite.size;
}

+ (instancetype)buttonWithActiveImage:(nullable NSString *)image normalImage:(NSString *)normalImage btnClick:(NodeTouchBlock)nodeClick {
    return [[LGButtonNode alloc] initWithActiveImage:image normalImage:normalImage btnClick:nodeClick];
}

+ (instancetype)buttonWithActiveImage:(nullable NSString *)image normalImage:(NSString *)normalImage disableImage:(nullable NSString *)disableImage disableNormalImage:(NSString *)disableNormalImage enable:(BOOL)enable btnClick:(NodeTouchBlock)nodeClick {
    return [[LGButtonNode alloc] initWithActiveImage:image normalImage:normalImage disableImage:disableImage disableNormalImage:disableNormalImage enable:enable btnClick:nodeClick];
}

+ (instancetype)buttonWithActiveImage:(nullable NSString *)image normalImage:(NSString *)normalImage {
    return [[LGButtonNode alloc] initWithActiveImage:image normalImage:normalImage];
}

+ (instancetype)buttonWithTextLabel:(NSString *)label btnClick:(NodeTouchBlock)nodeClick {
    return [[LGButtonNode alloc] initWithtextLabel:label btnClick:nodeClick];
}

- (id)initWithtextLabel:(NSString *)label btnClick:(NodeTouchBlock)nodeClick {
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        self.buttonPressed = NO;
        _enable = YES;
        
        _labelNode = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
        _labelNode.text = label;
        _labelNode.fontSize = 40;
        _labelNode.fontColor = [SKColor whiteColor];
        _labelNode.zPosition = .9;
        [self addChild:_labelNode];
        
        _nodeTouchBlock = nodeClick;
        self.size = _labelNode.frame.size;
    }
    return self;
}

- (id)initWithActiveImage:(NSString *)image normalImage:(NSString *)normalImage btnClick:(NodeTouchBlock)nodeClick {
    if (self = [super init]) {
        _enable = YES;
        self.userInteractionEnabled = YES;
        self.buttonPressed = NO;
        self.normalSprite = [SKSpriteNode spriteNodeWithImageNamed:normalImage];
        self.activeSprite = [self activeSpriteWithActiveImage:image normalImage:normalImage];
        
        
        
        
        [self addChild:self.activeSprite];
        [self addChild:self.normalSprite];
        
        self.activeSprite.hidden = YES;
        self.normalSprite.hidden = NO;
        
        _nodeTouchBlock = nodeClick;
        self.size = self.normalSprite.size;
    }
    
    return self;
}

- (id)initWithActiveImage:(NSString *)image normalImage:(NSString *)normalImage disableImage:(NSString *)disableImage disableNormalImage:(NSString *)disableNormalImage enable:(BOOL)enable btnClick:(NodeTouchBlock)nodeClick {
    if (self = [super init]) {
        _image = image;
        _normalImage = normalImage;
        _disableImage = disableImage;
        _disableNormalImage = disableNormalImage;
        _enable = enable;
        
        self.userInteractionEnabled = YES;
        self.buttonPressed = NO;
        if (enable) {
            self.normalSprite = [SKSpriteNode spriteNodeWithImageNamed:normalImage];
            self.activeSprite = [self activeSpriteWithActiveImage:image normalImage:normalImage];
        } else {
            self.normalSprite = [SKSpriteNode spriteNodeWithImageNamed:disableNormalImage];
            self.activeSprite = [self activeSpriteWithActiveImage:disableImage normalImage:disableNormalImage];
        }
        
        [self addChild:self.activeSprite];
        [self addChild:self.normalSprite];
        
        self.activeSprite.hidden = YES;
        self.normalSprite.hidden = NO;
        self.nodeTouchBlock = nodeClick;
        self.size = self.normalSprite.size;
    }
    return self;
}

- (id)initWithActiveImage:(NSString *)image normalImage:(NSString *)normalImage {
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        self.buttonPressed = NO;
        self.normalSprite = [SKSpriteNode spriteNodeWithImageNamed:normalImage];
        self.activeSprite = [self activeSpriteWithActiveImage:image normalImage:normalImage];
        _enable = YES;
        
        [self addChild:self.activeSprite];
        [self addChild:self.normalSprite];
        
        self.activeSprite.hidden = YES;
        self.normalSprite.hidden = NO;
        self.size = self.normalSprite.size;
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.enable && !self.disableCanTouch) {
        return;
    }
    _buttonActive = !_buttonActive;
    if (_labelNode) {
        _labelNode.fontColor = [SKColor redColor];
    }
    self.activeSprite.hidden = NO;
    self.normalSprite.hidden = YES;
    self.buttonPressed = YES;
    
    if (self.actionMusicName) {
        [self beepByName:self.actionMusicName waitForCompletion:YES];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.enable && !self.disableCanTouch) {
        return;
    }
    self.activeSprite.hidden = YES;
    self.normalSprite.hidden = NO;
    if (self.nodeTouchBlock) {
       self.nodeTouchBlock(self);
    }
    self.buttonPressed = NO;
    if (_labelNode) {
        _labelNode.fontColor = [SKColor whiteColor];
    }
    
    if (self.disableNormalImage) {
        if (self.enable) {
           self.normalSprite.texture = [SKTexture textureWithImage:[UIImage imageNamed:self.normalImage]];
           self.activeSprite = [self activeSpriteWithActiveImage:self.image normalImage:self.normalImage];
        } else {
           self.normalSprite.texture = [SKTexture textureWithImage:[UIImage imageNamed:self.disableNormalImage]];
           self.activeSprite = [self activeSpriteWithActiveImage:self.disableImage normalImage:self.disableNormalImage];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.enable && !self.disableCanTouch) {
        return;
    }
    self.activeSprite.hidden = YES;
    self.normalSprite.hidden = NO;
    self.buttonPressed = NO;
    if (_labelNode) {
        _labelNode.fontColor = [SKColor whiteColor];
    }
}

- (SKSpriteNode *)activeSpriteWithActiveImage:(nullable NSString *)activeImage normalImage:(NSString *)normalImage {
    if (activeImage) {
        if (self.activeSprite) {
            self.activeSprite.texture = [SKTexture textureWithImage:[UIImage imageNamed:activeImage]];
            return self.activeSprite;
        }
       return [SKSpriteNode spriteNodeWithImageNamed:activeImage];
    } else {
        if (self.activeSprite) {
            self.activeSprite.texture = [SKTexture textureWithImage:[UIImage imageNamed:normalImage]];
            ((SKSpriteNode *)self.activeSprite.children.firstObject).texture = [SKTexture textureWithImage:[UIImage imageNamed:normalImage]];
            return self.activeSprite;
        }
        SKSpriteNode *spriteNode = [SKSpriteNode spriteNodeWithImageNamed:normalImage];
        SKSpriteNode *selectedStateNode =  [SKSpriteNode spriteNodeWithImageNamed:normalImage];
        selectedStateNode.position = CGPointMake(0.0f, 0.0f);
        [spriteNode addChild:selectedStateNode];
        selectedStateNode.blendMode = SKBlendModeAlpha;
        selectedStateNode.colorBlendFactor = 1;
        selectedStateNode.color = [SKColor blackColor];
        selectedStateNode.alpha = .25;
        selectedStateNode.name = @"shadow";
        return spriteNode;
    }
}

- (void)setEnable:(BOOL)enable {
    _enable = enable;
    if (self.enable) {
       self.normalSprite.texture = [SKTexture textureWithImage:[UIImage imageNamed:self.normalImage]];
       self.activeSprite = [self activeSpriteWithActiveImage:self.image normalImage:self.normalImage];
    } else {
        if (self.disableNormalImage) {
            self.normalSprite.texture = [SKTexture textureWithImage:[UIImage imageNamed:self.disableNormalImage]];
            self.activeSprite = [self activeSpriteWithActiveImage:self.disableImage normalImage:self.disableNormalImage];
        }
    }
}
@end
