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

```swift
struct ContentView: View {
    var body: some View {
        Noise()
    }
}
```

```swift
struct ContentView: View {
    var body: some View {
        Noise(smoothness: 1.0)
    }
}
```

```swift
struct ContentView: View {
    var body: some View {
        Noise(smoothness: nil)
    }
}
```

```swift
struct ContentView: View {
    var body: some View {
        Noise(smoothness: 1.0, speed: 1.0)
    }
}
```

```swift
struct ContentView: View {
    var body: some View {
        Noise(smoothness: nil, speed: 1.0)
    }
}
```

```swift
struct ContentView: View {
    var body: some View {
        Noise(smoothness: 0.75)
            .foregroundColors()
    }
}
```

```swift
```

```swift
```

```swift
```

```swift
```

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
