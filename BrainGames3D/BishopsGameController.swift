//
//  BishopsGameController.swift
//  BrainGames3D
//
//  Created by eicke on 16/1/17.
//  Copyright © 2017 eicke. All rights reserved.
//

import Foundation
import SceneKit

class BishopsGame: BoardGameViewController
{

    var impossibleSquares:[Piece:[(x:Int, y:Int)]] = [:]
    var imposibleSquaresArray:[(x:Int, y:Int)] = []
    let piece_name = "Bishop"
    var lightNode:SCNNode = SCNNode()
    
    
    override func setupScene()
    {
        self.scene.background.contents = UIColor.black
        let map = Array.init(repeating: Array.init(repeating: 1, count: 5), count: 4)
        self.pieces = self.loadModelsFromFile(filename: "Piecescollada-3.dae", names: [piece_name], color:UIColor.red)
        let size = (self.pieces[piece_name]?.node.boundingBox.max.x)! - (self.pieces[piece_name]?.node.boundingBox.min.x)!
        self.board = Board.init(map: map, squaresize: Float(size), squareheight: size * 0.2 , color1: UIColor.darkGray, color2: UIColor.black, piece_height: (pieces[piece_name]?.node.boundingBox.max.y)!)
        //////////
        self.pieces[piece_name] = Queen(piece: pieces[piece_name]!)
        //let lightNode = SCNNode()
        lightNode.light = SCNLight()
        
        
        lightNode.light?.type = .omni
        lightNode.light?.spotInnerAngle = 75;
        lightNode.light?.spotOuterAngle = 75;
        lightNode.light?.shadowRadius = 100.0;
        lightNode.light?.intensity = 1500
        lightNode.light?.zFar = 10000;
        lightNode.light?.castsShadow = true
        lightNode.position.x = (self.board?.boundingBox.max.x)! / 2
        lightNode.position.z = (self.board?.boundingBox.max.z)! * 1 // 2
        lightNode.position.y = size * 2.5
        //lightNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 10, y: 0, z: 3.5, duration: 2)))
        self.scene.rootNode.castsShadow = true
        //self.board?.addChildNode(lightNode)
        //lightNode.addChildNode(self.board!)
        let constraint = SCNLookAtConstraint(target: self.board)
        lightNode.constraints = [constraint]
        //self.scene.rootNode.addChildNode(lightNode)
        
        
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        //////////
        
        //let floor = SCNNode(geometry: SCNPlane(width: CGFloat(size * 50) , height: CGFloat(size * 50)))
        //self.board?.addChildNode(floor)
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        //scene.rootNode.addChildNode(cameraNode)
        
        
        //self.scene.rootNode.runAction(SCNAction.rotateBy(x: 0.40, y: 0.0, z: 0, duration: 1))
        //cameraNode.addChildNode(self.board!)
        self.scene.rootNode.addChildNode(board!)
        self.board?.addChildNode(lightNode)
        self.board?.position.y = (pieces[piece_name]?.node.boundingBox.min.y)! - (board?.boundingBox.max.y)!
        super.setupScene()
    }
}
