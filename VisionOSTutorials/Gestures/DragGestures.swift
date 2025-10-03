//
//  DragGestures.swift
//  VisionOSTutorials
//
//  Created by Fahim Uddin on 10/2/25.
//

import RealityKit
import RealityKitContent
import SwiftUI

struct DragGestures: View {
    @State fileprivate var subject: Entity = {
        let sphere = ModelEntity(
            mesh: .generateSphere(radius: 0.01),
            materials: [SimpleMaterial(color: .green, isMetallic: false)]
        )
        sphere.name = "Sphere"
        return sphere
    }()

    var body: some View {
        RealityView { content in
            guard let scene = try? await Entity(named: "Sphere") else { return }
            content.add(scene)
            
            }
        .modifier(DragGesturesImproved360())
        }
        
    }

#Preview {
    DragGestures()
}


struct DragGesturesImproved360: ViewModifier {
    @State var isDragging = false
    @State var intialPosition: SIMD3<Float> = .zero

    func body(content: Content) -> some View {
        content
            .gesture(
                DragGesture()
                    .targetedToAnyEntity()
                    .onChanged { value in
                        if !isDragging {
                            isDragging = true
                            intialPosition = value.entity.position
                        }
                        
                        let movement = value.convert(value.gestureValue.translation3D, from: .local, to: .scene)
                        
                        value.entity.position = intialPosition + movement
                    }
                
                    .onEnded { value in
                        isDragging = false
                        intialPosition = .zero
                        
                    }
            )
    }
}
