//
//  UIShadowRoundedImageView.m
//  BuyMeAPie
//
//  Created by Pavel Stasyuk on 11/08/2016.
//  Copyright © 2016 BuyMeAPie. All rights reserved.
//

#import "UIShadowRoundedImageView.h"

#import <Masonry/Masonry.h>

@implementation UIShadowRoundedImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:self.imageView];
}

- (void)updateConstraints
{
    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:_cornerRadius].CGPath;
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    self.imageView.image = [UIImage imageNamed:imageName];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.imageView.layer.cornerRadius = cornerRadius;
    self.imageView.layer.masksToBounds = cornerRadius > 0;
    
    [self setNeedsUpdateConstraints];
    [self setNeedsLayout];
}

- (void)setShadowColor:(UIColor *)shadowColor
{
    _shadowColor = shadowColor;
    self.layer.shadowColor = shadowColor.CGColor;
}

- (void)setShadowOffset:(CGSize)shadowOffset
{
    _shadowOffset = shadowOffset;
    self.layer.shadowOffset = shadowOffset;
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity
{
    _shadowOpacity = shadowOpacity;
    self.layer.shadowOpacity = shadowOpacity;
}

- (void)setShadowRadius:(CGFloat)shadowRadius
{
    _shadowRadius = shadowRadius;
    self.layer.shadowRadius = shadowRadius;
}

@end
