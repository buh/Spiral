//
//  AutoStack.swift
//  SpiralDemo
//
//  Created by bukhtin on 15/05/2022.
//

import SwiftUI

struct AutoStack<Content: View>: View {
    
    var spacing: CGFloat = 8
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        Group {
            if isBigScreen {
                HStack(spacing: spacing, content: content)
            } else {
                VStack(spacing: spacing, content: content)
            }
        }
    }
}

extension View {
    var isBigScreen: Bool {
        #if os(macOS)
        true
        #else
        if UIDevice.current.userInterfaceIdiom == .pad {
            return true
        }
        
        return false
        #endif
    }
}

struct AutoStack_Previews: PreviewProvider {
    static var previews: some View {
        AutoStack(spacing: 20) {
            Text("1")
            Text("2")
        }
    }
}
