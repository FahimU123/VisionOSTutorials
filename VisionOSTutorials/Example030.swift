//
//  Example030.swift
//  VisionOSTutorials
//
//  Created by Fahim Uddin on 9/29/25.
//

import SwiftUI

struct Example030: View {
    @State private var showOffset = false
    var body: some View {
        VStack(spacing: 24) {
            Toggle("Toggle Offset", isOn: $showOffset.animation())
                .toggleStyle(.button)
            
            HStack(spacing: 24) {
                
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(.red)
                    .offset(z: showOffset ? 12 : 0)
                    .offset(x: showOffset ? 48 : 0)
                
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(.blue)
                    .offset(z: showOffset ? 24 : 0)
                
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(.red)
                    .offset(z: showOffset ? 36 : 0)
                    .offset(x: showOffset ? -48 : 0)
            }
            .padding(12)
        }
        .padding(12)
    }
}

#Preview {
    Example030()
}
