//
//  ShaderTypes.h
//  MetalCube Shared
//
//  Created by Sid on 27/01/2019.
//  Copyright © 2019 whackylabs. All rights reserved.
//

//
//  Header containing types and enum constants shared between Metal shaders and Swift/ObjC source
//
#ifndef ShaderTypes_h
#define ShaderTypes_h

#ifdef __METAL_VERSION__
#define ATTRIB_POSITION [[position]]
#else
#include <simd/simd.h>
#define ATTRIB_POSITION
using namespace simd;
#endif

typedef struct
{
    float4 position ATTRIB_POSITION;
    float4 color;
} Vertex;

#endif /* ShaderTypes_h */

