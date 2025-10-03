//
//  TapGestures.swift
//  VisionOSTutorials
//
//  Created by Fahim Uddin on 10/2/25.
//

import RealityKit
import RealityKitContent
import SwiftUI

// Best for when you want to just toggel and perform actions from buttons, refer to Spatial Tap Gesture if you want 3D coordinates of where user tapped
struct TapGestures: View {
    @State var selected: Entity? = nil
    var body: some View {
        RealityView { content in
            guard let scene = try? await Entity(named: "ToyCar", in: realityKitContentBundle) else { return }
            content.add(scene)
            
            scene.position.y = -0.4
        }
        .gesture(tapExample)
    }
    
    var tapExample: some Gesture {
        // the count parameter dictates how many times user needs to tap to trigger the event, obviously leaving this blank will be 0
        TapGesture(count: 2)
            .targetedToAnyEntity()
            .onEnded { value in
                if selected == value.entity {
                    selected?.position.y = 0
                    selected = nil
                } else {
                    selected?.position.y = 0
                    
                    value.entity.position.y = 0.1
                    selected = value.entity
                }
            }
    }
}

#Preview {
    TapGestures()
}
