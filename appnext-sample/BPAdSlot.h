//
//  BPAdView.h
//  BuyMeAPie
//
//  Created by Artem on 12.10.15.
//  Copyright © 2015 BuyMeAPie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BPAdSlot <NSObject>

- (void)wasHidden;
- (void)wasUnHidden;
- (void)advanceToNextAd;

@end
