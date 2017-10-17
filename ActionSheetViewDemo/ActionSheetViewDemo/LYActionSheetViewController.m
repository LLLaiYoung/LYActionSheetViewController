//
//  LYActionSheetViewController.m
//  ActionSheetViewDemo
//
//  Created by LaiYoung_ on 2017/10/13.
//  Copyright © 2017年 LaiYoung_. All rights reserved.
//

#import "LYActionSheetViewController.h"
#import <Masonry/Masonry.h>

/** 圆角值 */
static CGFloat const cornerRadius = 10.0f;
/** 上下间隔 */
static CGFloat const topOrBottomSpacing = 14.5f;
/** 左右间隔 */
static CGFloat const leftOrRightSpacing = 10.0f;
/** view之间的间隔 */
static CGFloat const viewSpacing = 10.0f;
/** titleView／MessageView 最小高度 */
static CGFloat const titleOrMessageViewMinHeight = 44.0f;

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define SCREEN_WIDTH  MIN(SCREEN_SIZE.width, SCREEN_SIZE.height)
#define contentMaxWidth SCREEN_WIDTH - leftOrRightSpacing * 2

#pragma mark - --------  UIView (LYActionSheet)

@interface UIView (LYActionSheet)

- (void)roundingCorners:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius;

@end

@implementation UIView (LYActionSheet)

- (void)roundingCorners:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius {
    CGSize radio = CGSizeMake(cornerRadius, cornerRadius);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:radio];
    CAShapeLayer *masklayer = [[CAShapeLayer alloc]init];
    masklayer.frame = self.bounds;
    masklayer.path = path.CGPath;
    self.layer.mask = masklayer;
    [self.layer layoutIfNeeded];
}

- (void)setFrameWithHeight:(CGFloat)height {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGRect frame = self.frame;
    frame.size = CGSizeMake(screenWidth - leftOrRightSpacing * 2, height);
    self.frame = frame;
}

@end

#pragma mark - --------  Animation @interface

@interface LYActionSheetViewControllerPresentAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@end
@interface LYActionSheetViewControllerDismissAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@end

#pragma mark - --------  LYAlertAction

typedef void(^LYAlertActionHandler)(LYAlertAction * _Nonnull action);

@interface LYAlertAction ()

@property (nonatomic, copy) LYAlertActionHandler alertActionHandler;

@end

@implementation LYAlertAction

#pragma mark - Public Methods

+ (instancetype _Nonnull )actionWithTitle:(nonnull NSString *)title style:(LYAlertActionStyle)style handler:(void (^ __nullable)(LYAlertAction * _Nonnull action))handler {
    return [[self alloc] initWithActionTitle:title customView:nil style:style handler:handler];
}

+ (instancetype _Nonnull )actionWithTitleAttributedString:(nonnull NSAttributedString *)title style:(LYAlertActionStyle)style handler:(void (^ __nullable)(LYAlertAction * _Nonnull action))handler {
    return [[self alloc] initWithActionTitle:title customView:nil style:style handler:handler];
}

+ (instancetype _Nonnull )actionWithCustomView:(nonnull UIView *)customView handler:(void (^ __nullable)(LYAlertAction * _Nonnull action))handler {
    return [[self alloc] initWithActionTitle:nil customView:customView style:LYAlertActionStyleDefault handler:handler];
}

#pragma mark - initialize

- (instancetype)initWithActionTitle:(nullable id/*NSString,NSAttributedString*/)title customView:(nullable UIView *)customView style:(LYAlertActionStyle)style handler:(void (^ __nullable)(LYAlertAction * _Nonnull action))handler {
    if (self = [super init]) {
        if ([title isKindOfClass:[NSString class]]) {
            _title = title;
        } else {
            _titltAttributedString = title;
        }
        _customView = customView;
        _style = style;
        _alertActionHandler = handler;
        _enabled = YES;
    }
    return self;
}

@end

#pragma mark - --------  LYAlertTitle_MessageView

@interface LYAlertTitle_MessageView : UIView

@end

@implementation LYAlertTitle_MessageView

+ (instancetype)title:(nullable NSString *)title message:(nullable NSString *)message {
    return [[self alloc] initWithTitle:title message:message customView:nil];
}

