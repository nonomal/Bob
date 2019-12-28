//
//  NSObject+Log.m
//  Bob
//
//  Created by chen on 2019/12/28.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "NSObject+Debug.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <AppKit/AppKit.h>


@implementation NSObject (DebugHook)

- (void)debug_hookAllMehtods {
#if DEBUG
    uint count;
    Method *methods = class_copyMethodList(self.class, &count);
    for (int i = 0; i < count; i++) {
        SEL method_name = method_getName(*(methods + i));
        [[self rac_signalForSelector:method_name] subscribeNext:^(RACTuple * _Nullable x) {
            NSLog(@"%@ call: %@", self.class, NSStringFromSelector(method_name));
        }];
    }
#endif
}

@end
