// The MIT License (MIT)
//
// Copyright (c) 2022 Alexey Bukhtin (github.com/buh).
//

import SwiftUI
import Spiral
import CompactSlider

struct ExampleSpiralView: View {
    
    @State private var maxHeight: CGFloat = 30
    @State private var startAt: Double = 570
    @State private var endAt: Double = 990
    @State private var smoothness: CGFloat = 48
    
    private let months = Calendar.current.shortMonthSymbols
    
    var body: some View {
        VStack(spacing: .spiralSpacing) {
            ZStack {
                Spiral(
                    pathType: .chart(data),
                    startAt: .degrees(startAt),
                    endAt: .degrees(endAt),
                    smoothness: smoothness
                )
                .fill(
                    LinearGradient(
                        colors: [.blue, .green],
                        startPoint: .bottomLeading,
                        endPoint: .topTrailing
                    )
                )
                
                Spiral(
                    startAt: .degrees(startAt),
                    endAt: .degrees(endAt)
                )
                .stroke(style: .init(lineWidth: 1, dash: [1, 5]))
                
                Spiral(
                    pathType: .rect(width: 0.5, height: 10),
                    startAt: .degrees(startAt),
                    endAt: .degrees(endAt),
                    smoothness: 6,
                    offsetRadius: -5
                )
                .fill()
                
                SpiralView(
                    startAt: .degrees(startAt),
                    endAt: .degrees(endAt),
                    smoothness: 6,
                    offsetRadius: isBigScreen ? -30 : -20,
                    offsetAngle: .degrees(-14)
                ) { index, spiralPoint in
                    Text(months[months.count - 1 - (index + 10) % months.count])
                        .font(Font.system(size: isBigScreen ? 16 : 12))
                        .position(x: spiralPoint.point.x, y: spiralPoint.point.y)
                }
            }
            .padding(.leading, 20)
            .padding(.spiralPadding)
            
//            CompactSlider(value: $maxHeight, in: 1...100, step: 1) {
//                Text("Max height: \(Int(maxHeight))")
//            }
//
//            SpiralBaseControls(
//                startAt: $startAt,
//                endAt: $endAt,
//                smoothness: $smoothness
//            )
        }
        .padding()
    }
    
    private func data(_ progress: Double) -> CGFloat {
        CGFloat.random(in: 1...(isBigScreen ? 20 : 10))
        + (maxHeight + (isBigScreen ? 0 : -10)) * abs(sin(progress * 10))
    }
}

struct ExampleSpiralView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleSpiralView()
    }
}
