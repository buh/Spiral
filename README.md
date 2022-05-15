<p align="center">
  <img width="640" alt="cover3" src="https://user-images.githubusercontent.com/284922/168449775-50b28f1c-d303-478c-b741-89805f88b67b.png">
</p>

<p align="center">
  <img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbuh%2FCompactSlider%2Fbadge%3Ftype%3Dswift-versions" />
  <img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbuh%2FCompactSlider%2Fbadge%3Ftype%3Dplatforms" />
  <img src="https://img.shields.io/badge/SwiftUI-2-blue" />
  <a href="https://github.com/buh/Spiral/blob/main/LICENSE"><img src="https://img.shields.io/github/license/buh/Spiral" /></a>
</p>

`Spiral` is a SwiftUI shape for macOS, iOS and watchOS.

A spiral is a component that includes a point generator, `Shape` and `View` of the spiral. The point generator allows direct data to be used for particularly rare cases. The `Shape` and `View` of the spiral is designed for SwiftUI. The `Spiral` shape can be outlined or filled with the desired material. The `SpiralView' allows you to place arbitrary views at spiral points.

- [Requirements](#requirements)
- [Installation](#installation)
- [Preview](#preview)
- [Usage](#usage)
  - [Spiral Shape](#spiral-shape)
  - [Spiral View](#spiral-view)
- [Documentation](https://prowork.today/CompactSlider/documentation/compactslider)
- [License](#license)

# Requirements

- Swift 5.6
- Xcode 13
- SwiftUI 2
- macOS 11
- iOS 14
- watchOS 7

*Some of the requirements could be reduced if there is a demand for them.*

# Installation 

1. In Xcode go to `File` ⟩ `Add Packages...`
2. Search for the link below and click `Add Package`
```
https://github.com/buh/Spiral.git
```
3. Select to which target you want to add it and select `Add Package`

# Preview

https://user-images.githubusercontent.com/284922/168488964-d07c9434-6e3c-4738-8a5a-b34c2b6c0122.mov

https://user-images.githubusercontent.com/284922/168489048-ab6fd895-c26b-499e-aa3e-c6368e1e2fd2.mov

<img width="375" alt="circle" src="https://user-images.githubusercontent.com/284922/168489256-f7529316-46ab-455b-bd11-6870d90a93b7.jpeg">
<img width="375" alt="text" src="https://user-images.githubusercontent.com/284922/168489281-aaf9c62b-1347-4abd-9842-9e9a07a4fa7d.jpeg">
<img width="375" alt="chart1" src="https://user-images.githubusercontent.com/284922/168489302-7ae5cd1a-33a3-4396-a1b5-89eb626d41e8.jpeg">
<img width="375" alt="chart2" src="https://user-images.githubusercontent.com/284922/168489329-129595b3-4136-47e7-b754-184987b042b7.jpeg">

### Example
<img width="480" alt="chart2" src="https://user-images.githubusercontent.com/284922/168489399-b5c33896-b315-46d0-aa2f-dd28e732977c.jpeg">

# Usage

## Spiral Shape

It has several parameters:
- `pathType`: the type of path you want to draw.
- `startAt`: the start angle of a spiral.
- `endAt`: the end angle of a spiral.
- `smoothness`: the point density which describes a spiral.
- `offsetRadius`: spiral radius offset for each point with respect to the calculated angle and frame.
- `offsetAngle`: angle offset of each spiral point with respect to the calculated angle and frame.

<img width="746" alt="image" src="https://user-images.githubusercontent.com/284922/168490287-a263e152-8654-4e0d-85cb-d7a119f64838.png">

```swift
var body: some View {
    Spiral(
        startAt: .degrees(90),
        endAt: .degrees(360)
    )
    .stroke(
        Color.blue,
        style: .init(lineWidth: 20, lineCap: .round, lineJoin: .round)
    )
}
```

## Spiral View

When using`SpiralView`, you need to position the content based on the spiral point coordinates.

```swift
var body: some View {
    SpiralView(
        startAt: .degrees(90),
        endAt: .degrees(360)
    ) { index, spiralPoint in
        Text("Hello")
            .position(x: spiralPoint.point.x, y: spiralPoint.point.y)
    }
}
```

# Documentation

You can find the generated DocC documentation [here](https://prowork.today/Spiral/documentation/spiral).

# License

`Spiral` is available under the [MIT license](https://github.com/buh/Spiral/blob/main/LICENSE)