+ (instancetype)titleAttributedString:(nullable NSAttributedString *)title messageAttributedString:(nullable NSAttributedString *)message {
    return [[self alloc] initWithTitle:title message:message customView:nil];
}

+ (instancetype)alertOrMessageCustomView:(nullable UIView *)customView {
    return [[self alloc] initWithTitle:nil message:nil customView:customView];
}

- (instancetype)initWithTitle:(nullable id/*NSString,NSAttributedString*/)title message:(nullable id/*NSString,NSAttributedString*/)message customView:(nullable UIView *)customView {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        if (customView) {
            [self setFrameWithHeight:customView.frame.size.height];
            [self addSubview:customView];
            CGSize viewSize = self.frame.size;
            [customView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(viewSize);
                make.center.mas_equalTo(self);
            }];
        } else {
            UILabel *titleLabel = nil;
            if (title) {
                titleLabel = [self titleOrMessageLabelWithText:title title:YES];
                CGFloat height = titleLabel.intrinsicContentSize.height + topOrBottomSpacing * 2;
                [self setFrameWithHeight:(height < titleOrMessageViewMinHeight) ? titleOrMessageViewMinHeight : height];
                
                [self addSubview:titleLabel];
                [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self).mas_offset(topOrBottomSpacing);
                    make.left.mas_equalTo(self).offset(leftOrRightSpacing);
                    make.right.mas_equalTo(self).offset(-leftOrRightSpacing);
                }];
                [titleLabel layoutIfNeeded];
            }
            
            UILabel *messageLabel = nil;
            if (message) {
                messageLabel = [self titleOrMessageLabelWithText:message title:NO];
                if (titleLabel) {
                    CGFloat height = topOrBottomSpacing + titleLabel.intrinsicContentSize.height + topOrBottomSpacing/2.0f + messageLabel.intrinsicContentSize.height + topOrBottomSpacing;
                    [self setFrameWithHeight:(height < 83.0f) ? 83.0f : height];
                } else {
                    CGFloat height = messageLabel.intrinsicContentSize.height + topOrBottomSpacing * 2;
                    [self setFrameWithHeight:(height < titleOrMessageViewMinHeight) ? titleOrMessageViewMinHeight : height];
                }
                
                [self addSubview:messageLabel];
                [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self).offset(leftOrRightSpacing);
                    make.right.mas_equalTo(self).offset(-leftOrRightSpacing);
                    if (titleLabel) {
                        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(topOrBottomSpacing/2.0f);
                    } else {
                        make.top.mas_equalTo(self).mas_offset(topOrBottomSpacing);
                    }
                }];
                [messageLabel layoutIfNeeded];
            }
        }
    }
    return self;
}

- (UILabel *)titleOrMessageLabelWithText:(id/*NSString,NSAttributedString*/)text title:(BOOL)title {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, contentMaxWidth, CGFLOAT_MAX)];
    if (title) {
        titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    } else {
        titleLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    if ([text isKindOfClass:[NSString class]]) {
        titleLabel.text = text;
    } else {
        titleLabel.attributedText = text;
    }
    titleLabel.preferredMaxLayoutWidth = contentMaxWidth;
    [titleLabel sizeToFit];
    return titleLabel;
}

@end

#pragma mark - --------  LYAlertActionView

typedef void(^LYActionSheetDismissBlock)(void);

@interface LYAlertActionView : UIView

@property (nonatomic, copy) LYAlertActionHandler alertActionHandler;

@property (nonatomic, strong) LYAlertAction *action;

@property (nonatomic, copy) LYActionSheetDismissBlock dismissBlock;

@property (nonatomic, strong) UIImage *whiteImage;
@property (nonatomic, strong) UIImage *grayImage;

@end

@implementation LYAlertActionView

+ (instancetype)alertActionView:(LYAlertAction *)action {
    return [[self alloc] initWithAction:action];
}

+ (instancetype)alertActionCustomView:(LYAlertAction *)action {
    return [[self alloc] initWithAction:action];
}

