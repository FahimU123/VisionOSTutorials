//
//  SpatialTapGesture.swift
//  VisionOSTutorials
//
//  Created by Fahim Uddin on 10/2/25.
//

import RealityKit
import RealityKitContent
import SwiftUI

// Best for when you want the 3D coordinates of where user tapped, can be used for things like spawning entities at tapped location
struct SpatialTapGestures: View {
    // this is the box that is going to have a marker on us
    @State private var subject: Entity?
    // this is the marker, the thing that spawns when you tap
    @State private var indicator: Entity?
    
    var body: some View {
        RealityView { content in
            if let scene = try? await Entity(named: "SpatialTapLab", in: realityKitContentBundle) {
                content.add(scene)
                
                let indicatorModel = ModelEntity(
                    mesh: .generateSphere(radius: 0.025),
                    materials: [SimpleMaterial(color: .red, isMetallic: true)]
                )
                
                if let cube = scene.findEntity(named: "Cube") {
                    cube.components.set(HoverEffectComponent())
                    cube.addChild(indicatorModel)
                    subject = cube
                    indicator = indicatorModel
                }
            }
        }
        .gesture(spatialTapExample)
    }
    var spatialTapExample: some Gesture {
        SpatialTapGesture()
            .targetedToAnyEntity()
            .onEnded { value in
                if let subject = subject, let indicator = indicator {
                    // Convert the location3D value to the coordinate space of the subject
                    // Place the indicator on the surface of the subject
                    let tappedPosition = value.convert(value.location3D, from: .local, to: subject)
                    indicator.position = tappedPosition
                }
                
            }
    }

}

#Preview {
    SpatialTapGestures()
}
