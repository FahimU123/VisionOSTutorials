//
//  CustomSoundsWithManipualtionComponent.swift
//  VisionOSTutorials
//
//  Created by Fahim Uddin on 10/3/25.
//

import RealityKit
import SwiftUI

// ManipulationComponent comes with default sounds, this how you make custom sounds
struct CustomSoundsWithManipualtionComponent: View {
    @State fileprivate var subject: Entity = {
        let box = ModelEntity(
            mesh: .generateSphere(radius: 0.01),
            materials: [SimpleMaterial(color: .green, roughness: 0.01, isMetallic: true)]
        )
        return box
    }()
    
    // Step 1: Load audio files
    static let drop001Audio = try! AudioFileResource.load(named: "drop_001")
    
    static let drop002Audio = try! AudioFileResource.load(named: "drop_002")
    
    var body: some View {
        RealityView { content in
            // this is a vital step to play any sound at all, default or custom so do it always
            let audioComponent = AmbientAudioComponent()
            subject.components.set(audioComponent)
            
            
            // .configureEntity is a quick utility to make an Entity have colliosn, inout target and manipualtion components all in one, YURT
            ManipulationComponent
                .configureEntity(
                    subject,
                    hoverEffect: .spotlight(.default),
                    collisionShapes: [.generateBox(width: 0.25, height: 0.25, depth: 0.25)]
                    )
            
            
            // this is to specifcally get rid of deafult sounds
            var mc = ManipulationComponent()
            mc.audioConfiguration = .none
            
            
            // play a sound when we start the gesture
            _ = content.subscribe(to: ManipulationEvents.WillRelease.self) { event in
                event.entity.playAudio(CustomSoundsWithManipualtionComponent.drop001Audio)
            }
            
            // play a sound when we release the gesture
            _ = content.subscribe(to: ManipulationEvents.WillRelease.self) { event in
                event.entity.playAudio(CustomSoundsWithManipualtionComponent.drop002Audio)
            }
            
            // setting the manipualtion component because otherwise how will it know the properties we changed
            subject.components.set(mc)
            content.add(subject)
            
        }
    }
}

#Preview {
    CustomSoundsWithManipualtionComponent()
}

