//
//  nQueensGame.swift
//  BrainGames3D
//
//  Created by eicke on 12/1/17.
//  Copyright © 2017 eicke. All rights reserved.
//

import Foundation
import SceneKit

class nQueensGame: BoardGameViewController
{
    let piece_name = "Knight"
    var board:Board?
    var pieces:[String:SCNNode] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.numplayers = 1
    }
    
    override func setupGame() {
        
        let map = Array.init(repeating: Array.init(repeating: 1, count: 8), count: 8)
        self.pieces = self.loadModelsFromFile(filename: "chesspieces.dae", names: [piece_name])
        let size = (self.pieces[piece_name]?.boundingBox.max.x)! - (self.pieces[piece_name]?.boundingBox.min.x)! + (self.pieces[piece_name]?.boundingBox.min.x)! * 0.01
        self.board = Board.init(map: map, squaresize: Float(size), squareheight: size * 0.2 , color1: UIColor.darkGray, color2: UIColor.black)
        }
    
    override func setupScene()
    {
        //////////
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        //////////
        
        self.scene.rootNode.addChildNode(board!)
        self.board?.position.y = (pieces[piece_name]?.boundingBox.min.y)! - (board?.boundingBox.max.y)!
    }
    
    override func handleTouchOnTurn(_ gestureRecognize: UIGestureRecognizer) {
        //self.board?.board[0][3]?.pieces.append(pieces["Queen"] as! Piece)
        self.board?.addChildNode(pieces[piece_name]!)
        pieces[piece_name]?.position = (self.board?.board[2][5]?.node?.position)!
        self.scene.rootNode.addChildNode(pieces[piece_name]!)
        self.finalizeTurn()
    }
    

}
