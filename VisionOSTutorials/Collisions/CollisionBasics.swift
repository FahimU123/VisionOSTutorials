//
//  CollisionBasics.swift
//  VisionOSTutorials
//
//  Created by Fahim Uddin on 10/3/25.
//

import RealityKit
import RealityKitContent
import SwiftUI

struct CollisionBasics: View {
    
    /// This grabs the scene you composed in RCP
    @Environment(\.realityKitScene) var scene
    
    @State var exampleInput = Entity()
    @State var collisionExampleEvent: EventSubscription?
    var body: some View {
        RealityView { content, attachments in
            
            guard let scene = try? await Entity(named: "CollisionUseCases", in: realityKitContentBundle) else { return }
            content.add(scene)
            scene.position.y = 0.4
            
            
            if let input = scene.findEntity(named: "ExampleInput"),
               let triggerSwitch = scene.findEntity(named: "ExampleTriggerSwitch"),
               let examplePhysics = scene.findEntity(named: "ExamplePhysics") {
                input.components.set(HoverEffectComponent())
                exampleInput = input
                
                // This could be an _ and it would trigger but holding in collisionExampleEvent keeps the subscription alive for later
                collisionExampleEvent = content
                    .subscribe(to: CollisionEvents.Began.self, on: triggerSwitch) { _ in
                        examplePhysics.setPosition([0.25, 1, 0], relativeTo: examplePhysics)
                    }
                
                if let label01 = attachments.entity(for: "Example01") {
                    label01.setPosition([0, 0.2, 0], relativeTo: input)
                    // This component makes it so the attachement/entity faces you in the Vision Pro
                    label01.components.set(BillboardComponent())
                    content.add(label01)
                }
                
                
                if let label02 = attachments.entity(for: "Example02") {
                    label02.setScale([0, ], relativeTo: triggerSwitch)
                    label02.components.set(BillboardComponent())
                    content.add(label02)
                }
                
                if let label03 = attachments.entity(for: "Example03") {
                    label03.setPosition([0.23, 0.3, 0], relativeTo: nil)
                    label03.components.set(BillboardComponent())
                    content.add(label03)
                }
            }
        } attachments: {
            Attachment(id: "Example01") {
                Text("Collision + Input")
                    .font(.title)
                    .padding()
                    .glassBackgroundEffect()
            
            }
            
            Attachment(id: "Example02") {
                Text("Collision trigger on action")
                    .font(.title)
                    .padding()
                    .glassBackgroundEffect()
            }
            
            Attachment(id: "Example03") {
                Text("Collision shapes are used for physics")
                    .font(.title)
                    .padding()
                    .glassBackgroundEffect()
            }
        }
    }
    
    var inputExample: some Gesture {
        TapGesture().targetedToEntity(exampleInput)
            .onEnded({ value in
                
                _ = value.entity.applyTapForBehaviors()
                
                // Link - https://developer.apple.com/forums/thread/756978
                // This is referring to the Behavior Component you added in RCP, and you chose onNotification
                NotificationCenter.default.post(
                    name: NSNotification.Name("RealityKit.NotificationTrigger"),
                    object: nil,
                    userInfo: [
                    "RealityKit.NotificationTrigger.Scene": scene as Any,
                    "RealityKit.NotificationTrigger.Identifier": "MoveTriggerToSwitch" // MoveTriggerToSwitch is the name you provided in RCP
                ])
            })
    }
}

#Preview {
    CollisionBasics()
}
