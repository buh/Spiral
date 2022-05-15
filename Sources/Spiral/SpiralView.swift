// The MIT License (MIT)
//
// Copyright (c) 2022 Alexey Bukhtin (github.com/buh).
//

import SwiftUI

/// View with placement of contents on spiral points.
public struct SpiralView<Content: View>: View {
    
    private let startAt: Angle
    private let endAt: Angle
    private let smoothness: CGFloat
    private let offsetRadius: CGFloat
    private let offsetAngle: Angle
    @Binding private var pointsCount: Int
    @ViewBuilder private let content: (Int, SpiralPoint) -> Content
    
    /// Creates a view with placement of contents on spiral points.
    /// - Parameters:
    ///   - startAt: the start angle of a spiral.
    ///   - endAt: the end angle of a spiral.
    ///   - smoothness: the point density which describes a spiral.
    ///   - offsetRadius: spiral radius offset for each point with respect to the calculated angle and frame.
    ///   - offsetAngle: angle offset of each spiral point with respect to the calculated angle and frame.
    ///   - pointsCount: the number of spiral points.
    ///   - content: the content view.
    public init(
        startAt: Angle = .degrees(90),
        endAt: Angle = .degrees(450),
        smoothness: CGFloat = 12,
        offsetRadius: CGFloat = 0,
        offsetAngle: Angle = .zero,
        pointsCount: Binding<Int> = .constant(0),
        @ViewBuilder content: @escaping (Int, SpiralPoint) -> Content
    ) {
        self.startAt = startAt
        self.endAt = endAt
        self.smoothness = smoothness
        self.offsetRadius = offsetRadius
        self.offsetAngle = offsetAngle
        _pointsCount = pointsCount
        self.content = content
    }
    
    public var body: some View {
        GeometryReader { proxy in
            if let spiralPoints = spiralPoints(in: proxy.size) {
                ForEach(0..<spiralPoints.count, id: \.self) { index in
                    content(index, spiralPoints[index])
                }
            }
        }
    }
    
    private func spiralPoints(in size: CGSize) -> [SpiralPoint]? {
        let spiralPoints = [SpiralPoint](
            in: .init(origin: .zero, size: size),
            startAt: startAt,
            endAt: endAt,
            smoothness: smoothness,
            offsetRadius: offsetRadius,
            offsetAngle: offsetAngle
        )
        
        pointsCount = spiralPoints?.count ?? 0
        
        return spiralPoints
    }
}

struct SpiralView_Previews: PreviewProvider {
    
    static let text = "HELLO,WORLD! "
    
    static var previews: some View {
        SpiralView(
            startAt: .degrees(180),
            endAt: .degrees(760)
        ) { index, spiralPoint in
            let startIndex = text.index(text.startIndex, offsetBy: (index % text.count))
            Text(text[startIndex...startIndex])
                .position(x: spiralPoint.point.x, y: spiralPoint.point.y)
        }
        .font(.title.bold())
        .frame(width: 600, height: 600)
        .padding()
    }
}
