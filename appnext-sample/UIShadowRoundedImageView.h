//
//  UIShadowRoundedImageView.h
//  BuyMeAPie
//
//  Created by Pavel Stasyuk on 11/08/2016.
//  Copyright © 2016 BuyMeAPie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIShadowRoundedImageView : UIView

@property (nonatomic, strong) IBInspectable NSString *imageName;
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

@property (nonatomic, strong) IBInspectable UIColor *shadowColor;
@property (nonatomic, assign) IBInspectable CGFloat shadowRadius;
@property (nonatomic, assign) IBInspectable CGFloat shadowOpacity;
@property (nonatomic, assign) IBInspectable CGSize shadowOffset;

@property (nonatomic, strong) UIImageView *imageView;

@end
