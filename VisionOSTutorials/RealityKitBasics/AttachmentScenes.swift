//
//  AttachmentScenes.swift
//  VisionOSTutorials
//
//  Created by Fahim Uddin on 10/2/25.
//

import RealityKit
import SwiftUI
import RealityKitContent

struct AttachmentScenes: View {
    var body: some View {
        RealityView { content, attachment in
            // This loads all the 3D assets
            guard let scene = try? await Entity(named: "Caution", in: realityKitContentBundle) else { return }
            content.add(scene)
            
            // Example 01
            // We search for the specific entity and attachment, get a refernce to it then link them by having the attachment be a child
            // Now they move, rotate and even scale in unison
            if let wetFloorSIgn = scene.findEntity(named: "wet_floor_sign"),
               let wetFloorAttachment = attachment.entity(for: "wet_floor_attachment") {
                wetFloorSIgn.addChild(wetFloorAttachment)
                
                // Transform is a super comprehensive way to set poistion, it handles scale, rotation, and trasnlation which is basically position as you xan see
                let transform = Transform(scale: .init(repeating: 200), rotation: simd_quatf(Rotation3D(angle: Angle2D(degrees: 11), axis: RotationAxis3D(x: -1, y: 0, z: 0))), translation: [0, 30, 6.7])
                
                wetFloorAttachment.transform = transform
            }
            
            
            // Exmaple 02
            // Here just get refernces but add teh attachment to the scene itself and only use the entity to reference to positio the attachment
            if let trafficCone = scene.findEntity(named: "traffic_cone_02"),
               let trafficConeAttachment = attachment.entity(for: "traffic_cone_attachment") {
                content.add(trafficConeAttachment)
                
                let transform = Transform(
                    scale: .init(repeating: 1.0),
                    rotation: simd_quatf(
                        Rotation3D(angle: Angle2D(degrees: -24), axis: RotationAxis3D(x: 0, y: 1, z: 0))
                    ),
                    translation: trafficCone.position + [0, 0.8, 0]
                )
                
                trafficConeAttachment.transform = transform
            }
            
            // Example 03
            // This just if you want some SwiftUI view in your RealityView
            if let warningSign = attachment.entity(for: "warning_sign") {
                warningSign.position = [1, 1.2, -2]
                content.add(warningSign)
            }
            
            
            
            
        } update: { content, attachments  in
            
        } attachments: {
            Attachment(id: "wet_floor_attachment") {
                VStack(spacing: 24) {
                    Text("CAUTION")
                        .font(.largeTitle)
                }
            }
            Attachment(id: "traffic_cone_attachment") {
                VStack(spacing: 24) {
                    Text("Watch Out")
                        .font(.largeTitle)
                }
            }
            Attachment(id: "warning_sign") {
                VStack(spacing: 24) {
                    Text("This scene contains gratious warnings")
                        .font(.system(size: 96, weight: .bold))
                        .textCase(.uppercase)
                        .multilineTextAlignment(.center)
                }
            }
            
        }
 
    }
}

#Preview {
    AttachmentScenes()
}
