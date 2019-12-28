//
//  PreferenceManager.h
//  Bob
//
//  Created by chen on 2019/12/28.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 偏好设置与 userdefault 建立绑定关系
@interface PreferenceManager : NSObject

/// 字号
@property (nonatomic, assign) NSInteger font;

+ (instancetype)manager;

@end

NS_ASSUME_NONNULL_END
