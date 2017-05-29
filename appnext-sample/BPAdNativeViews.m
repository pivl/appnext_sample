//
//  BPAdNativeViews.m
//  BuyMeAPie
//
//  Created by Pavel Stasyuk on 08/08/16.
//  Copyright © 2016 BuyMeAPie. All rights reserved.
//

#import "BPAdNativeViews.h"

@interface BPAdNativeViews ()
@property (strong, nonatomic) IBOutlet BPAdNativeView *smallView;
@property (strong, nonatomic) IBOutlet BPAdNativeView *bigView;
@property (nonatomic, strong) AppodealNativeAd *nativeAd;
@end

@implementation BPAdNativeViews

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSBundle *currentBundle = [NSBundle bundleForClass:self.class];
        UINib *nib = [UINib nibWithNibName:NSStringFromClass(self.class) bundle:currentBundle];
        [nib instantiateWithOwner:self options:nil];
    }
    return self;
}

- (BPAdNativeView *)viewForSize:(CGSize)size
{
    BPAdNativeView *resultView = self.smallView;

    if (size.height >= 160) {
        resultView = self.bigView;
    }

    return resultView;
}

@end
