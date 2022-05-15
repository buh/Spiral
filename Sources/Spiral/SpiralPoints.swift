// The MIT License (MIT)
//
// Copyright (c) 2022 Alexey Bukhtin (github.com/buh).
//

import Foundation
import SwiftUI

/// Spiral point with location and angular position.
public struct SpiralPoint {
    
    /// A spiral point location.
    public let point: CGPoint
    
    /// A spiral point angle.
    public let angle: Angle
    
    /// A default empty value.
    public static let zero = SpiralPoint(point: .zero, angle: .zero)
}

public extension Array where Element == SpiralPoint {
    
    /// Creates a new `SpiralPoint` array.
    ///
    /// The start angle of the spiral must be greater than the end angle and greater than 0,
    /// otherwise it will return nil.
    ///
    /// - Note: The smoothness cannot be less than 2 .
    ///
    /// - Parameters:
    ///   - rect: the frame of reference for describing a spiral.
    ///   - startAt: the start angle of a spiral.
    ///   - endAt: the end angle of a spiral.
    ///   - smoothness: the point density which describes a spiral.
    ///   - offsetRadius: spiral radius offset for each point with respect to the calculated angle and frame.
    ///   - offsetAngle: angle offset of each spiral point with respect to the calculated angle and frame.
    init?(
        in rect: CGRect,
        startAt: Angle = .zero,
        endAt: Angle = .degrees(360),
        smoothness: CGFloat,
        offsetRadius: CGFloat = 0,
        offsetAngle: Angle = .zero
    ) {
        let startAtRadians = startAt.radians + offsetAngle.radians
        let endAtRadians = endAt.radians + offsetAngle.radians
        
        guard startAtRadians >= 0, endAtRadians > startAtRadians else { return nil }
        
        // Calculate the spiral radius.
        let endAtCos = abs(cos(endAtRadians))
        let endAtSin = abs(sin(endAtRadians))
        let minRadius = Swift.min(rect.maxX, rect.maxY) / 2
        let radiusX = (minRadius / (endAtCos == 0 ? 1 : endAtCos)) / endAtRadians
        let radiusY = (minRadius / (endAtSin == 0 ? 1 : endAtSin)) / endAtRadians
        let maxRadius = Swift.min(radiusX, radiusY)
        let radius = Swift.max(maxRadius * endAtCos, maxRadius * endAtSin)
        
        let smoothness = Swift.max(2, Swift.min(300, smoothness))
        let midPoint = CGPoint(x: rect.midX, y: rect.midY)
        var points = [SpiralPoint]()
        var i: CGFloat = startAtRadians / .pi * smoothness
        let j: CGFloat = endAtRadians / .pi * smoothness
        
        repeat {
            let t: CGFloat = i / smoothness * .pi
            
            // Ignore out-of-range points due to radius offset.
            if t >= startAt.radians, t <= endAt.radians {
                let x = (t * radius + offsetRadius) * cos(t)
                let y = (t * radius + offsetRadius) * sin(t)
                let point = CGPoint(x: midPoint.x + x, y: midPoint.y + y)
                points.append(SpiralPoint(point: point, angle: .radians(t)))
            }
            
            i += 1
        } while i < j
        
        self = points
    }
}
