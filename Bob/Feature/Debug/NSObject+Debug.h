//
//  NSObject+Log.h
//  Bob
//
//  Created by chen on 2019/12/28.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import <AppKit/AppKit.h>


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (DebugHook)

- (void)debug_hookAllMehtods;

@end

NS_ASSUME_NONNULL_END
