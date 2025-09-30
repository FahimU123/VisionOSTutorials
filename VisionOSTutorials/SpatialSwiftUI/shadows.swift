//
//  Example027.swift
//  VisionOSTutorials
//
//  Created by Fahim Uddin on 9/29/25.
//

import SwiftUI

/// This is to show that shadows are used mostly to show depth but are unconvncing in VisionOS unless you adjust the views z position via some modifier like trasnform3DEffect or offset
struct shadows: View {
    @State private var shadowRadius: CGFloat = 6.0
    @State private var direction: CGFloat = 0.0
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Slider(value: $shadowRadius,
                       in: 0...12,
                       minimumValueLabel: Image(systemName: "sqaure.fill"),
                       maximumValueLabel: Image(systemName: "square.fill.on.square.fill"),
                       label:  {
                    Text("Shadow")
                })
                
                Slider(value: $direction,
                       in: 0...100,
                       minimumValueLabel: Image(systemName: "Square.fill"),
                       maximumValueLabel: Image(systemName: "square.fill.on.square.fill"),
                       label: {
                    Text("Direction")
                })
            }
            HStack(spacing: 24) {
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(.white)
                    .shadow(radius: shadowRadius, x: direction, y: direction)
                
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(.white)
                    .offset(z: 50)
                    .shadow(radius: shadowRadius, x: direction, y: direction)
                
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(.white)
                    .offset(z: 100)
                    .shadow(radius: shadowRadius, x: direction, y: direction)
            }
            .padding(12)
        }
        .padding(12)
    }
}

#Preview {
    shadows()
}
