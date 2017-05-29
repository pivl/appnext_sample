//
//  BPAdNativeViews.h
//  BuyMeAPie
//
//  Created by Pavel Stasyuk on 08/08/16.
//  Copyright © 2016 BuyMeAPie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BPAdNativeView;
@class AppodealNativeAd;

@interface BPAdNativeViews : NSObject

- (BPAdNativeView *)viewForSize:(CGSize)size;

@end
