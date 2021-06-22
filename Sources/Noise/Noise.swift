import SwiftUI
import PixelKit
import Resolution
import PixelColor
import Combine

/// Noise
///
/// - Parameters:
///     - smoothness: A low value is a more random noise, a high value is smooth and a nil value is random.
///     - speed: Animation of the noise, a value of 1.0 is a good speed.
public struct Noise: View {
    
    @State private var id: UUID = UUID()
    
    @Environment(\.colorScheme) var colorScheme
    
    private let color: PixelColor?
    private let brightness: Double?
    private let allColors: Bool
    private let seed: Int

    private let smoothness: Double?
    private let speed: Double

    @StateObject private var colorPix = ColorPIX()
    @StateObject private var noisePix = NoisePIX()
    @StateObject private var levelsPix = LevelsPIX()
    @StateObject private var reorderPix = ReorderPIX()

    public init(smoothness: Double? = 0.0,
                speed: Double = 0.0) {
        color = nil
        brightness = nil
        allColors = false
        seed = 1
        self.smoothness = smoothness
        self.speed = speed
    }
    
    private init(color: PixelColor?,
                 brightness: Double?,
                 allColors: Bool,
                 seed: Int,
                 smoothness: Double?,
                 speed: Double) {
        self.color = color
        self.brightness = brightness
        self.allColors = allColors
        self.seed = seed
        self.smoothness = smoothness
        self.speed = speed
    }
    
    public var body: some View {
        GeometryReader { geometry in
            PixelView(pix: reorderPix)
                .onAppear {
                    
                    updateResolution(size: geometry.size)
                    
                    updateColor(colorScheme)
                    
                    if let smoothness = smoothness {
                        noisePix.octaves = 1 + Int((1.0 - smoothness) * 9)
                    } else {
                        noisePix.random = true
                    }
                    noisePix.seed = seed
                    noisePix.colored = allColors
                    
                    levelsPix.input = noisePix
                    levelsPix.brightness = 1.0 + (brightness ?? 0.0)
                    
                    reorderPix.inputA = levelsPix
                    reorderPix.inputB = colorPix
                    reorderPix.redInput = allColors ? .first : .second
                    reorderPix.greenInput = allColors ? .first : .second
                    reorderPix.blueInput = allColors ? .first : .second
                    reorderPix.alphaChannel = allColors ? .alpha : .red

                    reorderPix.view.checker = false
                    
                    PixelKit.main.render.listenToFrames(id: id) {
                        guard speed != 0.0 else { return }
                        if smoothness != nil {
                            noisePix.zPosition += speed * 0.01
                        } else {
                            noisePix.seed += 1
                        }
                    }
                }
                .onDisappear {
                    PixelKit.main.render.unlistenToFrames(for: id)
                }
                .onChange(of: colorScheme, perform: { colorScheme in
                    updateColor(colorScheme)
                })
                .onChange(of: geometry.size) { size in
                    updateResolution(size: size)
                }
        }
    }
    
    func updateResolution(size: CGSize) {
        let resolution: Resolution = .size(size) * Resolution.scale
        noisePix.resolution = resolution
        colorPix.resolution = resolution
    }
    
    func updateColor(_ colorScheme: ColorScheme) {
        if let color = color {
            colorPix.color = color
        } else {
            colorPix.color = colorScheme == .dark ? .white : .black
        }
    }
}

extension Noise {
    
    public func seed(_ seed: Int) -> Noise {
        Noise(color: color, brightness: brightness, allColors: allColors, seed: seed, smoothness: smoothness, speed: speed)
    }

    public func foregroundColors() -> Noise {
        Noise(color: color, brightness: brightness, allColors: true, seed: seed, smoothness: smoothness, speed: speed)
    }
    
    public func foregroundColor(_ color: PixelColor) -> Noise {
        Noise(color: color, brightness: brightness, allColors: allColors, seed: seed, smoothness: smoothness, speed: speed)
    }
    
    public func brightness(_ amount: Double) -> Noise {
        Noise(color: color, brightness: amount, allColors: allColors, seed: seed, smoothness: smoothness, speed: speed)
    }
}

struct Noise_Previews: PreviewProvider {
    static var previews: some View {
        Noise()
    }
}
