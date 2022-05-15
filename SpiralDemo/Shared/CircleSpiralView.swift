// The MIT License (MIT)
//
// Copyright (c) 2022 Alexey Bukhtin (github.com/buh).
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
            
            SpiralBaseControls(
                startAt: $startAt,
                endAt: $endAt,
                smoothness: $smoothness
            )
            
            GuideLineControls(
                offsetRadius: $offsetRadius,
                offsetAngle: $offsetAngle,
                showGuideLine: $showGuideLine
            )
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
