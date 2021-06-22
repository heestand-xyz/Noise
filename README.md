# Noise

Generate random smooth cloudy noise.

## Install

### Swift Package

```swift
.package(url: "https://github.com/heestand-xyz/Noise", from: "1.0.0")
```

### Import Package

```swift
import SwiftUI
import Noise
```

<img src="https://github.com/heestand-xyz/Noise/blob/main/Assets/noise.png?raw=true" width="256"/>

```swift
struct ContentView: View {
    var body: some View {
        Noise()
    }
}
```

<img src="https://github.com/heestand-xyz/Noise/blob/main/Assets/noise-smooth.png?raw=true" width="256"/>

```swift
struct ContentView: View {
    var body: some View {
        Noise(smoothness: 1.0)
    }
}
```

<img src="https://github.com/heestand-xyz/Noise/blob/main/Assets/noise-random.png?raw=true" width="256"/>

```swift
struct ContentView: View {
    var body: some View {
        Noise(smoothness: nil)
    }
}
```

<img src="https://github.com/heestand-xyz/Noise/blob/main/Assets/noise-colors.png?raw=true" width="256"/>

```swift
struct ContentView: View {
    var body: some View {
        Noise(smoothness: 0.75)
            .foregroundColors()
    }
}
```

<img src="https://github.com/heestand-xyz/Noise/blob/main/Assets/noise-color-layers.png?raw=true" width="256"/>

```swift
struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black
            Noise(smoothness: 0.5)
                .foregroundColor(.red)
            Noise(smoothness: 1.0)
                .foregroundColor(.yellow)
                .seed(2)
        }
    }
}
```

<img src="https://github.com/heestand-xyz/Noise/blob/main/Assets/noise-smooth.gif?raw=true" width="256"/>

```swift
struct ContentView: View {
    var body: some View {
        Noise(smoothness: 1.0, speed: 1.0)
    }
}
```

Graphics Powered by [PixelKit](https://github.com/heestand-xyz/PixelKit)

Original Noise by [Eliot Eshelman](https://github.com/eshelman)
