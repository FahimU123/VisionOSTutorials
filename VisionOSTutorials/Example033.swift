//
//  Example033.swift
//  VisionOSTutorials
//
//  Created by Fahim Uddin on 9/29/25.
//

import SwiftUI

struct Example033: View {
    @State fileprivate var transformMode: TransformType = .none
    var body: some View {
        HStack() {
            List {
                Section("Transform Mode") {
                    ForEach(TransformType.allCases, id:\.self) { transformType in
                        Button(transformType.rawValue) {
                            // self is optional here since there is no ambbiguit, the captured value in the closures name is diffent then our transformMode variable. If however they were the same names then self is necessary
                            self.transformMode = transformType
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            
            ZStack {
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(.thickMaterial)
                    .frame(width: 200, height: 200)
                
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundStyle(.red)
                    .frame(width: 200, height: 200)
                    .modifier(ExploringTransform3DEffect(mode: $transformMode))
            }
            .frame(maxWidth: .infinity)
        }
        .padding(EdgeInsets(top: 24, leading: 12, bottom: 12, trailing: 12))
    }
}

#Preview {
    Example033()
}


fileprivate enum TransformType: String, CaseIterable {
    case none = "None"
    case translate = "Translate"
    case rotate = "Rotate"
    case scale = "Scale"
    case combine = "Scale+Rotate+Translate"
}


fileprivate struct ExploringTransform3DEffect: ViewModifier {
    @Binding var mode: TransformType
    
    func body(content: Content) -> some View {
        switch mode {
        case .none:
            content
    
            // Changes the position of a view in x y and z
        case .translate:
            content
                .transform3DEffect(AffineTransform3D(translation: Vector3D(x: 25, y: 25, z: 50)))
            
            // Rotates the degrees on any specifed axis
        case .rotate:
            content
                .transform3DEffect(AffineTransform3D(rotation: Rotation3D(angle: Angle2D(degrees: 20), axis: .x)))
        
            // Transforms size in 3 dimensions
        case .scale:
            content
            // This modifier makes adjustments to views on 3 dimensions hence the 3D
                .transform3DEffect(AffineTransform3D(scale: Size3D(vector: [0.5, 0.5, 0.5])))


        case .combine:
            content
                .transform3DEffect(AffineTransform3D(
                    scale: Size3D(vector: [0.5, 0.5, 0.5]),
                    rotation: Rotation3D(angle: Angle2D(degrees: 20), axis: .x),
                    translation: Vector3D(x: 25, y: 25, z: 50)
                ))
        }
    }
}
