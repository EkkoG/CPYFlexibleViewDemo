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
- (UIView *)cpy_topToSuperview:(CGFloat)constant {
    [self cpy_constraintEqualTo:NSLayoutAttributeTop toView:self.superview toAttribute:NSLayoutAttributeTop constant:constant];
    return self;
}
- (UIView *)cpy_leftToSuperview:(CGFloat)constant {
    [self cpy_constraintEqualTo:NSLayoutAttributeLeft toView:self.superview toAttribute:NSLayoutAttributeLeft constant:constant];
    return self;
}

- (UIView *)cpy_bottomToSuperview:(CGFloat)constant {
    [self cpy_constraintEqualTo:NSLayoutAttributeBottom toView:self.superview toAttribute:NSLayoutAttributeBottom constant:-constant];
    return self;
}

- (UIView *)cpy_rightToSuperview:(CGFloat)constant {
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

- (UIView *)cpy_alignXToSuperview {
    [self cpy_alignXToView:self.superview offset:0];
    return self;
}

- (UIView *)cpy_alignYToSuperview {
    [self cpy_alignYToView:self.superview offset:0];
    return self;
}

- (UIView *)cpy_centerToSuperview {
    [[self cpy_alignYToSuperview] cpy_alignXToSuperview];
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
            // 设置第一 View 到父 View 的左边距
            [tmp cpy_leftToSuperview:margin];
        }
        
        if (tmp == self.lastObject) {
            // 最后一个，设置到父 View 右边距
            [tmp cpy_rightToSuperview:margin];
        }
        else {
            // 不是最后一个，设置宽度相等和到下一个 View 的间距
            UIView *next = self[i + 1];
            [[tmp cpy_constraintEqualTo:NSLayoutAttributeWidth toView:next toAttribute:NSLayoutAttributeWidth constant:0] cpy_rightToLeftToView:next constant:spacing];
        }
        // 设置居中
        [tmp cpy_alignYToSuperview];
    }
}

- (void)cpy_flexibleHeightWithMargin:(CGFloat)margin spacing:(CGFloat)spacing {
    for (NSInteger i = 0; i < self.count; i++) {
        UIView *tmp = self[i];
        
        // 第一个，设置到父 View 顶部边距
        if (i == 0) {
            [tmp cpy_topToSuperview:margin];
        }
        
        if (tmp == self.lastObject) {
            // 最后一个，设置到父 View 下边距
            [tmp cpy_bottomToSuperview:margin];
        }
        else {
            // 不是最后一个，设置高度相等和到下一个 View 的间距
            UIView *next = self[i + 1];
            [[tmp cpy_constraintEqualTo:NSLayoutAttributeHeight toView:next toAttribute:NSLayoutAttributeHeight constant:0] cpy_bottomToTopToView:next constant:spacing];
        }
        // 设置居中
        [tmp cpy_alignXToSuperview];
        
    }
}

@end
