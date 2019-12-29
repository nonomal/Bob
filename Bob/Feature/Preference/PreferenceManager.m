//
//  PreferenceManager.m
//  Bob
//
//  Created by chen on 2019/12/28.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "PreferenceManager.h"

@implementation PreferenceManager

singleton_m(PreferenceManager)

+ (instancetype)manager {
    return [self shared];
}

- (instancetype)init {
    if (self = [super init]) {
        [self bindPreference];
    }
    return self;
}

- (void)bindPreference {
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(self.class, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *proString = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [[RACKVOChannel alloc] initWithTarget:self keyPath:proString nilValue:@1][@"followingTerminal"] = [[RACKVOChannel alloc] initWithTarget:[NSUserDefaults standardUserDefaults] keyPath:[NSString stringWithFormat:@"Preference_%@", proString] nilValue:nil][@"followingTerminal"];
    }
}

@end
