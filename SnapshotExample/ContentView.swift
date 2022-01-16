//
//  ContentView.swift
//  SnapshotExample
//
//  Created by Sergio Ortiz on 16.01.22.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        ZStack(alignment: .bottom){
            ARViewContainer().edgesIgnoringSafeArea(.all)
            
            Button {
                // Placeholder: take a snapshot
                ARVariables.arView.snapshot(saveToHDR: false) { (image) in
                    // Compress the image
                    let compressedImage = UIImage(
                        data: (image?.pngData())!)
                    // Save in the photo album
                    UIImageWriteToSavedPhotosAlbum(
                        compressedImage!, nil, nil, nil)
                }
                
            } label: {
                Image(systemName: "camera")
                    .frame(width:60, height:60)
                    .font(.title)
                    .background(.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding()
            }
        }
    }
}

struct ARVariables{
    static var arView: ARView!
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        ARVariables.arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        ARVariables.arView.scene.anchors.append(boxAnchor)
        
        return ARVariables.arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
