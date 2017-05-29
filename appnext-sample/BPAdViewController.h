//
//  BPContentContainer.h
//  BuyMeAPie
//
//  Created by Anton Rusanov on 25.12.13.
//  Copyright (c) 2013 BuyMeAPie. All rights reserved.
//

#import "BPFooterBannerViewController.h"

@interface BPAdViewController : UIViewController

@property (nonatomic, assign) UIViewController *contentViewController;
@property (nonatomic, strong) BPFooterBannerViewController *footerBannerViewController;

@end
