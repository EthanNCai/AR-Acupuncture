
//
//  ARCore.swift
//  WWDC
//
//  Created by 蔡俊志 on 2023/4/5.
//

import Foundation
import SwiftUI
import ARKit
import SceneKit

final class ARViewController: UIViewController, ARSCNViewDelegate, ObservableObject
{
    var lighting: SCNLight = SCNLight()
    var lightNode = SCNNode()
    
    var targetAcusReference: [SCNReferenceNode] = []
    //load acupuncture model
    var targetAcusMatrix:[simd_float4x4] = []
    //load acupuncture position
    var contentNode: SCNNode? = nil
    var acupointsOnTheGo:[Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    //manage the current acupuncture display
    
    
    let sceneView = ARSCNView()
    //scene view of AR
    func preProcessNode()//set up arrays and waiting to go to the next stage
    {
        targetAcusReference.removeAll()
        targetAcusMatrix.removeAll()
        
        for item in fullacupoints//load acupuncture models from file
        {
            let targetFile:String = "ACU" + String(item.id)
            let newNode = SCNReferenceNode(named1: targetFile)
            targetAcusReference.append(newNode)
            targetAcusMatrix.append(item.matrix)
        }
        self.applyTransform() 
        
    }
    func applyTransform() // apply the spacial axis to the acupuncture scene references
    {
        for (index, value) in targetAcusReference.enumerated()
        {
            value.simdPivot = targetAcusMatrix[index]
        }
    }
    override func viewDidLoad(){
        super.viewDidLoad()
        sceneView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        let configuration = ARFaceTrackingConfiguration()
        //I choose face tracking configuration
        
        configuration.isLightEstimationEnabled = false
        sceneView.session.run(configuration)
        sceneView.automaticallyUpdatesLighting = false
        //we will manually setup the light later
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    
    //initiallize the AR 
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode?
    {
        
        lighting.type = .area
        lighting.castsShadow = true
        lighting.areaType = .polygon
        lighting.intensity = 4000
        //setup the light
        
        guard anchor is ARFaceAnchor else { return nil }
        let faceMesh = ARSCNFaceGeometry(device: sceneView.device!)
        contentNode = SCNNode(geometry: faceMesh)
        contentNode!.geometry?.firstMaterial?.transparency = .nan
        //hide the face mesh 
        
        self.preProcessNode()
        self.attach()
        return contentNode
    }
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor)
    {//updating AR scene
        if let faceAnchor = anchor as? ARFaceAnchor, let faceGeometry = node.geometry as? ARSCNFaceGeometry
        {
            
            lightNode.light = lighting
            let normal_ = simd_float4x4([[1, 0, 0, 0], [0, 1, 0, 0], [0, 0,1,0], [0, 0, 0.8, 1.0]])
            lightNode.simdTransform = normal_
            contentNode!.addChildNode(lightNode)
            // attach the light
            
            faceGeometry.update(from: faceAnchor.geometry)
            let faceStatu = analyseFace(anchor: faceAnchor)
            
            if faceStatu == 0 // pause the AR if your face is unstable
            {
                self.attach()
            }else
            {
                removeAllObj()
            }
        }
    }
    func add_acupoint(on id:Int) 
    {
        acupointsOnTheGo[id-1] = 1
        update_scene()
    }
    func remove_acupoint(on id:Int)
    {
        acupointsOnTheGo[id-1] = 0
        update_scene()
    }
    func update_scene()
    {
        removeAllObj()
        contentNode!.addChildNode(lightNode)
        attach()
    }
    func removeAllObj()
    {
        for childNodes in contentNode!.childNodes
        {
            childNodes.removeFromParentNode()
        }
    }
    func analyseFace(anchor: ARFaceAnchor) -> Int //return your face statue
    {
        let mouthSmileLeft = anchor.blendShapes[.mouthSmileLeft]
        let mouthSmileRight = anchor.blendShapes[.mouthSmileRight]
        let cheekPuff = anchor.blendShapes[.cheekPuff]
        let tongueOut = anchor.blendShapes[.tongueOut]
        let jawLeft = anchor.blendShapes[.jawLeft]
        let eyeSquintLeft = anchor.blendShapes[.eyeSquintLeft]
        let browDownLeft = anchor.blendShapes[.browDownLeft]
        let browDownRight = anchor.blendShapes[.browDownRight]
        let jawOpen = anchor.blendShapes[.jawOpen]
        let mouthPressLeft = anchor.blendShapes[.mouthPressLeft]
        let mouthPressRight = anchor.blendShapes[.mouthPressRight]
        let mouthStretchLeft = anchor.blendShapes[.mouthStretchLeft]
        let mouthStretchRight = anchor.blendShapes[.mouthStretchRight]
        if jawOpen == nil
        {
            return 1
        }
        else if tongueOut?.decimalValue ?? 0.0 > 0.6
        {
            return 3
        }
        else if ((mouthSmileLeft?.decimalValue ?? 0.0) + (mouthSmileRight?.decimalValue ?? 0.0)) > 0.8
        {
            return 2
        }
        else if cheekPuff?.decimalValue ?? 0.0 > 0.6
        {
            return 2
        }
        else if jawLeft?.decimalValue ?? 0.0 > 0.6
        {
            return 2
        }
        else if eyeSquintLeft?.decimalValue ?? 0.0 > 0.6
        {
            return 2
        }
        else if browDownLeft?.decimalValue ?? 0.0 > 0.6
        {
            return 2
        }
        else if browDownRight?.decimalValue ?? 0.0 > 0.6
        {
            return 2
        }
        else if jawOpen?.decimalValue ?? 0.0 > 0.6
        {
            return 2
        }
        else if mouthPressLeft?.decimalValue ?? 0.0 > 0.6
        {
            return 2
        }
        else if mouthPressRight?.decimalValue ?? 0.0 > 0.6
        {
            return 2
        }
        else if mouthStretchLeft?.decimalValue ?? 0.0 > 0.6
        {
            return 2
        }
        else if mouthStretchRight?.decimalValue ?? 0.0 > 0.6
        {
            return 2
        }
        else
        {
            return 0
        }
        
    }
    func attach()
    {
        let anchorNode = contentNode!
        for (index,AcuNode) in targetAcusReference.enumerated() // attach acupuncture models to AR scene according to the acupuncture manager array
        {
            if(acupointsOnTheGo[index] == 1)
            {
                anchorNode.addChildNode(AcuNode)
            }
        }
    }
}

struct ARView : UIViewRepresentable // to represent to UI
{
    
    var arView: ARViewController
    func makeUIView(context: Context) -> some UIView
    {
        arView.viewDidLoad()
        arView.viewWillAppear(true)
        return arView.sceneView
    }
    func updateUIView(_ uiView: UIViewType, context: Context)
    {
        
    }
}
extension SCNReferenceNode // set for load the model
{
    convenience init(named1 resourceName: String, loadImmediately: Bool = true)
    {
        let url = Bundle.main.url(forResource: resourceName, withExtension: "usdc")!
        self.init(url: url)!
        if loadImmediately
        {
            self.load()
        }
    }
    
}
