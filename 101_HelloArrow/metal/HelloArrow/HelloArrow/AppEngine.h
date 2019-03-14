//
//  AppEngine.h
//  MetalCube iOS
//
//  Created by Sid on 27/01/2019.
//  Copyright © 2019 whackylabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MetalKit/MetalKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppEngine : NSObject

+ (instancetype)engineWithView:(MTKView *)view;

@end

NS_ASSUME_NONNULL_END
