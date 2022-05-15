//
//  LineSpiralView.swift
//  SpiralDemo
//
//  Created by bukhtin on 14/05/2022.
//

import SwiftUI
import Spiral
import CompactSlider

struct LineSpiralView: View {
    
    @State private var lineWidth: CGFloat = .lineWidth
    @State private var startAt: Double = 90
    @State private var endAt: Double = 1030
    @State private var smoothness: CGFloat = 50
    
    var body: some View {
        VStack(spacing: .spiralSpacing) {
            Spiral(
                startAt: .degrees(startAt),
                endAt: .degrees(endAt),
                smoothness: smoothness
            )
            .stroke(
                Color.blue,
                style: .init(lineWidth: lineWidth, lineCap: .round, lineJoin: .round)
            )
            .padding(lineWidth / 2)
            .padding(.spiralPadding)
            
            CompactSlider(value: $lineWidth, in: 1...100) {
                Text("1")
                Spacer()
                Text("Line width: \(Int(lineWidth))")
                Spacer()
                Text("100")
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
        }
        .padding()
    }
}

private extension CGFloat {
    static let lineWidth: CGFloat = {
        #if os(macOS)
        40
        #else
        25
        #endif
    }()
}

struct LineSpiralView_Previews: PreviewProvider {
    static var previews: some View {
        LineSpiralView()
    }
}
