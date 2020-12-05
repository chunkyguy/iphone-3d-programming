//
//  Shader.metal
//  HelloArrow
//
//  Created by Sid on 14/03/2019.
//  Copyright © 2019 whackylabs. All rights reserved.
//

#include <metal_stdlib>
#include "ShaderTypes.h"

using namespace metal;

vertex Vertex vsh(device Vertex *data [[buffer(0)]], uint vid [[vertex_id]])
{
    return data[vid];
}


fragment float4 fsh(Vertex in [[stage_in]])
{
    return in.color;
}