- (instancetype)initWithAction:(LYAlertAction *)action {
    self = [super init];
    if (self) {
        self.action = action;
        self.userInteractionEnabled = action.isEnabled;
        self.backgroundColor = [UIColor whiteColor];
        self.alertActionHandler = [action.alertActionHandler copy];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedMe:)];
        [self addGestureRecognizer:tapGesture];
        
        if (action.customView) {
            [self setFrameWithHeight:action.customView.frame.size.height];
            [self addSubview:action.customView];
            CGSize viewSize = self.frame.size;
            [action.customView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(viewSize);
                make.center.mas_equalTo(self);
            }];
        } else {
            if (action.title.length > 0 || action.titltAttributedString.length > 0) {
                UIButton *actionBtn = [self actionButton:action];
                CGFloat height = actionBtn.titleLabel.intrinsicContentSize.height + 20.0f;
                [self setFrameWithHeight: (height < 57.0f) ? 57.0f : height];//最小57.0f
                
                [self addSubview:actionBtn];
                [actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(self);
                }];
                [actionBtn layoutIfNeeded];
                /** 设置actionBtn.titleLabel的frame */
                [actionBtn.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, leftOrRightSpacing, 0, leftOrRightSpacing));
                }];
                [actionBtn.titleLabel layoutIfNeeded];
            } else {
                return nil;
            }
        }
    }
    return self;
}

#pragma mark - IBAction

- (void)actionButtonDidClicked:(UIButton *)sender {
    !self.alertActionHandler ?: self.alertActionHandler(self.action);
    !self.dismissBlock ?: self.dismissBlock();
}

- (void)clickedMe:(UITapGestureRecognizer *)sender {
    !self.alertActionHandler ?: self.alertActionHandler(self.action);
    !self.dismissBlock ?: self.dismissBlock();
}

- (UILabel *)titleLabel:(NSString *)text style:(LYAlertActionStyle)style enable:(BOOL)enable {
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - leftOrRightSpacing * 2 * 2;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, maxWidth, CGFLOAT_MAX)];
    if (style == LYAlertActionStyleDestructive) {
        titleLabel.textColor = [UIColor redColor];
    } else {
        titleLabel.textColor = [UIColor blueColor];
    }
    if (!enable) {
        titleLabel.textColor = [UIColor lightGrayColor];
    }
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    titleLabel.text = text;
    titleLabel.preferredMaxLayoutWidth = maxWidth;
    [titleLabel sizeToFit];
    return titleLabel;
}

