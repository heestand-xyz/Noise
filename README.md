# Noise

Generate random smooth cloudy noise.

## Swift Package

```swift
.package(url: "https://github.com/heestand-xyz/Noise", from: "2.0.0")
```

## Examples

```swift
import SwiftUI
import Noise
```

<img src="https://github.com/heestand-xyz/Noise/blob/main/Assets/noise.png?raw=true" width="256"/>

```swift
struct ContentView: View {
    var body: some View {
        Noise(style: .noisy)
            .monochrome()
    }
}
```

<img src="https://github.com/heestand-xyz/Noise/blob/main/Assets/noise-smooth.png?raw=true" width="256"/>

```swift
struct ContentView: View {
    var body: some View {
        Noise(style: .smooth)
            .monochrome()
            .brightness(1.5)
    }
}
```

<img src="https://github.com/heestand-xyz/Noise/blob/main/Assets/noise-random.png?raw=true" width="256"/>

```swift
struct ContentView: View {
    var body: some View {
        Noise(style: .random)
            .monochrome()
    }
}
```

<img src="https://github.com/heestand-xyz/Noise/blob/main/Assets/noise-colors.png?raw=true" width="256"/>

```swift
struct ContentView: View {
    var body: some View {
        Noise(style: .custom(octaves: 4))
            .brightness(1.5)
    }
}
```

<img src="https://github.com/heestand-xyz/Noise/blob/main/Assets/noise-color-layers.png?raw=true" width="256"/>

```swift
struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black
            Noise(style: .custom(octaves: 5))
                .monochrome()
                .tint(.red)
            Noise(style: .smooth)
                .monochrome()
                .tint(.yellow)
                .seed(2)
                .blendMode(.screen)
        }
    }
}
```

<img src="https://github.com/heestand-xyz/Noise/blob/main/Assets/noise-smooth.gif?raw=true" width="256"/>

```swift
struct ContentView: View {
    var body: some View {
        Noise(style: .smooth, speed: 1.0)
            .monochrome()
    }
}
```

Graphics Powered by SwiftUI Metal Shaders

Original Noise by [Eliot Eshelman](https://github.com/eshelman)
