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
    let piece_name = "Queen"
    var board:Board?
    var pieces:[String:SCNNode] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.numplayers = 1
    }
    
    override func setupGame() {
        
        let map = Array.init(repeating: Array.init(repeating: 1, count: 8), count: 8)
        self.pieces = self.loadModelsFromFile(filename: "chesspieces.dae", names: [piece_name])
        let size = (self.pieces[piece_name]?.boundingBox.max.x)! - (self.pieces[piece_name]?.boundingBox.min.x)!
        self.board = Board.init(map: map, squaresize: Float(size), squareheight: size * 0.2 , color1: UIColor.darkGray, color2: UIColor.black)
        self.scene.rootNode.addChildNode(board!)
    }
    

}
