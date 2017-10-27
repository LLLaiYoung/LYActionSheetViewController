//
//  LYActionSheetViewController.h
//  ActionSheetViewDemo
//
//  Created by LaiYoung_ on 2017/10/13.
//  Copyright © 2017年 LaiYoung_. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, LYAlertActionStyle) {
    LYAlertActionStyleDefault = 0,
    LYAlertActionStyleCancel,
    LYAlertActionStyleDestructive
};

@interface LYAlertAction : NSObject

+ (instancetype _Nonnull )actionWithTitle:(nonnull NSString *)title style:(LYAlertActionStyle)style handler:(void (^ __nullable)(LYAlertAction * _Nonnull action))handler;

+ (instancetype _Nonnull )actionWithTitleAttributedString:(nonnull NSAttributedString *)title style:(LYAlertActionStyle)style handler:(void (^ __nullable)(LYAlertAction * _Nonnull action))handler;

+ (instancetype _Nonnull )actionWithCustomView:(nonnull UIView *)customView handler:(void (^ __nullable)(LYAlertAction * _Nonnull action))handler;

@property (nullable, nonatomic, readonly) NSString *title;
@property (nullable, nonatomic, readonly) NSAttributedString *titltAttributedString;
@property (nullable, nonatomic, readonly) UIView *customView;
@property (nonatomic, readonly) LYAlertActionStyle style;
@property (nonatomic, getter=isEnabled) BOOL enabled;

@end

@interface LYActionSheetViewController : UIViewController

typedef void (^LYActionSheetViewControllerHandler)(LYActionSheetViewController * __nonnull controller, LYAlertAction * __nonnull action, NSInteger buttonIndex);

/** Use NSString fast create an ActionSheetViewController. if has cancelButtonTitle,the index is 0,otherActions index is Straight down ++ */
+ (instancetype _Nonnull )showInViewController:(nonnull UIViewController *)viewController
                                         title:(nullable NSString *)title
                                       message:(nullable NSString *)message
                             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                        destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
                             otherButtonTitles:(nullable NSArray <NSString *> *)otherButtonTitles
                             controllerHandler:(nullable LYActionSheetViewControllerHandler)handler;

/** Use NSAtttributedString */
+ (instancetype _Nonnull )showInViewController:(nonnull UIViewController *)viewController
                         titleAttributedString:(nullable NSAttributedString *)title
                       messageAttributedString:(nullable NSAttributedString *)message
             cancelButtonTitleAttrubutedString:(nullable NSAttributedString *)cancelButtonTitle
        destructiveButtonTitleAttrubutedString:(nullable NSAttributedString *)destructiveButtonTitle
             otherButtonTitleAttrubutedStrings:(nullable NSArray <NSAttributedString *> *)otherButtonTitles
                             controllerHandler:(nullable LYActionSheetViewControllerHandler)handler;

/** Use UIView custom */
+ (instancetype _Nonnull )showInViewController:(nonnull UIViewController *)viewController
                                    customView:(nullable UIView *)customView
                              cancelCustomView:(nullable UIView *)cancelCustomView
                         destructiveCustomView:(nullable UIView *)destructiveCustomView
                              otherCustomViews:(nullable NSArray <UIView *> *)otherCustomViews
                             controllerHandler:(nullable LYActionSheetViewControllerHandler)handler;

+ (instancetype _Nonnull )actionSheetControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message;

+ (instancetype _Nonnull )actionSheetControllerWithTitleAttributedString:(nullable NSAttributedString *)title messageAttributedString:(nullable NSAttributedString *)message;

+ (instancetype _Nonnull )actionSheetControllerWithCustomView:(nonnull UIView *)customView;

- (void)addAction:(LYAlertAction *_Nonnull)action;

@property (nonatomic, readonly) NSArray<LYAlertAction *> * _Nullable actions;

@property (nonatomic, copy) NSString * _Nullable actionControllerTitle;
@property (nonatomic, copy) NSString * _Nullable actionControllerMessage;
@property (nonatomic, copy) NSAttributedString * _Nullable actionControllerTitleAttributedString;
@property (nonatomic, copy) NSAttributedString * _Nullable actionControllerMessageAttributedString;
@property (nonatomic, strong) UIView * _Nullable customView;

@end
