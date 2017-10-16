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

+ (instancetype _Nonnull )actionWithCustomView:(nonnull UIView *)customView handler:(void (^ __nullable)(LYAlertAction * _Nonnull action))handler;

@property (nullable, nonatomic, readonly) NSString *title;
@property (nullable, nonatomic, readonly) UIView *customView;
@property (nonatomic, readonly) LYAlertActionStyle style;
@property (nonatomic, getter=isEnabled) BOOL enabled;

@end

@interface LYActionSheetViewController : UIViewController

+ (instancetype _Nonnull )actionSheetControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message;

+ (instancetype _Nonnull )actionSheetControllerWithCustomView:(nullable UIView *)customView;

- (void)addAction:(LYAlertAction *_Nonnull)action;

@property (nonatomic, readonly) NSArray<LYAlertAction *> * _Nullable actions;


@end
