//
//  ViewController.m
//  ActionSheetViewDemo
//
//  Created by LaiYoung_ on 2017/10/13.
//  Copyright © 2017年 LaiYoung_. All rights reserved.
//

#import "ViewController.h"
#import "LYActionSheetViewController.h"
#import "CustomActionSheetViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic, strong) LYActionSheetViewController *actionSheetVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _btn.hidden = NO;
}
- (IBAction)getterPropertyBtn:(UIButton *)sender {
    NSLog(@"________title = %@",self.actionSheetVC.actionControllerTitle);
    NSLog(@"________message = %@",self.actionSheetVC.actionControllerMessage);
    NSLog(@"________titleAttr = %@",self.actionSheetVC.actionControllerTitleAttributedString);
    NSLog(@"________messageAttr = %@",self.actionSheetVC.actionControllerMessageAttributedString);
    NSLog(@"________customView = %@",self.actionSheetVC.customView);
}

- (IBAction)clickedBtn:(id)sender {
//    {
//            UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
//            redView.backgroundColor = [UIColor redColor];
//            LYActionSheetViewController *actionSheetVC = [LYActionSheetViewController actionSheetControllerWithCustomView:redView];
//
//        //    LYActionSheetViewController *actionSheetVC = [LYActionSheetViewController actionSheetControllerWithTitle:@"title" message:@"message"];
//    }
    
//    {
//        NSAttributedString *titleAttr = [[NSAttributedString alloc] initWithString:@"Title" attributes:@{NSForegroundColorAttributeName:[UIColor cyanColor],NSUnderlineStyleAttributeName:@1}];
//        NSAttributedString *msgAttr = [[NSAttributedString alloc] initWithString:@"Message" attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSUnderlineStyleAttributeName:@1}];
//
////        LYActionSheetViewController *actionSheetVC = [LYActionSheetViewController actionSheetControllerWithTitleAttributedString:titleAttr messageAttributedString:msgAttr];
//
//        LYAlertAction *cancelAction = [LYAlertAction actionWithTitle:@"取消" style:LYAlertActionStyleCancel handler:^(LYAlertAction * _Nonnull action) {
//            NSLog(@"clickedCancel");
//            _btn.hidden = NO;
//        }];
//        [actionSheetVC addAction:cancelAction];
//
//        NSAttributedString *acAttr = [[NSAttributedString alloc] initWithString:@"Cancel" attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSStrikethroughStyleAttributeName:@1}];
//        LYAlertAction *e_Action = [LYAlertAction actionWithTitleAttributedString:acAttr style:LYAlertActionStyleDefault handler:^(LYAlertAction * _Nonnull action) {
//            NSLog(@"clicked_AttributedAction");
//            _btn.hidden = NO;
//        }];
//        [actionSheetVC addAction:e_Action];
//
//        LYAlertAction *a_Action = [LYAlertAction actionWithTitle:@"A_ActionView" style:LYAlertActionStyleDefault handler:^(LYAlertAction * _Nonnull action) {
//            NSLog(@"A_ActionView");
//            _btn.hidden = NO;
//        }];
//        [actionSheetVC addAction:a_Action];
//
//        //    LYAlertAction *b_Action = [LYAlertAction actionWithTitle:@"titletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitle\nmessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemessagemess\na\ng\ne" style:LYAlertActionStyleDestructive handler:^(LYAlertAction * _Nonnull action) {
//        //        NSLog(@"B_ActionView");
//        //        _btn.hidden = NO;
//        //    }];
//        ////    b_Action.enabled = NO;
//        //    [actionSheetVC addAction:b_Action];
//
//        LYAlertAction *d_Action = [LYAlertAction actionWithTitle:@"销毁" style:LYAlertActionStyleDestructive handler:^(LYAlertAction * _Nonnull action) {
//            NSLog(@"d_ActionView");
//            _btn.hidden = NO;
//        }];
//        //    b_Action.enabled = NO;
//        [actionSheetVC addAction:d_Action];
//
//        UIView *yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 55.0f)];
//        yellowView.backgroundColor = [UIColor yellowColor];
//        LYAlertAction *c_Action = [LYAlertAction actionWithCustomView:yellowView handler:^(LYAlertAction * _Nonnull action) {
//            NSLog(@"clicked CustomView");
//            _btn.hidden = NO;
//        }];
//        [actionSheetVC addAction:c_Action];
//
//        [self presentViewController:actionSheetVC animated:YES completion:^{
//            _btn.hidden = YES;
//        }];
//    }

//    {
//        [LYActionSheetViewController showInViewController:self title:@"title" message:@"message" cancelButtonTitle:@"cancel" destructiveButtonTitle:@"destructive" otherButtonTitles:@[@"1",@"2",@"3"] controllerHandler:^(LYActionSheetViewController * _Nonnull controller, LYAlertAction * _Nonnull action, NSInteger buttonIndex) {
//            NSLog(@"index = %li",(long)buttonIndex);
//        }];
//    }
    
    {

//        NSAttributedString *titleAttr = [[NSAttributedString alloc] initWithString:@"Title" attributes:@{NSForegroundColorAttributeName:[UIColor cyanColor],NSUnderlineStyleAttributeName:@1}];
//        NSAttributedString *msgAttr = [[NSAttributedString alloc] initWithString:@"Message" attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSUnderlineStyleAttributeName:@1}];
//        NSAttributedString *cancelAttr = [[NSAttributedString alloc] initWithString:@"Cancel" attributes:@{NSForegroundColorAttributeName:[UIColor blueColor],NSUnderlineStyleAttributeName:@1}];
//        NSAttributedString *destructiveAttr = [[NSAttributedString alloc] initWithString:@"destructive" attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSStrikethroughStyleAttributeName:@1}];
//        [LYActionSheetViewController showInViewController:self titleAttributedString:titleAttr messageAttributedString:msgAttr cancelButtonTitleAttrubutedString:cancelAttr destructiveButtonTitleAttrubutedString:destructiveAttr otherButtonTitleAttrubutedStrings:@[titleAttr,msgAttr,cancelAttr] controllerHandler:^(LYActionSheetViewController * _Nonnull controller, LYAlertAction * _Nonnull action, NSInteger buttonIndex) {
//               NSLog(@"index = %li",(long)buttonIndex);
//        }];
        
//        [LYActionSheetViewController showInViewController:self titleAttributedString:nil messageAttributedString:nil cancelButtonTitleAttrubutedString:cancelAttr destructiveButtonTitleAttrubutedString:destructiveAttr otherButtonTitleAttrubutedStrings:@[titleAttr,msgAttr,cancelAttr] controllerHandler:^(LYActionSheetViewController * _Nonnull controller, LYAlertAction * _Nonnull action, NSInteger buttonIndex) {
//            NSLog(@"index = %li",(long)buttonIndex);
//        }];
        
//        [LYActionSheetViewController showInViewController:self titleAttributedString:nil messageAttributedString:nil cancelButtonTitleAttrubutedString:nil destructiveButtonTitleAttrubutedString:destructiveAttr otherButtonTitleAttrubutedStrings:@[titleAttr,msgAttr,cancelAttr] controllerHandler:^(LYActionSheetViewController * _Nonnull controller, LYAlertAction * _Nonnull action, NSInteger buttonIndex) {
//            NSLog(@"index = %li",(long)buttonIndex);
//        }];
        
//        [LYActionSheetViewController showInViewController:self titleAttributedString:nil messageAttributedString:nil cancelButtonTitleAttrubutedString:cancelAttr destructiveButtonTitleAttrubutedString:nil otherButtonTitleAttrubutedStrings:nil controllerHandler:^(LYActionSheetViewController * _Nonnull controller, LYAlertAction * _Nonnull action, NSInteger buttonIndex) {
//            NSLog(@"index = %li",(long)buttonIndex);
//        }];
    }
    
//    {
//        CGFloat width = self.view.frame.size.width;
//        UIView *red = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 150)];
//        red.backgroundColor = [UIColor redColor];
//
//        UIView *yellow = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 20, 20)];
//        yellow.backgroundColor = [UIColor yellowColor];
//
//        UIView *des = [[UIView alloc] initWithFrame:CGRectMake(0, 100, width, 50)];
//        des.backgroundColor = [UIColor brownColor];
//
////        @[red,yellow,des]
////        [LYActionSheetViewController showInViewController:self customView:red cancelCustomView:yellow destructiveCustomView:des otherCustomViews:@[yellow,red,des] controllerHandler:^(LYActionSheetViewController * _Nonnull controller, LYAlertAction * _Nonnull action, NSInteger buttonIndex) {
////               NSLog(@"index = %li",(long)buttonIndex);
////        }];
//
//        //正常
////        [LYActionSheetViewController showInViewController:self customView:red cancelCustomView:yellow destructiveCustomView:des otherCustomViews:nil controllerHandler:^(LYActionSheetViewController * _Nonnull controller, LYAlertAction * _Nonnull action, NSInteger buttonIndex) {
////            NSLog(@"index = %li",(long)buttonIndex);
////        }];
//
//        [LYActionSheetViewController showInViewController:self customView:red cancelCustomView:yellow destructiveCustomView:des otherCustomViews:@[red] controllerHandler:^(LYActionSheetViewController * _Nonnull controller, LYAlertAction * _Nonnull action, NSInteger buttonIndex) {
//            NSLog(@"index = %li",(long)buttonIndex);
//        }];
//    }
    
    [self useNSString];
    
//    [self useSystem];
    
//    [self customVC];
}

