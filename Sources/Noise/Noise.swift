import SwiftUI
import Combine

public struct Noise: View {
    
    @State private var id: UUID = UUID()
    
    @Environment(\.colorScheme) var colorScheme
    
    private let color: Color?
    private let brightness: Double?
    private let colored: Bool
    private let seed: Int
    private let speed: Double
    
    public enum Style: Equatable {
        case noisy
        case smooth
        case random
        /// Octaves between 1 and 10. The higher number the more noise.
        case custom(octaves: Int)
        var octaves: Int {
            switch self {
            case .noisy:
                10
            case .smooth:
                1
            case .random:
                1
            case .custom(let octaves):
                min(10, max(1, octaves))
            }
        }
    }
    let style: Style

    @available(*, deprecated, renamed: "init(style:speed:)")
    public init(smoothness: Double? = 0.0,
                speed: Double = 0.0) {
        color = nil
        brightness = nil
        colored = false
        seed = 0
        style = if let smoothness {
            .custom(octaves: 1 + Int((1.0 - min(1.0, max(0.0, smoothness))) * 9))
        } else {
            .random
        }
        self.speed = speed
    }
    
    public init(style: Style,
                speed: Double = 0.0) {
        color = nil
        brightness = nil
        colored = true
        seed = 0
        self.style = style
        self.speed = speed
    }
    
    private init(color: Color?,
                 brightness: Double?,
                 colored: Bool,
                 seed: Int,
                 style: Style,
                 speed: Double) {
        self.color = color
        self.brightness = brightness
        self.colored = colored
        self.seed = seed
        self.style = style
        self.speed = speed
    }
    
    @State private var startTime: Date = .now
    
    public var body: some View {
        if speed > 0.0 {
            SizeReader { size in
                TimelineView(.animation) { context in
                    let seconds: TimeInterval = startTime.distance(to: context.date)
                    let zOffset: CGFloat = seconds * speed * size.height
                    let randomSeed = Int(seconds * speed)
                    NoiseShader(
                        octaves: style.octaves,
                        offset: .zero,
                        zOffset: zOffset,
                        scale: 1.0,
                        isColored: colored,
                        isRandom: style == .random,
                        tint: color ?? .white,
                        brightness: brightness ?? 1.0,
                        seed: style == .random ? randomSeed : seed
                    )
                }
            }
        } else {
            NoiseShader(
                octaves: style.octaves,
                offset: .zero,
                zOffset: 0.0,
                scale: 1.0,
                isColored: colored,
                isRandom: style == .random,
                tint: color ?? .white,
                brightness: brightness ?? 1.0,
                seed: seed
            )
        }
    }
}

extension Noise {
    
    public func seed(_ seed: Int) -> Noise {
        Noise(color: color, brightness: brightness, colored: colored, seed: seed, style: style, speed: speed)
    }

    @available(*, deprecated, message: "The noise is now colored by default.")
    public func foregroundColors() -> Noise {
        self
    }
    
    @available(*, deprecated, renamed: "tint(_:)")
    public func foregroundColor(_ color: Color) -> Noise {
        tint(color)
    }
    
    public func monochrome() -> Noise {
        Noise(color: color, brightness: brightness, colored: false, seed: seed, style: style, speed: speed)
    }

    public func monochrome(on colored: Bool) -> Noise {
        Noise(color: color, brightness: brightness, colored: colored, seed: seed, style: style, speed: speed)
    }
    
    public func tint(_ color: Color) -> Noise {
        Noise(color: color, brightness: brightness, colored: colored, seed: seed, style: style, speed: speed)
    }
    
    public func brightness(_ amount: Double) -> Noise {
        Noise(color: color, brightness: amount, colored: colored, seed: seed, style: style, speed: speed)
    }
}

#Preview {
    Noise(style: .smooth)
}
