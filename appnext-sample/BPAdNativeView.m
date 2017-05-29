//
//  BPAdNativeView.m
//  BuyMeAPie
//
//  Created by Pavel Stasyuk on 08/08/16.
//  Copyright © 2016 BuyMeAPie. All rights reserved.
//

#import "BPAdNativeView.h"

#import <Masonry/Masonry.h>


@implementation BPAdNativeView {
    CAGradientLayer *gradient;
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    UIImage *imagePapercut = [UIImage imageNamed:@"shopping_list_bottom_edge"];
    UIImage *tiledImage = [imagePapercut resizableImageWithCapInsets:UIEdgeInsetsZero
                                                        resizingMode:UIImageResizingModeTile];
    self.listEdgeImageView.image = tiledImage;

    self.callToActionButton.titleLabel.adjustsFontSizeToFitWidth = YES;

    gradient = [CAGradientLayer layer];
    gradient.colors = @[ (id)[[UIColor colorWithWhite:1.0 alpha:0.8] CGColor],
                         (id)[[UIColor colorWithWhite:1.0 alpha:1.0] CGColor] ];
    [self.gradientView.layer insertSublayer:gradient atIndex:0];
       
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    gradient.frame = self.gradientView.bounds;
}

- (void)updateConstraints
{
    if (self.adChoicesContainer) {
        [self.adChoicesView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@64);
            make.height.equalTo(@16);
            make.edges.equalTo(self.adChoicesContainer);
        }];
    }

    [super updateConstraints];
}

- (void)setAdChoicesView:(UIView *)adChoicesView
{
    [_adChoicesView removeFromSuperview];
    _adChoicesView = adChoicesView;
    
    if (_adChoicesView) {
        [self.adChoicesContainer addSubview:_adChoicesView];
    }
    
    [self setNeedsUpdateConstraints];
}

- (IBAction)handleTouchUpInsideCloseButton:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(adNativeViewCloseButtonTouched:)]) {
        [self.delegate adNativeViewCloseButtonTouched:self];
    }
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture
{
    if ([self.delegate respondsToSelector:@selector(adClicked:)]) {
        [self.delegate adClicked:self];
    }
}

@end
