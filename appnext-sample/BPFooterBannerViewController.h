//
//  BPFooterBannerViewController.h
//  BuyMeAPie
//
//  Created by Anton Rusanov on 26.12.13.
//  Copyright (c) 2013 BuyMeAPie. All rights reserved.
//

@import UIKit;
@protocol BPAdContentProvider;

@interface BPFooterBannerViewController : UIViewController

@property (nonatomic, strong) id<BPAdContentProvider> adContentProvider;

- (void)initializeBanner;

@end