- (void)customVC {
    CustomActionSheetViewController *vc = [[CustomActionSheetViewController alloc] init];
    ////    vc.actionControllerTitle = @"title";
    //    vc.actionControllerMessage = @"message";
    //
    ////    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    ////    redView.backgroundColor = [UIColor redColor];
    ////    vc.customView = redView;
    //
    //    NSAttributedString *titleAttr = [[NSAttributedString alloc] initWithString:@"Title" attributes:@{NSForegroundColorAttributeName:[UIColor cyanColor],NSUnderlineStyleAttributeName:@1}];
    //    NSAttributedString *msgAttr = [[NSAttributedString alloc] initWithString:@"Message" attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSUnderlineStyleAttributeName:@1}];
    ////    vc.actionControllerTitleAttributedString = titleAttr;
    ////    vc.actionControllerMessageAttributedString = msgAttr;
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)useSystem {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"title" message:@"message" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *b_Action = [UIAlertAction actionWithTitle:@"b_title" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"...b");
    }];
    [alertController addAction:b_Action];
    
    UIAlertAction *c_Action = [UIAlertAction actionWithTitle:@"b_title" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"...c");
    }];
    [alertController addAction:c_Action];
    
    UIAlertAction *a_Action = [UIAlertAction actionWithTitle:@"a_title" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"...b");
    }];
    [alertController addAction:a_Action];
    
    UIAlertAction *d_Action = [UIAlertAction actionWithTitle:@"d_title" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"...d");
    }];
    [alertController addAction:d_Action];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

