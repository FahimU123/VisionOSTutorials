//
//  Manipulation.swift
//  VisionOSTutorials
//
//  Created by Fahim Uddin on 10/9/25.
//

import RealityKit
import RealityKitContent
import SwiftUI

struct Manipulation: View {
    @State var releaseBehavior: ManipulationComponent.ReleaseBehavior = .reset
    @State var translateBehavior: ManipulationComponent.Dynamics.TranslationBehavior = .unconstrained
    @State var rotationBehaviorPrimary: ManipulationComponent.Dynamics.RotationBehavior = .unconstrained
    @State var rotationBehaviorSecondary: ManipulationComponent.Dynamics.RotationBehavior = .unconstrained
    @State var scalingBehavior: ManipulationComponent.Dynamics.ScalingBehavior = .unconstrained
    @State var inertia: ManipulationComponent.Dynamics.Inertia = .zero
    
    @State var subject: Entity = {
        let sphere = ModelEntity(mesh: .generateSphere(radius: 0.1), materials: [SimpleMaterial(color: .green, isMetallic: false)])
        return sphere
    }()
    
    var body: some View {
        RealityView { content in
            subject.position.y = -0.4
            ManipulationComponent
                .configureEntity(subject, collisionShapes: [.generateBox(width: 0.25, height: 0.25, depth: 0.25)])
            
            content.add(subject)
        }
        .ornament(attachmentAnchor: .scene(.topBack), contentAlignment: .top, ornament: {
            VStack(alignment: .leading) {
                Button {
                    translateBehavior = translateBehavior == .unconstrained ? .none : .unconstrained
                    if var mc = subject.components[ManipulationComponent.self] {
                        mc.dynamics.translationBehavior = translateBehavior
                        subject.components.set(mc)
                    }
                } label: {
                    Text("Release Behavior")
                    Spacer()
                    Text("\(releaseBehavior == .reset ? "Reset" : "Stay")")
                }
                
                Button {
                    
                } label: {
                    Text("Translation Behavior")
                    Spacer()
                    Text("\(translateBehavior == .unconstrained ? "Unconstrained" :  "None")")
                }
            }
        })
    }
}

#Preview {
    Manipulation()
}