- (UIButton *)actionButton:(LYAlertAction *)action {
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    actionButton.frame = CGRectMake(0, 0, contentMaxWidth, CGFLOAT_MAX);
    if (action.title.length > 0) {//NSString 类型
        [actionButton setTitle:action.title forState:UIControlStateNormal];
    } else {//NSAttributedString 类型
        [actionButton setAttributedTitle:action.titltAttributedString forState:UIControlStateNormal];
    }
    [actionButton setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
    [actionButton.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
    actionButton.titleLabel.numberOfLines = 0;
    actionButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    actionButton.titleLabel.preferredMaxLayoutWidth = contentMaxWidth - leftOrRightSpacing * 2;
    [actionButton sizeToFit];
    
    [actionButton setBackgroundImage:self.whiteImage forState:UIControlStateNormal];
    [actionButton setBackgroundImage:self.grayImage forState:UIControlStateHighlighted];
    
    if (action.style == LYAlertActionStyleDestructive) {
        [actionButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    } else if (action.style == LYAlertActionStyleCancel) {
        actionButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    }
    
    if (!action.isEnabled) {//禁用
        [actionButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    }
    actionButton.enabled = action.isEnabled;
    
    [actionButton addTarget:self action:@selector(actionButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    return actionButton;
}

#pragma mark - Getter Methods

- (UIImage *)whiteImage {
    return [UIImage imageNamed:@"as_white"];
}

- (UIImage *)grayImage {
    return [UIImage imageNamed:@"as_gray"];
}

@end

#pragma mark - --------  LYActionSheetViewController

@class LYActionSheetViewControllerPresentAnimator;

@interface LYActionSheetViewController ()
/** 灰色半透明背景 */
@property (nonnull, nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) LYAlertAction *cancelAction;
@property (nonatomic, strong) LYAlertActionView *cancelActionView;
@property (nonatomic, strong) NSMutableArray <LYAlertAction *> *alertActions;
@property (nonatomic, strong) NSMutableArray <LYAlertActionView *> *alertActionViews;
@property (nonatomic, strong) LYAlertTitle_MessageView *title_msgView;
@property (nonatomic, assign) CGFloat totalHeight;

@end

@implementation LYActionSheetViewController

#pragma mark - Public Methods

+ (instancetype _Nonnull )actionSheetControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message {
    LYAlertTitle_MessageView *titleOrMessageView = [LYAlertTitle_MessageView title:title message:message];
    return [[self alloc] initViewTitleOrMessageView:titleOrMessageView];
}

+ (instancetype _Nonnull )actionSheetControllerWithCustomView:(nullable UIView *)customView {
    LYAlertTitle_MessageView *titleOrMessageView = [LYAlertTitle_MessageView alertOrMessageCustomView:customView];
    return [[self alloc] initViewTitleOrMessageView:titleOrMessageView];
}

+ (instancetype _Nonnull )actionSheetControllerWithTitleAttributedString:(nullable NSAttributedString *)title messageAttributedString:(nullable NSAttributedString *)message {
    LYAlertTitle_MessageView *titleOrMessageView = [LYAlertTitle_MessageView titleAttributedString:title messageAttributedString:message];
    return [[self alloc] initViewTitleOrMessageView:titleOrMessageView];
}

- (void)addAction:(LYAlertAction *_Nonnull)action {
    LYAlertActionView *actionView = nil;
    if (action.customView) {
        actionView = [LYAlertActionView alertActionCustomView:action];
    } else {
        actionView = [LYAlertActionView alertActionView:action];
    }
    
    __weak typeof(self) _self = self;
    actionView.dismissBlock = ^{
        __strong typeof(_self) self = _self;
        if (self) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    };
    
    self.totalHeight += 0.5;//lineView的height
    if (action.style == LYAlertActionStyleCancel) {//放在最下面，只能一个
        NSAssert(!self.cancelActionView, @"只能有一个LYAlertActionStyleCancel类型的Action");
        [actionView roundingCorners:UIRectCornerAllCorners cornerRadius:cornerRadius];
        self.cancelActionView = actionView;
        self.cancelAction = action;
    }
    [self.alertActionViews addObject:actionView];
    [self.alertActions addObject:action];
    self.totalHeight += actionView.frame.size.height;
}

- (NSArray<LYAlertAction *> *)actions {
    return self.alertActions.copy;
}

#pragma mark - initialize

- (instancetype)initViewTitleOrMessageView:(LYAlertTitle_MessageView *)view {
    self = [super init];
    if (self) {
        if (view) {
            CGSize size = view.frame.size;
            self.totalHeight = size.height;
            self.totalHeight += viewSpacing;//title_msgView 和 cancelActionView／底部 的间隔
            self.title_msgView = view;
            [self.title_msgView roundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadius:cornerRadius];
        }
        
        self.alertActions = [NSMutableArray array];
        self.alertActionViews = [NSMutableArray array];
        /** 不写就会变成黑色背景 */
        self.modalPresentationStyle = UIModalPresentationCustom;    // 自定义转场模式
        self.transitioningDelegate = (id)self;
        
        /** 在此处使用 self.view 会立即调用viewDidLoad */
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutSubviews];
}

- (void)dealloc {
    NSLog(@"____%s_____",__func__);
}

- (void)layoutSubviews {
    NSInteger actionCount = self.actions.count;
    if (self.cancelActionView) {
        self.totalHeight += viewSpacing;//cancelActionView 和 底部 的间隔
    }
    
    self.view.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.backgroundView addSubview:self.containerView];
    CGFloat offset = SCREEN_SIZE.height - self.totalHeight;
    self.containerView.frame = CGRectMake(leftOrRightSpacing, offset, contentMaxWidth, self.totalHeight);
    
    if (actionCount == 0 || (actionCount == 1 && [self.alertActionViews containsObject:self.cancelActionView])) {//没有action或者只有cacelAction
        [self.title_msgView roundingCorners:UIRectCornerAllCorners cornerRadius:cornerRadius];
    }
    CGSize size = self.title_msgView.frame.size;
    [self.containerView addSubview:self.title_msgView];
    [self.title_msgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
        make.centerX.equalTo(self.containerView);
        if (actionCount == 0) {
            make.bottom.mas_equalTo(self.containerView).mas_offset(-viewSpacing);
        } else {
            make.top.mas_equalTo(self.containerView);
        }
    }];
    
    UIView *bottomView = self.title_msgView;
    for (NSInteger index = 0 ; index < self.alertActionViews.count; index++ ) {//cancelActionView 最后布局
        LYAlertActionView *actionView = self.alertActionViews[index];
        if (![actionView isEqual:self.cancelActionView]) {
            if (index == actionCount - 1) {//最下面的ActionView
                [actionView roundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadius:cornerRadius];
            }
            
            if (bottomView) {//有title_msgView ADD LINE
                UIView *lineView = [[UIView alloc] init];
                lineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
                [self.containerView addSubview:lineView];
                [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(contentMaxWidth, 0.5));
                    make.centerX.mas_equalTo(self.containerView);
                    make.top.mas_equalTo(bottomView.mas_bottom);
                }];
                bottomView = lineView;
            } else {//没有title_msgView
                [actionView roundingCorners:UIRectCornerTopLeft | UIRectCornerTopLeft cornerRadius:cornerRadius];
            }
            [self.containerView addSubview:actionView];
            CGSize size = actionView.frame.size;
            [actionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(size);
                if (bottomView) {
//                    make.top.mas_equalTo(bottomView.mas_bottom).mas_offset(0.3);//不需要lineView
                    make.top.mas_equalTo(bottomView.mas_bottom);//需要lineView
                } else {
                    make.top.mas_equalTo(self.containerView);
                }
                make.centerX.mas_equalTo(self.containerView);
            }];
            bottomView = actionView;
        }
    }
    
    [self.containerView addSubview:self.cancelActionView];
    CGSize cancelSize = self.cancelActionView.frame.size;
    [self.cancelActionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(cancelSize);
        if (bottomView) {
            make.top.mas_equalTo(bottomView.mas_bottom).offset(viewSpacing);
        } else {
            make.top.mas_equalTo(self.containerView);
        }
        make.centerX.mas_equalTo(self.containerView);
    }];
}

