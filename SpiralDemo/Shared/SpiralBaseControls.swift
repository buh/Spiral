// The MIT License (MIT)
//
// Copyright (c) 2022 Alexey Bukhtin (github.com/buh).
//

import SwiftUI
import CompactSlider

struct SpiralBaseControls: View {
    
    @Binding var startAt: Double
    @Binding var endAt: Double
    @Binding var smoothness: CGFloat
    
    var body: some View {
        Group {
            CompactSlider(
                from: $startAt,
                to: $endAt,
                in: 0...1440,
                step: 10) {
                Text("Start: \(Int(startAt))")
                Spacer()
                Text("End: \(Int(endAt))")
            }
            
            CompactSlider(value: $smoothness, in: 2...50, step: 1) {
                Text("2")
                Spacer()
                Text("Smoothness: \(Int(smoothness))")
                Spacer()
                Text("50")
            }
        }
    }
}

struct SpiralBaseControls_Previews: PreviewProvider {
    static var previews: some View {
        SpiralBaseControls(
            startAt: .constant(90),
            endAt: .constant(360),
            smoothness: .constant(12)
        )
    }
}
