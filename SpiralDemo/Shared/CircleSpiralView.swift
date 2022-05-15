//
//  CircleSpiralView.swift
//  SpiralDemo
//
//  Created by bukhtin on 14/05/2022.
//

import SwiftUI
import Spiral
import CompactSlider

struct CircleSpiralView: View {
    
    @State private var radius: CGFloat = .radius
    @State private var lineWidth: CGFloat = 1
    @State private var startAt: Double = 270
    @State private var endAt: Double = 1030
    @State private var smoothness: CGFloat = 50
    @State private var offsetRadius: CGFloat = 0
    @State private var offsetAngle: Double = 0
    @State private var showGuideLine: Bool = false
    
    var body: some View {
        VStack(spacing: .spiralSpacing) {
            ZStack {
                if showGuideLine {
                    Spiral(
                        startAt: .degrees(startAt),
                        endAt: .degrees(endAt),
                        smoothness: smoothness
                    )
                    .stroke(.gray, lineWidth: 1)
                }
                
                Spiral(
                    pathType: .circle(radius: radius),
                    startAt: .degrees(startAt),
                    endAt: .degrees(endAt),
                    smoothness: smoothness,
                    offsetRadius: offsetRadius,
                    offsetAngle: .degrees(offsetAngle)
                )
                .stroke(
                    Color.blue,
                    style: .init(lineWidth: lineWidth, lineCap: .round, lineJoin: .round)
                )
            }
            .padding((radius + lineWidth) / 2)
            .padding(.spiralPadding)
            
            HStack {
                CompactSlider(value: $radius, in: 1...100) {
                    Text("1")
                    Spacer()
                    Text("Radius: \(Int(radius))")
                    Spacer()
                    Text("100")
                }
                
                CompactSlider(value: $lineWidth, in: 1...50) {
                    Text("1")
                    Spacer()
                    Text("Line width: \(Int(lineWidth))")
                    Spacer()
                    Text("50")
                }
            }
            
            CompactSlider(
                from: $startAt,
                to: $endAt,
                in: 0...1440,
                step: 10) {
                Text("Start: \(Int(startAt))")
                Spacer()
                Text("End: \(Int(endAt))")
            }
            .compactSliderDisabledHapticFeedback(true)
            
            CompactSlider(value: $smoothness, in: 2...50, step: 1) {
                Text("2")
                Spacer()
                Text("Smoothness: \(Int(smoothness))")
                Spacer()
                Text("50")
            }
            .compactSliderDisabledHapticFeedback(true)
            
            HStack {
                Text("Offset:")
                
                CompactSlider(
                    value: $offsetRadius,
                    in: -40...40,
                    step: 1,
                    direction: .center
                ) {
                    Text("Radius: \(Int(offsetRadius))")
                    Spacer()
                }
                
                CompactSlider(
                    value: $offsetAngle,
                    in: -45...45,
                    step: 1,
                    direction: .center
                ) {
                    Text("Angle: \(Int(offsetAngle))")
                    Spacer()
                }
                
                Divider().frame(height: 40)
                Toggle("Show guide line", isOn: $showGuideLine)
            }
        }
        .padding()
    }
}

private extension CGFloat {
    static let radius: CGFloat = {
        #if os(macOS)
        75
        #else
        50
        #endif
    }()
}

struct CircleSpiralView_Previews: PreviewProvider {
    static var previews: some View {
        CircleSpiralView()
    }
}