#pragma mark - lazy loading

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
        _backgroundView.userInteractionEnabled = YES;
    }
    return _backgroundView;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor clearColor];
        _containerView.userInteractionEnabled = YES;
    }
    return _containerView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    !self.cancelAction.alertActionHandler?:self.cancelAction.alertActionHandler(self.cancelAction);
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[LYActionSheetViewControllerPresentAnimation alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[LYActionSheetViewControllerDismissAnimation alloc] init];
}

@end


#pragma mark - --------  Animation @implementation

@implementation LYActionSheetViewControllerPresentAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.35;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    LYActionSheetViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
    
    UIView *toVCContainerView = toVC.containerView;
    CGRect finalFrame = toVCContainerView.frame;
    
    toVCContainerView.frame = CGRectMake(finalFrame.origin.x, SCREEN_SIZE.height, finalFrame.size.width, finalFrame.size.height);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView addSubview:toVCContainerView];
    
    CGFloat animationDuration = [self transitionDuration:transitionContext] * (2/3.0f);
    [UIView animateWithDuration:animationDuration animations:^{
        toVC.backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
        toVCContainerView.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end

@implementation LYActionSheetViewControllerDismissAnimation
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.35;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    LYActionSheetViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *fromVCContainerView = fromVC.containerView;
    CGRect startFrame = fromVCContainerView.frame;
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:fromVCContainerView];
    
    CGFloat animationDuration = [self transitionDuration:transitionContext]/2.0f;
    [UIView animateWithDuration:animationDuration animations:^{
        fromVC.backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
        fromVCContainerView.frame = CGRectMake(startFrame.origin.x, SCREEN_SIZE.height, startFrame.size.width, startFrame.size.height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}
@end
