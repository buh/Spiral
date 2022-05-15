// The MIT License (MIT)
//
// Copyright (c) 2022 Alexey Bukhtin (github.com/buh).
//

import SwiftUI
import CompactSlider

struct ContentView: View {
    
    var body: some View {
        TabView {
            LineSpiralView()
                .tabItem {
                    Label("Line", systemImage: "line.diagonal")
                }
            RectangleSpiralView()
                .tabItem {
                    Label("Rectangle", systemImage: "rectangle")
                }
            CircleSpiralView()
                .tabItem {
                    Label("Circle", systemImage: "circle")
                }
            TextSpiralView()
                .tabItem {
                    Label("Text", systemImage: "t.circle")
                }
            ChartSpiralView()
                .tabItem {
                    Label("Chart", systemImage: "chart.bar.xaxis")
                }
            ExampleSpiralView()
                .tabItem {
                    Label("Example", systemImage: "star")
                }
            CoverView()
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
        }
        .compactSliderDisabledHapticFeedback(true)
        .navigationTitle("Spiral")
        #if os(macOS)
        .padding()
        #endif
    }
}

extension CGFloat {
    static let spiralPadding: CGFloat = {
        #if os(macOS)
        40
        #else
        0
        #endif
    }()
    
    static let spiralSpacing: CGFloat = {
        #if os(macOS)
        20
        #else
        12
        #endif
    }()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
