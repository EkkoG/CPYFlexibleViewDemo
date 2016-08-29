//
//  UIView+CPYLayout.m
//  CPYFlexibleViewDemo
//
//  Created by ciel on 16/8/29.
//  Copyright © 2016年 CPY. All rights reserved.
//

#import "UIView+CPYLayout.h"

@implementation UIView (CPYLayout)

// to superview
- (UIView *)cpy_topToSuperView:(CGFloat)constant {
    [self cpy_constraintEqualTo:NSLayoutAttributeTop toView:self.superview toAttribute:NSLayoutAttributeTop constant:constant];
    return self;
}
- (UIView *)cpy_leftToSuperView:(CGFloat)constant {
    [self cpy_constraintEqualTo:NSLayoutAttributeLeft toView:self.superview toAttribute:NSLayoutAttributeLeft constant:constant];
    return self;
}

- (UIView *)cpy_bottomToSuperView:(CGFloat)constant {
    [self cpy_constraintEqualTo:NSLayoutAttributeBottom toView:self.superview toAttribute:NSLayoutAttributeBottom constant:-constant];
    return self;
}

- (UIView *)cpy_rightToSuperView:(CGFloat)constant {
    [self cpy_constraintEqualTo:NSLayoutAttributeRight toView:self.superview toAttribute:NSLayoutAttributeRight constant:-constant];
    return self;
}


// to view
- (UIView *)cpy_topToView:(UIView *)toView constant:(CGFloat)constant {
    [self cpy_constraintEqualTo:NSLayoutAttributeTop toView:toView toAttribute:NSLayoutAttributeBottom constant:constant];
    return self;
}

- (UIView *)cpy_leftToView:(UIView *)toView constant:(CGFloat)constant {
    [self cpy_constraintEqualTo:NSLayoutAttributeLeft toView:toView toAttribute:NSLayoutAttributeRight constant:constant];
    return self;
}

- (UIView *)cpy_bottomToView:(UIView *)toView constant:(CGFloat)constant {
    [self cpy_constraintEqualTo:NSLayoutAttributeBottom toView:toView toAttribute:NSLayoutAttributeTop constant:-constant];
    return self;
}

- (UIView *)cpy_rightToView:(UIView *)toView constant:(CGFloat)constant {
    [self cpy_constraintEqualTo:NSLayoutAttributeRight toView:toView toAttribute:NSLayoutAttributeLeft constant:-constant];
    return self;
}

- (UIView *)cpy_rightToLeftToView:(UIView *)toView constant:(CGFloat)constant {
    [self cpy_constraintEqualTo:NSLayoutAttributeRight toView:toView toAttribute:NSLayoutAttributeLeft constant:-constant];
    return self;
}

- (UIView *)cpy_bottomToTopToView:(UIView *)toView constant:(CGFloat)constant {
    [self cpy_constraintEqualTo:NSLayoutAttributeBottom toView:toView toAttribute:NSLayoutAttributeTop constant:-constant];
    return self;
}

// align
- (UIView *)cpy_alignXToView:(UIView *)toView {
    [self cpy_alignXToView:toView offset:0];
    return self;
}

- (UIView *)cpy_alignYToView:(UIView *)toView {
    [self cpy_alignYToView:toView offset:0];
    return self;
}

- (UIView *)cpy_alignXToSuperView {
    [self cpy_alignXToView:self.superview offset:0];
    return self;
}

- (UIView *)cpy_alignYToSuperView {
    [self cpy_alignYToView:self.superview offset:0];
    return self;
}

- (UIView *)cpy_centerToSuperView {
    [[self cpy_alignYToSuperView] cpy_alignXToSuperView];
    return self;
}

- (UIView *)cpy_alignXToView:(UIView *)toView offset:(CGFloat)offset {
    [self cpy_constraintEqualTo:NSLayoutAttributeCenterX toView:toView toAttribute:NSLayoutAttributeCenterX constant:offset];
    return self;
}

- (UIView *)cpy_alignYToView:(UIView *)toView offset:(CGFloat)offset {
    [self cpy_constraintEqualTo:NSLayoutAttributeCenterY toView:toView toAttribute:NSLayoutAttributeCenterY constant:offset];
    return self;
}

// size
- (UIView *)cpy_toWidth:(CGFloat)width {
    [self cpy_constraintEqualTo:NSLayoutAttributeWidth toView:nil toAttribute:NSLayoutAttributeNotAnAttribute constant:width];
    return self;
}

- (UIView *)cpy_toHeight:(CGFloat)height {
    [self cpy_constraintEqualTo:NSLayoutAttributeHeight toView:nil toAttribute:NSLayoutAttributeNotAnAttribute constant:height];
    return self;
}

- (UIView *)cpy_toSize:(CGSize)size {
    [[self cpy_toWidth:size.width] cpy_toHeight:size.height];
    return self;
}

- (UIView *)cpy_constraintEqualTo:(NSLayoutAttribute)attribute toView:(UIView *)toView toAttribute:(NSLayoutAttribute)toAttribute constant:(CGFloat)constant {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:toView attribute:toAttribute multiplier:1 constant:constant];
    constraint.active = YES;
    return self;
}
@end

@implementation NSArray (cpy_layout)
// fleible

- (void)cpy_flexibleWidthWithMargin:(CGFloat)margin spacing:(CGFloat)spacing {
    for (NSInteger i = 0; i < self.count; i++) {
        UIView *tmp = self[i];
        
        if (i == 0) {
            [tmp cpy_leftToSuperView:margin];
        }
        
        if (tmp == self.lastObject) {
            // 最后一个，设置到父 View 右边距
            [tmp cpy_rightToSuperView:margin];
        }
        else {
            // 不是最后一个，设置宽度相等和到下一个 View 的间距
            UIView *next = self[i + 1];
            [[tmp cpy_constraintEqualTo:NSLayoutAttributeWidth toView:next toAttribute:NSLayoutAttributeWidth constant:0] cpy_rightToLeftToView:next constant:spacing];
        }
        // 设置居中
        [tmp cpy_alignYToSuperView];
        
    }
}

- (void)cpy_flexibleHeightWithMargin:(CGFloat)margin spacing:(CGFloat)spacing {
    for (NSInteger i = 0; i < self.count; i++) {
        UIView *tmp = self[i];
        
        if (i == 0) {
            [tmp cpy_topToSuperView:margin];
        }
        
        if (tmp == self.lastObject) {
            // 最后一个，设置到父 View 右边距
            [tmp cpy_bottomToSuperView:margin];
        }
        else {
            // 不是最后一个，设置宽度相等和到下一个 View 的间距
            UIView *next = self[i + 1];
            [[tmp cpy_constraintEqualTo:NSLayoutAttributeHeight toView:next toAttribute:NSLayoutAttributeHeight constant:0] cpy_bottomToTopToView:next constant:spacing];
        }
        // 设置居中
        [tmp cpy_alignXToSuperView];
        
    }
}

@end
