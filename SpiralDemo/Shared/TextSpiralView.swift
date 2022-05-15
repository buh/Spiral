// The MIT License (MIT)
//
// Copyright (c) 2022 Alexey Bukhtin (github.com/buh).
//

import SwiftUI
import Spiral
import CompactSlider

struct TextSpiralView: View {
    
    @State private var text: String = ""
    @State private var fontSize: CGFloat = 16
    @State private var startAt: Double = 180
    @State private var endAt: Double = 760
    @State private var smoothness: CGFloat = 12
    @State private var offsetRadius: CGFloat = 0
    @State private var offsetAngle: Double = 0
    @State private var showGuideLine: Bool = false
    @State private var pointsCount: Int = 0
    
    var body: some View {
        VStack(spacing: .spiralSpacing) {
            HStack {
                Spacer()
                if #available(iOS 15.0, macOS 12.0, *) {
                    Text("Points: \(pointsCount)").monospacedDigit()
                } else {
                    Text("Points: \(pointsCount)")
                }
            }
            
            ZStack {
                if showGuideLine {
                    Spiral(
                        startAt: .degrees(startAt),
                        endAt: .degrees(endAt),
                        smoothness: smoothness
                    )
                    .stroke(.gray, lineWidth: 1)
                }
                
                let text = text.isEmpty ? "Hello,World! " : text
                
                SpiralView(
                    startAt: .degrees(startAt),
                    endAt: .degrees(endAt),
                    smoothness: smoothness,
                    offsetRadius: offsetRadius,
                    offsetAngle: .degrees(offsetAngle),
                    pointsCount: $pointsCount
                ) { index, spiralPoint in
                    let startIndex = text.index(text.startIndex, offsetBy: (index % text.count))
                    Text(text[startIndex...startIndex])
                        .font(.system(size: fontSize).bold())
                        .position(x: spiralPoint.point.x, y: spiralPoint.point.y)
                }
            }
            .padding(.top, -12)
            .padding(.spiralPadding)
            
            HStack {
                TextField("Hello,World!", text: $text)
                    .textFieldStyle(.roundedBorder)
                
                CompactSlider(value: $fontSize, in: 10...50, step: 1) {
                    Text("Font size: \(Int(fontSize))")
                    Spacer()
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

struct TextSpiralView_Previews: PreviewProvider {
    static var previews: some View {
        TextSpiralView()
    }
}
