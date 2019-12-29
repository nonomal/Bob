//
//  PreferenceManager.m
//  Bob
//
//  Created by chen on 2019/12/28.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "PreferenceManager.h"
#import <ServiceManagement/ServiceManagement.h>
#import <Sparkle/Sparkle.h>

#define MMBindUserDefault(keyPath, defaultValue) \
{\
    NSString *_keyPath = @keypath(self, keyPath);\
    NSString *key = [NSString stringWithFormat:@"Preference_%@", _keyPath];\
    if (![[NSUserDefaults standardUserDefaults] objectForKey:key] && defaultValue != nil) {\
        [[NSUserDefaults standardUserDefaults] setObject:defaultValue forKey:key];\
        [[NSUserDefaults standardUserDefaults] synchronize];\
    }\
    RACChannelTo(self, keyPath) = [[NSUserDefaults standardUserDefaults] rac_channelTerminalForKey:key];\
}

@implementation PreferenceManager

singleton_m(PreferenceManager)

+ (instancetype)manager {
    return [self shared];
}

- (void)install {
    [self refreshUserDefault];
    [self bindPreference];
}

/// v 0.2.0 之前的自定义 key refresh 为新 key
- (void)refreshUserDefault {
#define kAutoCopyTranslateResultKey @"configuration_auto_copy_translate_result"
#define kLaunchAtStartupKey @"configuration_launch_at_startup"

#define kTranslateIdentifierKey @"configuration_translate_identifier"
#define kFromKey @"configuration_from"
#define kToKey @"configuration_to"
#define kPinKey @"configuration_pin"
#define kFoldKey @"configuration_fold"
    [self refreshOldkey:kAutoCopyTranslateResultKey newKey:@keypath(self, autoCopyTranslateResult)];
    [self refreshOldkey:kLaunchAtStartupKey newKey:@keypath(self, launchAtStartup)];
    [self refreshOldkey:kTranslateIdentifierKey newKey:@keypath(self, translateIdentifier)];
    [self refreshOldkey:kFromKey newKey:@keypath(self, from)];
    [self refreshOldkey:kToKey newKey:@keypath(self, to)];
    [self refreshOldkey:kPinKey newKey:@keypath(self, isPin)];
    [self refreshOldkey:kFoldKey newKey:@keypath(self, isFold)];
}

- (void)refreshOldkey:(NSString *)oldKey newKey:(NSString *)newKey {
    NSString *saveKey = [NSString stringWithFormat:@"Preference__%@", newKey];
    NSObject *value = [[NSUserDefaults standardUserDefaults] objectForKey:oldKey];
    if (value) {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:saveKey];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:oldKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)bindPreference {
    MMBindUserDefault(font, @(3));
    MMBindUserDefault(autoCopyTranslateResult, @NO);
    MMBindUserDefault(translateIdentifier, nil);
    MMBindUserDefault(from, @(Language_auto));
    MMBindUserDefault(to, @(Language_auto));
    MMBindUserDefault(isPin, @NO);
    MMBindUserDefault(isFold, @NO);
    MMBindUserDefault(launchAtStartup, @NO);
    RACChannelTo(self, automaticallyChecksForUpdates) = RACChannelTo([SUUpdater sharedUpdater], automaticallyChecksForUpdates);
    @weakify(self);
    
    [[RACObserve(self, launchAtStartup) distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self updateLoginItemWithLaunchAtStartup:[x boolValue]];
    }];
    NSLog(@"%@", self.mj_keyValues);
}

#pragma mark -

- (void)updateLoginItemWithLaunchAtStartup:(BOOL)launchAtStartup {
    // 注册启动项
    // https://nyrra33.com/2019/09/03/cocoa-launch-at-startup-best-practice/
#if DEBUG
    NSString *helper = [NSString stringWithFormat:@"com.ripperhe.BobHelper-debug"];
#else
    NSString *helper = [NSString stringWithFormat:@"com.ripperhe.BobHelper"];
#endif
    SMLoginItemSetEnabled((__bridge CFStringRef)helper, launchAtStartup);
}

@end
