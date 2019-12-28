//
//  BobMacro.h
//  Bob
//
//  Created by ripper on 2019/12/28.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import <ReactiveObjC/ReactiveObjC.h>

#define NSLog(frmt, ...) MMLogVerbose(frmt, ##__VA_ARGS__)

#if __clang__ && (__clang_major__ >= 8)
#define MMObserve(OBSERVER ,TARGET, KEYPATH) _MMObserve(OBSERVER ,TARGET, KEYPATH)
#else
#define MMObserve(OBSERVER, TARGET, KEYPATH) \
({ \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Wreceiver-is-weak\"") \
    _MMObserve(OBSERVER ,TARGET, KEYPATH) \
    _Pragma("clang diagnostic pop") \
})
#endif

#define _MMObserve(OBSERVER, TARGET, KEYPATH) \
({ \
    __weak id target_ = (TARGET); \
    [target_ rac_valuesForKeyPath:@keypath(TARGET, KEYPATH) observer:OBSERVER]; \
})

#define DeepDarkColor [NSColor mm_colorWithHexString:@"#26292C"]
#define DarkGrayColor [NSColor mm_colorWithHexString:@"#333435"]
#define DarkBorderColor [NSColor mm_colorWithHexString:@"#464748"]
