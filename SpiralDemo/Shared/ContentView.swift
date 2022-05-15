//
//  ContentView.swift
//  Shared
//
//  Created by bukhtin on 14/05/2022.
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
