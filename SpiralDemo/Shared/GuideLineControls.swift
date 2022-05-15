//
//  GuideLineControls.swift
//  SpiralDemo
//
//  Created by bukhtin on 15/05/2022.
//

import SwiftUI
import CompactSlider

struct GuideLineControls: View {
    
    @Binding var offsetRadius: CGFloat
    @Binding var offsetAngle: Double
    @Binding var showGuideLine: Bool
    
    var body: some View {
        Group {
            if isBigScreen {
                HStack {
                    offsetView
                    Divider().frame(height: 40)
                    toggleView
                }
            } else {
                VStack {
                    offsetView
                    toggleView
                }
            }
        }
    }
    
    @ViewBuilder
    private var offsetView: some View {
        if isBigScreen {
            Text("Offset:")
        }
        
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
    }
    
    private var toggleView: some View {
        Toggle("Show guide line", isOn: $showGuideLine)
    }
}

struct GuideLineControls_Previews: PreviewProvider {
    static var previews: some View {
        GuideLineControls(
            offsetRadius: .constant(0),
            offsetAngle: .constant(0),
            showGuideLine: .constant(true)
        )
    }
}
