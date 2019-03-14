//
//  RenderingEngine.m
//  MetalCube iOS
//
//  Created by Sid on 27/01/2019.
//  Copyright © 2019 whackylabs. All rights reserved.
//

#import "RenderingEngine.h"
#include "ShaderTypes.h"

RenderingEngine::RenderingEngine(id device, MTLPixelFormat pixelFormat,  const float width, const float height)
:
device_(device),
pixelFormat_(pixelFormat),
size_(simd::make_float2(width, height)),
drawSema_(dispatch_semaphore_create(1))
{
    setUp();
}

void RenderingEngine::setUp()
{
    // vertex data
    loadData();
    
    // render pipeline
    id<MTLLibrary> shaderLibrary = [device_ newDefaultLibrary];
    MTLRenderPipelineDescriptor *pipelineDesc = [[MTLRenderPipelineDescriptor alloc] init];
    pipelineDesc.vertexFunction = [shaderLibrary newFunctionWithName:@"vsh"];
    pipelineDesc.fragmentFunction = [shaderLibrary newFunctionWithName:@"fsh"];
    pipelineDesc.colorAttachments[0].pixelFormat = pixelFormat_;
    renderPipeline_ = [device_ newRenderPipelineStateWithDescriptor:pipelineDesc error:nil];
    
    // command queue
    commandQueue_ = [device_ newCommandQueue];
}

void RenderingEngine::loadData()
{
    Vertex data[] = {
        // front
        {.position = {-1.0f, 1.0f, 0.0f, 1.0f}, .color = {0.3f, 0.0f, 0.0f, 1.0f}},
        {.position = {-1.0f, -1.0f, 0.0f, 1.0f}, .color = {0.7f, 0.0f, 0.0f, 1.0f}},
        {.position = {1.0f, 1.0f, 0.0f, 1.0f}, .color = {0.6f, 0.0f, 0.0f, 1.0f}},
        {.position = {1.0f, -1.0f, 0.0f, 1.0f}, .color = {0.9f, 0.0f, 0.0f, 1.0f}}
    };

    buffer_ = [device_ newBufferWithBytes:data length:sizeof(data) options:MTLResourceOptionCPUCacheModeDefault];
}

void RenderingEngine::render()
{
    dispatch_semaphore_wait(drawSema_, DISPATCH_TIME_FOREVER);
    id<MTLCommandBuffer> commandBuffer = [commandQueue_ commandBuffer];
    
    __block dispatch_semaphore_t sema = drawSema_;
    [commandBuffer addCompletedHandler:^(id<MTLCommandBuffer> buffer) {
        dispatch_semaphore_signal(sema);
    }];
    
    
    id<MTLRenderCommandEncoder> commandEnc = [commandBuffer renderCommandEncoderWithDescriptor:delegate_->getRenderPassDescriptor()];
    [commandEnc setRenderPipelineState:renderPipeline_];
    [commandEnc setVertexBuffer:buffer_ offset:0 atIndex:0];
    [commandEnc drawPrimitives:MTLPrimitiveTypeTriangleStrip vertexStart:0 vertexCount:4];
    [commandEnc endEncoding];
    
    [commandBuffer presentDrawable: delegate_->getDrawable()];
    [commandBuffer commit];
    
    [commandBuffer waitUntilCompleted];
}
