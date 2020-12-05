//
//  RenderingEngine.h
//  MetalCube iOS
//
//  Created by Sid on 27/01/2019.
//  Copyright © 2019 whackylabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MetalKit/MetalKit.h>
#include <functional>

struct RenderingEngineDelegate {
    virtual id<MTLDrawable> getDrawable() const = 0;
    virtual MTLRenderPassDescriptor * getRenderPassDescriptor() const = 0;
};

class RenderingEngine
{
public:
    RenderingEngine(id device, MTLPixelFormat pixelFormat, const float width, const float height);
    void setDelegate(RenderingEngineDelegate *delegate);
    void reshape(const float width, const float height);
    void render();
    void update(const int dt);

private:
    void setUp();
    void loadData();
    
    id<MTLDevice> device_;
    MTLPixelFormat pixelFormat_;
    id<MTLBuffer> buffer_;
    id<MTLRenderPipelineState> renderPipeline_;
    id<MTLCommandQueue> commandQueue_;
    dispatch_semaphore_t drawSema_;
    RenderingEngineDelegate *delegate_;
    simd::float2 size_;
};

inline void RenderingEngine::setDelegate(RenderingEngineDelegate *delegate)
{
    delegate_ = delegate;
}

inline void RenderingEngine::reshape(const float width, const float height)
{
    size_ = simd::make_float2(width, height);
}