//    LYAlertActionStyleDefault = 0,
//    LYAlertActionStyleCancel,
//    LYAlertActionStyleDestructive
- (void)useNSString {
    /** 有title,有msg */
    LYActionSheetViewController *vc = [LYActionSheetViewController actionSheetControllerWithTitle:@"title" message:@"message"];
    
    /** 有title,无msg */
//    LYActionSheetViewController *vc = [LYActionSheetViewController actionSheetControllerWithTitle:@"title" message:nil];
    
    /** 有msg,无title */
//    LYActionSheetViewController *vc = [LYActionSheetViewController actionSheetControllerWithTitle:nil message:@"message"];
    
    /** 无msg,无title */
//    LYActionSheetViewController *vc = [LYActionSheetViewController actionSheetControllerWithTitle:nil message:nil];
    
    LYAlertAction *cancel = [LYAlertAction actionWithTitle:@"cancel" style:LYAlertActionStyleCancel handler:^(LYAlertAction * _Nonnull action) {
        NSLog(@"__%d__",__LINE__);
    }];
    [vc addAction:cancel];
    
    LYAlertAction *des = [LYAlertAction actionWithTitle:@"destructive" style:LYAlertActionStyleDestructive handler:^(LYAlertAction * _Nonnull action) {
        NSLog(@"__%d__",__LINE__);
    }];
    [vc addAction:des];
    
    LYAlertAction *def_a = [LYAlertAction actionWithTitle:@"Default_a" style:LYAlertActionStyleDefault handler:^(LYAlertAction * _Nonnull action) {
        NSLog(@"__%d__",__LINE__);
    }];
    
    [vc addAction:def_a];
    
    LYAlertAction *def_b = [LYAlertAction actionWithTitle:@"Default_b" style:LYAlertActionStyleDefault handler:^(LYAlertAction * _Nonnull action) {
        NSLog(@"__%d__",__LINE__);
    }];
    [vc addAction:def_b];
    self.actionSheetVC = vc;
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
