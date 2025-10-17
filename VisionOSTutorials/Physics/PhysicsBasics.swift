//
//  PhysicsBasic.swift
//  VisionOSTutorials
//
//  Created by Fahim Uddin on 10/9/25.
//

import RealityKit
import RealityKitContent
import SwiftUI

struct PhysicsBasics: View {
    @State var subject: Entity = {
        let box = ModelEntity(
            mesh: .generateBox(size: 12), materials: [SimpleMaterial(color: .red, isMetallic: false)]
        )
        return box
    }()
    var body: some View {
        RealityView { content in
            let subject = subject
            subject.position.y = -0.4
            content.add(subject)
        }
        .toolbar {
            ToolbarItem(placement: .bottomOrnament, content: {
                HStack {
                    Text("Restitution")
                    Button {
                        updatePhysics(restitution: 0.0)
                    } label: {
                        Text("0.0")
                    }
                    
                    Button {
                        updatePhysics(restitution: 0.3)
                    } label: {
                        Text("0.3")
                    }
                    
                    Button {
                        updatePhysics(restitution: 0.7)
                    } label: {
                        Text("0.7")
                    }
                }
            })
        }
    }
    
    func updatePhysics(restitution: Float) {
        let physicsBody = PhysicsBodyComponent(
            massProperties: .default,
            material: .generate(staticFriction: 0.0, dynamicFriction: 0.0, restitution: restitution),
            mode: .dynamic
        )
        
        let phsyicsMotionComponent = PhysicsMotionComponent()
        subject.components.set([physicsBody, phsyicsMotionComponent])
        subject.position.y = 0.8
    }
}

#Preview {
    PhysicsBasics()
}
