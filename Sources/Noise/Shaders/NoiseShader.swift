import SwiftUI

struct NoiseShader: View {
    
    let octaves: Int
    let offset: CGPoint
    let zOffset: CGFloat
    let scale: CGFloat
    let isColored: Bool
    let isRandom: Bool
    let tint: Color
    let brightness: CGFloat
    let seed: Int
    
    private var shaderFunction: ShaderFunction {
        ShaderFunction(library: .bundle(.module),
                       name: "noise")
    }
    
    private func shader(size: CGSize) -> Shader {
        Shader(function: shaderFunction, arguments: [
            .float2(size),
            .float(CGFloat(octaves)),
            .float2(offset),
            .float(zOffset),
            .float(scale),
            .float(isColored ? 1.0 : 0.0),
            .float(isRandom ? 1.0 : 0.0),
            .color(tint),
            .float(brightness),
            .float(CGFloat(seed)),
        ])
    }
    
    var body: some View {
        SizeReader { size in
            Rectangle()
                .colorEffect(shader(size: size))
        }
    }
}
