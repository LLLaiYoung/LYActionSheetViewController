//
//  ViewController.m
//  ActionSheetViewDemo
//
//  Created by LaiYoung_ on 2017/10/13.
//  Copyright © 2017年 LaiYoung_. All rights reserved.
//

#import "ViewController.h"
#import "LYActionSheetViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _btn.hidden = NO;
}

- (IBAction)clickedBtn:(id)sender {
//    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
//    redView.backgroundColor = [UIColor redColor];
//    LYActionSheetViewController *actionSheetVC = [LYActionSheetViewController actionSheetControllerWithCustomView:redView];

//    LYActionSheetViewController *actionSheetVC = [LYActionSheetViewController actionSheetControllerWithTitle:@"title" message:@"message"];
    
    NSAttributedString *titleAttr = [[NSAttributedString alloc] initWithString:@"Title" attributes:@{NSForegroundColorAttributeName:[UIColor cyanColor],NSUnderlineStyleAttributeName:@1}];
    NSAttributedString *msgAttr = [[NSAttributedString alloc] initWithString:@"Message" attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSUnderlineStyleAttributeName:@1}];
    LYActionSheetViewController *actionSheetVC = [LYActionSheetViewController actionSheetControllerWithTitleAttributedString:titleAttr messageAttributedString:msgAttr];
    
    LYAlertAction *cancelAction = [LYAlertAction actionWithTitle:@"取消" style:LYAlertActionStyleCancel handler:^(LYAlertAction * _Nonnull action) {
        NSLog(@"clickedCancel");
        _btn.hidden = NO;
    }];
    [actionSheetVC addAction:cancelAction];
    
    NSAttributedString *acAttr = [[NSAttributedString alloc] initWithString:@"Cancel" attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSStrikethroughStyleAttributeName:@1}];
    LYAlertAction *e_Action = [LYAlertAction actionWithTitleAttributedString:acAttr style:LYAlertActionStyleDefault handler:^(LYAlertAction * _Nonnull action) {
        NSLog(@"clicked_AttributedAction");
        _btn.hidden = NO;
    }];
    [actionSheetVC addAction:e_Action];
    
    LYAlertAction *a_Action = [LYAlertAction actionWithTitle:@"A_ActionView" style:LYAlertActionStyleDefault handler:^(LYAlertAction * _Nonnull action) {
        NSLog(@"A_ActionView");
        _btn.hidden = NO;
    }];
    [actionSheetVC addAction:a_Action];
    
    LYAlertAction *b_Action = [LYAlertAction actionWithTitle:@"titletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitle\nmessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemess\na\ng\ne" style:LYAlertActionStyleDestructive handler:^(LYAlertAction * _Nonnull action) {
        NSLog(@"B_ActionView");
        _btn.hidden = NO;
    }];
//    b_Action.enabled = NO;
    [actionSheetVC addAction:b_Action];
    
    LYAlertAction *d_Action = [LYAlertAction actionWithTitle:@"销毁" style:LYAlertActionStyleDestructive handler:^(LYAlertAction * _Nonnull action) {
        NSLog(@"d_ActionView");
        _btn.hidden = NO;
    }];
    //    b_Action.enabled = NO;
    [actionSheetVC addAction:d_Action];
    
    UIView *yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 55.0f)];
    yellowView.backgroundColor = [UIColor yellowColor];
    LYAlertAction *c_Action = [LYAlertAction actionWithCustomView:yellowView handler:^(LYAlertAction * _Nonnull action) {
        NSLog(@"clicked CustomView");
        _btn.hidden = NO;
    }];
    [actionSheetVC addAction:c_Action];
    
    [self presentViewController:actionSheetVC animated:YES completion:^{
        _btn.hidden = YES;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
