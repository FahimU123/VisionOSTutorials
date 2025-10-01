//
//  Attachments.swift
//  VisionOSTutorials
//
//  Created by Fahim Uddin on 10/1/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct Attachments: View {
    var body: some View {
        RealityView { content, attachments in
            
            if let scene = try? await Entity(named: "RKBasicsLoading", in: realityKitContentBundle) {
                content.add(scene)
                // position doesnt let you choose a refernce point and just adjusts to the world
                // so here RealityView is the top level parent so its being postioned to the RelaityView
                scene.position.y = 0.4
                
                if let earth = scene.findEntity(named: "Earth"), let moon = scene.findEntity(named: "Moon") {
                    if let earthPanel = attachments.entity(for: "EarthPanel") {
                        earth.addChild(earthPanel, preservingWorldTransform: true)
                        // place the earthPanel a little below the center of earth and a little in fornt of it
                        earthPanel.setPosition([0, -0.1, 0.1], relativeTo: earth)
                    }
                    
                    // Step 2: Capture the attachment, make a copy and set its postion relative to any 3D model
                    if let moonPanel = attachments.entity(for: "MoonPanel") {
                        // setting preservingWorldTransform to true make sures the childs size and position in the beginning remains same but obviously position changes when the parent moves
                        moon.addChild(moonPanel, preservingWorldTransform: true)
                        moonPanel.setPosition([0, -0.05], relativeTo: moon)
                    }
                    
                    if let titlePanel = attachments.entity(for: "TitlePanel") {
                        content.add(titlePanel)
                        titlePanel.setPosition([0, 0.2, -0.2], relativeTo: nil)
                    }
                }
            }
            
        } update: { content, attachments in
            
        } attachments: {
            // Step 1: You gotta declare an attachment like ths and give it an ID
            Attachment(id: "EarthPanel") {
                HStack {
                    Image(systemName: "globe.europe.africa")
                    Text("Earth")
                        .font(.headline)
                }
                .padding()
                .glassBackgroundEffect()
            }
            
            Attachment(id: "TitlePanel") {
                VStack {
                    Text("Earth & Moon")
                        .font(.largeTitle)
                    
                    Text("Best of friends for 4.53 billion years")
                        .font(.caption)
                }
                .padding()
                .glassBackgroundEffect(in: .rect(cornerRadius: 24))
            }
        }
    }
}

#Preview {
    Attachments()
}
