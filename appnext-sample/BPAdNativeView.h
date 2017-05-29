//
//  BPAdNativeView.h
//  BuyMeAPie
//
//  Created by Pavel Stasyuk on 08/08/16.
//  Copyright © 2016 BuyMeAPie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UIShadowRoundedImageView;
@class BPAdNativeView;

@protocol BPAdNativeViewDelegate<NSObject>
- (void)adNativeViewCloseButtonTouched:(BPAdNativeView *)adNativeView;
@optional
- (void)adClicked:(BPAdNativeView *)adNativeView;
@end

@interface BPAdNativeView : UIView

@property (weak, nonatomic) IBOutlet UIView *gradientView;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIShadowRoundedImageView *iconImageContainer;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *callToActionButton;
@property (weak, nonatomic) IBOutlet UIImageView *listEdgeImageView;
@property (weak, nonatomic) IBOutlet UIView *adChoicesContainer;
@property (weak, nonatomic) IBOutlet UIView *sponsosedView;
@property (weak, nonatomic) IBOutlet UIButton *closeAdButton;

@property (nonatomic, strong) UIView *adChoicesView;

@property (nonatomic, weak) id<BPAdNativeViewDelegate> delegate;

@end
