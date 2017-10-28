//
//  CustomActionSheetViewController.m
//  ActionSheetViewDemo
//
//  Created by LaiYoung_ on 2017/10/26.
//  Copyright © 2017年 LaiYoung_. All rights reserved.
//

#import "CustomActionSheetViewController.h"

@interface CustomActionSheetViewController ()

@end

@implementation CustomActionSheetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.actionControllerTitle = @"aaaaaa";
    
    LYAlertAction *cancel = [LYAlertAction actionWithTitle:@"cancel" style:LYAlertActionStyleCancel handler:^(LYAlertAction * _Nonnull action) {
        NSLog(@"__%d__",__LINE__);
    }];
    [self addAction:cancel];
    
    LYAlertAction *des = [LYAlertAction actionWithTitle:@"destructive" style:LYAlertActionStyleDestructive handler:^(LYAlertAction * _Nonnull action) {
        NSLog(@"__%d__",__LINE__);
    }];
    [self addAction:des];
    
    LYAlertAction *def_a = [LYAlertAction actionWithTitle:@"Default_a" style:LYAlertActionStyleDefault handler:^(LYAlertAction * _Nonnull action) {
        NSLog(@"__%d__",__LINE__);
    }];
    
    [self addAction:def_a];
    
    LYAlertAction *def_b = [LYAlertAction actionWithTitle:@"Default_b" style:LYAlertActionStyleDefault handler:^(LYAlertAction * _Nonnull action) {
        NSLog(@"__%d__",__LINE__);
    }];
    [self addAction:def_b];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
