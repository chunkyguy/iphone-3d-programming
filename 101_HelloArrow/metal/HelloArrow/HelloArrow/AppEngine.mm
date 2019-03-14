//
//  AppEngine.m
//  MetalCube iOS
//
//  Created by Sid on 27/01/2019.
//  Copyright © 2019 whackylabs. All rights reserved.
//

#import "AppEngine.h"
#include <memory>
#import <simd/simd.h>
#import "RenderingEngine.h"

class RenderingEngineDelegateImpl : public RenderingEngineDelegate {
public:
    RenderingEngineDelegateImpl(MTKView *view): view_(view) {};
    
    virtual ~RenderingEngineDelegateImpl() {
        view_ = nil;
    }
    
    virtual id<MTLDrawable> getDrawable() const {
        return [view_ currentDrawable];
    }
    
    virtual MTLRenderPassDescriptor * getRenderPassDescriptor() const {
        return [view_ currentRenderPassDescriptor];
    }
    
private:
    MTKView *view_;
};

@interface AppEngine() <MTKViewDelegate>
@end

@implementation AppEngine
{
    MTKView *_view;
    RenderingEngineDelegateImpl *_rendererDelegate;
    std::unique_ptr<RenderingEngine> _renderer;
}

+ (instancetype)engineWithView:(MTKView *)view
{
    return [[[self class] alloc] initWithView:view];
}

- (instancetype)initWithView:(MTKView *)view
{
    self = [super init];
    if (self) {
        _rendererDelegate = new RenderingEngineDelegateImpl(view);
        _view = view;
        [self setUp];
    }
    return self;
}

- (void)dealloc
{
    delete _rendererDelegate;
}

#pragma mark - Private -
- (void)setUp
{
    id<MTLDevice> device = MTLCreateSystemDefaultDevice();
    
    // configure view
    _view.device = device;
    [_view setClearColor:MTLClearColorMake(0.5, 0.5, 0.5, 1)];
    
    // configure engine
    _renderer = std::make_unique<RenderingEngine>
    (
     device,
     _view.colorPixelFormat,
     _view.bounds.size.width,
     _view.bounds.size.height
     );
    
    
    _renderer->setDelegate(_rendererDelegate);
    _view.delegate = self;
}

#pragma mark - MTKViewDelegate -
- (void)mtkView:(nonnull MTKView *)view drawableSizeWillChange:(CGSize)size
{
    _renderer->reshape(size.width, size.height);
}

- (void)drawInMTKView:(nonnull MTKView *)view
{
    _renderer->render();
}

@end

