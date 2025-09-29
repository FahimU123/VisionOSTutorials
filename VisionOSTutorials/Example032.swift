//
//  Example032.swift
//  VisionOSTutorials
//
//  Created by Fahim Uddin on 9/29/25.
//

import SwiftUI

struct Example032: View {
    @State private var isActive = false
    @State private var showWindow = true
    var body: some View {
        VStack(spacing: 24) {
            Button(action: handleButtonPress) {
                Image(systemName: isActive ? "square.stack.3d.down.right.fill" : " square.fill")
                Text("Toggle Layout")
                
                HStack(spacing: 24) {
                    
                    RoundedRectangle(cornerRadius: 12.0)
                        .foregroundStyle(.red)
                        .offset(x: isActive ? -60 : 0)
                        .offset(z: isActive ? 80 : 1)
                        .rotation3DEffect(
                            Angle(degrees: isActive ? 25 : 0), axis: (x: 0, y: 1, z: 0)
                        )
                    
                    RoundedRectangle(cornerRadius: 12.0)
                        .foregroundStyle(.blue)
                        .offset(z: isActive ? 60 : 0)
                        .offset(z: isActive ? 40 : 1)
                    
                    RoundedRectangle(cornerRadius: 12.0)
                        .foregroundStyle(.green)
                        .offset(x: isActive ? 60 : 0)
                        .offset(z: isActive ? 80 : 1)
                        .rotation3DEffect(
                            Angle(degrees: isActive ? -25 : 0), axis: (x: 0, y: 1, z: 0)
                        )
                }
                .padding(12)
            }
            .padding(12)
            // This effect is good to have for VisionOS apps as it takes care of a lot of stuff liek lighting and makes the app feel more native
            .glassBackgroundEffect(displayMode: showWindow ? .always : .never)
            // Persistent Overlays are liek in MacOS the menu bar or VisionOS has the Home Indicator at the bottom and you want your user to be fully immersed into your app so you turn that stuff off
            .persistentSystemOverlays(showWindow ? .visible : .hidden)
        }
    }
    
    /// Since we adjust  the UI with both properties, if it is going to be smooth it must happen sequntually, therefore we do one change, do a manual delay then make the other change
    ///  Yes this coudle been auto done using async and we dont need to do Task.sleep but Button(action: ) doesnt take async code, you would have to wrap it in Task
    func handleButtonPress() {
        Task {
            if isActive {
                // When you modify a property that effects the view you can wrap it in withAnimation to make it smooth
                withAnimation {
                    isActive.toggle()
                }
                try? await Task.sleep(nanoseconds: 500_000_000)
                showWindow = true
            } else {
                showWindow = false
                
                try? await Task.sleep(nanoseconds: 500_000_000)
                withAnimation {
                    isActive.toggle()
                }
            }
        }
    }
}

#Preview {
    Example032()
}
