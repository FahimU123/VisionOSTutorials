//
//  RealityUpdates.swift
//  VisionOSTutorials
//
//  Created by Fahim Uddin on 10/1/25.
//

import RealityKit
import SwiftUI

struct RealityUpdates: View {
    @State private var showSphere = true
    @State var subject: Entity = {
        let mat = SimpleMaterial(color: .green, roughness: 0.2, isMetallic: false)
        let spehre = ModelEntity(
            mesh: .generateSphere(radius: 0.1),
            materials: [mat])
        spehre.name = "Sphere"
            return spehre
    }()
    
    var body: some View {
        RealityView { content in
            content.add(subject)
        } update: { content in
            // If you want updates to happen first locate the specific entity as shows then have some property change values and BANG
            if let sphere = content.entities.first?.findEntity(named: "Sphere") {
                // All entities come with properties and methods like isEnabled, explore them via .
                sphere.isEnabled = showSphere
            }
        }
        .toolbar {
            ToolbarItem(placement: .bottomOrnament, content: {
                HStack {
                    Toggle("Show Spehere", isOn: $showSphere)
                        .toggleStyle(.button)
                }
            })
        }
    }
}

#Preview {
    RealityUpdates()
}
