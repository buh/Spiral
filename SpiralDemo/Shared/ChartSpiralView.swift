// The MIT License (MIT)
//
// Copyright (c) 2022 Alexey Bukhtin (github.com/buh).
//

import SwiftUI
import Spiral
import CompactSlider

struct ChartSpiralView: View {
    
    @State private var maxHeight: CGFloat = 20
    @State private var randomOrSin: Bool = true
    @State private var startAt: Double = 270
    @State private var endAt: Double = 1030
    @State private var smoothness: CGFloat = 50

    var body: some View {
        VStack(spacing: .spiralSpacing) {
            Spiral(
                pathType: .chart(data),
                startAt: .degrees(startAt),
                endAt: .degrees(endAt),
                smoothness: smoothness
            )
            .fill(
                Color.blue
            )
            .padding(10)
            .padding(.spiralPadding)
            
            AutoStack(spacing: .spiralSpacing) {
                CompactSlider(value: $maxHeight, in: 1...100, step: 1) {
                    Text("Max height: \(Int(maxHeight))")
                }
                
                Toggle("On — Sine wave / Off — Random", isOn: $randomOrSin)
            }
            
            SpiralBaseControls(
                startAt: $startAt,
                endAt: $endAt,
                smoothness: $smoothness
            )
        }
        .padding()
    }
    
    private func data(_ progress: Double) -> CGFloat {
        if randomOrSin {
            return maxHeight * sin(progress * 20)
        }
        
        return CGFloat.random(in: 1...maxHeight) 
    }
}

struct ChartSpiralView_Previews: PreviewProvider {
    static var previews: some View {
        ChartSpiralView()
    }
}
