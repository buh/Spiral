// The MIT License (MIT)
//
// Copyright (c) 2022 Alexey Bukhtin (github.com/buh).
//

import SwiftUI

/// A 2D shape to draw a spiral.
///
/// Shapes without an explicit fill or stroke get a default fill based on the foreground color.
public struct Spiral: Shape {
    
    let pathType: SpiralPathType
    let startAt: Angle
    let endAt: Angle
    let smoothness: CGFloat
    let offsetRadius: CGFloat
    let offsetAngle: Angle
    
    /// Creates a spiral.
    ///
    /// - Parameters:
    ///   - pathType: the type of path you want to draw.
    ///   - startAt: the start angle of a spiral.
    ///   - endAt: the end angle of a spiral.
    ///   - smoothness: the point density which describes a spiral.
    ///   - offsetRadius: spiral radius offset for each point with respect to the calculated angle and frame.
    ///   - offsetAngle: angle offset of each spiral point with respect to the calculated angle and frame.
    public init(
        pathType: SpiralPathType = .line,
        startAt: Angle = .zero,
        endAt: Angle = .degrees(360),
        smoothness: CGFloat = 48,
        offsetRadius: CGFloat = 0,
        offsetAngle: Angle = .zero
    ) {
        self.pathType = pathType
        self.startAt = startAt
        self.endAt = endAt
        self.smoothness = smoothness
        self.offsetRadius = offsetRadius
        self.offsetAngle = offsetAngle
    }
    
    public func path(in rect: CGRect) -> Path {
        Path { path in
            guard let spiralPoints = [SpiralPoint](
                in: rect,
                startAt: startAt,
                endAt: endAt,
                smoothness: smoothness,
                offsetRadius: offsetRadius,
                offsetAngle: offsetAngle
            ) else {
                return
            }
            
            guard !spiralPoints.isEmpty else { return }
            
            if case .circle(radius: let radius) = pathType {
                let circleSize = CGSize(width: radius, height: radius)
                
                spiralPoints.forEach { spiralPoint in
                    path.addEllipse(in: .init(origin: spiralPoint.point - radius / 2, size: circleSize))
                }
                
            } else if case .rect(let width, let height) = pathType {
                let size = CGSize(width: width, height: height)
                let sizeMidPoint = CGPoint(x: width / 2, y: height / 2)
                
                spiralPoints.forEach { spiralPoint in
                    let rect = CGRect(origin: spiralPoint.point - sizeMidPoint, size: size)
                    
                    let transform = CGAffineTransform(translationX: rect.midX, y: rect.midY)
                        .rotated(by: spiralPoint.angle.radians + .pi / 2)
                        .translatedBy(x: -rect.midX, y: -rect.midY)
                    
                    path.addRect(rect, transform: transform)
                }
                
            } else if case .graph(let callback) = pathType {
                path.addLines(spiralPoints.map(\.point).reversed())
                let count = spiralPoints.count
                                
                for i in 0..<count {
                    let progress: Double = Double(i) / Double(count)
                    let height = callback(progress)
                    let point = spiralPoints[i].point
                    let x = point.x + height * cos(spiralPoints[i].angle.radians)
                    let y = point.y + height * sin(spiralPoints[i].angle.radians)
                    path.addLine(to: .init(x: x, y: y))
                }
                
                path.closeSubpath()
                
            } else {
                path.addLines(spiralPoints.map(\.point))
            }
        }
    }
}

/// Type of path to draw the spiral.
public enum SpiralPathType {
    /// Line type draws lines between spiral points.
    case line
    
    /// Circle type draws circles at spiral points.
    case circle(radius: CGFloat)
    
    /// Rectangle type draws rectangles at spiral points.
    case rect(width: CGFloat, height: CGFloat)
    
    /// The graph type draws a graph on the basis of the function.
    ///
    /// The function should return the height of the graph at the requested point of the spiral,
    /// which is forwarded as the progress of all points and has a range of 0 to 1.
    case graph((_ progress: Double) -> CGFloat)
}

// MARK: - CG Helpers

private extension CGPoint {
    static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    static func -(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        CGPoint(x: lhs.x - rhs, y: lhs.y - rhs)
    }
}

struct Spiral_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                spiral(density: 2).frame(width: 200, height: 200)
                spiral(density: 2).frame(width: 200, height: 200)
            }
            HStack {
                spiral().frame(width: 250, height: 200)
                spiral().frame(width: 250, height: 200)
            }
            HStack {
                spiral().frame(width: 200, height: 250)
                spiral().frame(width: 200, height: 250)
            }
        }
        .padding()
    }
    
    private static func spiral(density: CGFloat = 1) -> some View {
        ZStack {
            Spiral().stroke()
            
            Spiral(
                pathType: .rect(width: 1, height: 10)
            )
            .fill(Color.blue)
        }
        .border(Color.pink, width: 1)
    }
}
