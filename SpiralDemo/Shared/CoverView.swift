// The MIT License (MIT)
//
// Copyright (c) 2022 Alexey Bukhtin (github.com/buh).
//

import SwiftUI
import Spiral

struct CoverView: View {
    
    @State private var rotate = false
    
    var body: some View {
        ZStack {
            Color(hue: 0.44, saturation: 0.4, brightness: 0.9)
            
            VStack(spacing: 8) {
                Spiral(
                    startAt: .degrees(45),
                    endAt: .degrees(680)
                )
                .stroke(
                    Color(hue: 0.7, saturation: 0.4, brightness: 0.9),
                    style: .init(lineWidth: 20, lineCap: .round)
                )
                .offset(y: 15)
                .padding(20)
                .frame(width: 250, height: 250)
                .rotationEffect(.degrees(rotate ? 720 : 0))
                .background(
                    RoundedRectangle(cornerRadius: 38, style: .continuous)
                        .fill(.white)
                        .shadow(radius: 3, y: 2)
                )
                .padding(.bottom)
                
                Text("Spiral")
                    .font(.title.bold())
                
                Link(destination: URL(string: "https://github.com/buh/Spiral")!) {
                    Text("GitHub")
                        .underline()
                }

                Text("Copyright (c) 2022 Alexey Bukhtin")
                
                Link(destination: URL(string: "https://github.com/buh/Spiral/blob/main/LICENSE")!) {
                    Text("The MIT License (MIT)")
                        .underline()
                }
            }
            .foregroundColor(.black)
            .padding()
        }
        .clipShape(RoundedRectangle(cornerRadius: 38, style: .continuous))
        .onAppear {
            withAnimation(
                Animation.easeInOut(duration: 4)
                    .repeatForever(autoreverses: true)
                    .delay(0.5)
            ) {
                rotate = true
            }
        }
        #if os(macOS)
        .padding()
        #else
        .padding(.vertical, 42)
        #endif
    }
}

struct CoverView_Previews: PreviewProvider {
    static var previews: some View {
        CoverView()
    }
}
