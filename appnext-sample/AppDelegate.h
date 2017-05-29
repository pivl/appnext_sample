//
//  AppDelegate.h
//  adadapted-sample
//
//  Created by Pavel Stasyuk on 29/01/2017.
//  Copyright © 2017 Buy Me a Pie!. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BPAdContentProvider;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) id<BPAdContentProvider> contentProvider;

@end

