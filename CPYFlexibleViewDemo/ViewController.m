//
//  ViewController.m
//  CPYFlexibleViewDemo
//
//  Created by ciel on 16/8/29.
//  Copyright © 2016年 CPY. All rights reserved.
//

#import "ViewController.h"
#import "UIView+CPYLayout.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView *container = [[UIView alloc] init];
    [self.view addSubview:container];
    container.backgroundColor = [UIColor redColor];
    
//    [[[[container cpy_alignYToSuperview] cpy_toHeight:100] cpy_leftToSuperview:0] cpy_rightToSuperview:0];
    [container cpy_centerToSuperview];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 8; i++) {
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor blueColor];
        [container addSubview:v];
        [arr addObject:v];
//        [[[v cpy_toWidth:20] cpy_topToSuperview:0] cpy_bottomToSuperview:0];
        [[[v cpy_toWidth:20] cpy_leftToSuperview:0] cpy_rightToSuperview:0];
        [v cpy_constraintEqualTo:NSLayoutAttributeWidth toView:v toAttribute:NSLayoutAttributeHeight constant:0];
    }
    
//    [arr cpy_flexibleWidthWithMargin:0 spacing:10];
    [arr cpy_flexibleHeightWithMargin:0 spacing:5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
