//
//  RealityViews.swift
//  VisionOSTutorials
//
//  Created by Fahim Uddin on 9/30/25.
//

import RealityKit
import SwiftUI

// Why cannot I not see the toggle?
struct RealityViews: View {
    @State var isTransparent = false
    var body: some View {
        RealityView { content, attachments in
            
            // adding a delay so we can actually see the placeholder view
            try? await Task.sleep(for: .seconds(2))
            
            let subjectEntity = Entity()
            subjectEntity.name = "Subject"
            
            var mat = PhysicallyBasedMaterial()
            mat.baseColor.tint = .red
            mat.roughness = 0.5
            mat.metallic = 0.0
            
            let shape = MeshResource.generateSphere(radius: 0.2)
            let model = ModelComponent(mesh: shape, materials: [mat])
            subjectEntity.components.set(model)
            subjectEntity.components.set(HoverEffectComponent())
            subjectEntity.components.set(InputTargetComponent())
            subjectEntity.components.set(OpacityComponent(opacity: 1.0))
            // Enabling the CollsionComponent allows it to collide with other entities who also have collsion enabled
            subjectEntity.components.set(CollisionComponent(shapes: [ShapeResource.generateSphere(radius: 0.2)]))
            content.add(subjectEntity)
            
            mat.baseColor.tint = .blue
            let sphere = ModelEntity(
                mesh: .generateSphere(radius: 0.03),
                materials: [mat])
            sphere.setPosition([-0.25, 0.2, 0.1], relativeTo: subjectEntity)
            subjectEntity.addChild(sphere)
            
            
            // Step 2: Access the entity to load it and set its psoition
            if let subjectPanel = attachments.entity(for: "subjectPanel") {
                subjectPanel.setPosition([0, 0.3, 0], relativeTo: subjectEntity)
                content.add(subjectPanel)
            }
        } update: { content, attachments in
            // This runs everytime isTransparent value changes, first it look for the specific entity and then applies changes based on isTranspernets value, YURT
            if let subject = content.entities.first(where: { $0.name == "Subject" }) {
                subject.components.set(OpacityComponent(opacity: isTransparent ? 0.5 : 1.0))
            }
        } placeholder: {
            VStack {
                Text("Loading")
                    .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                ProgressView()
            }
            .font(.largeTitle)
            .padding()
            .glassBackgroundEffect()
        } attachments: {
            // Attachments are way to have 2D swiftUI views alongide 3D RealityViews
            // Step 1: give it a id name and then define the view
            Attachment(id: "subjectPanel", {
                VStack {
                    HStack {
                        Image(systemName: "circle.fill")
                        Text("Subject")
                    }
                    .font(.largeTitle)
                    Toggle(isOn: $isTransparent, label: {
                        Text("Opacity")
                    })
                    .toggleStyle(.button)
                }
                .padding()
                .glassBackgroundEffect()
            })
        }
    }
}

#Preview {
    RealityViews()
}


