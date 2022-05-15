// The MIT License (MIT)
//
// Copyright (c) 2022 Alexey Bukhtin (github.com/buh).
//

import SwiftUI
import Spiral
import CompactSlider

struct RectangleSpiralView: View {
    
    @State private var rectWidth: CGFloat = 1
    @State private var rectHeight: CGFloat = 80
    @State private var startAt: Double = .startAt
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
                    pathType: .rect(width: rectWidth, height: rectHeight),
                    startAt: .degrees(startAt),
                    endAt: .degrees(endAt),
                    smoothness: smoothness,
                    offsetRadius: offsetRadius,
                    offsetAngle: .degrees(offsetAngle)
                )
                .fill(.blue)
            }
            .padding(max(rectWidth, rectHeight) / 2)
            .padding(.spiralPadding)
            
            HStack {
                CompactSlider(value: $rectWidth, in: 1...50) {
                    Text("1")
                    Spacer()
                    Text("Width: \(Int(rectWidth))")
                    Spacer()
                    Text("50")
                }
                
                CompactSlider(value: $rectHeight, in: 1...100) {
                    Text("1")
                    Spacer()
                    Text("Height: \(Int(rectHeight))")
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

private extension Double {
    static let startAt: Double = {
        #if os(macOS)
        180
        #else
        360
        #endif
    }()
}

struct RectangleSpiralView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleSpiralView()
    }
}
