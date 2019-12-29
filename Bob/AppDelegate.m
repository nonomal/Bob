//
//  AppDelegate.m
//  Bob
//
//  Created by ripper on 2019/11/20.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "AppDelegate.h"
#import "StatusItem.h"
#import "Shortcut.h"
#import "MMCrash.h"
#import "PreferenceManager.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    MMLogInfo(@"程序启动");
    [MMCrash registerHandler];
    [StatusItem.shared setup];
    [PreferenceManager.manager install];
    [Shortcut setup];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    [StatusItem.shared remove];
}

@end
