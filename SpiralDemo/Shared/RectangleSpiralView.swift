//
//  RectangleSpiralView.swift
//  SpiralDemo
//
//  Created by bukhtin on 14/05/2022.
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
