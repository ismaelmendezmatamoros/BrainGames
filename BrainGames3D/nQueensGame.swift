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
    var impossibleSquares:[Piece:[(x:Int, y:Int)]] = [:]
    var numQueens = 0
    let piece_name = "Queen"
    var board:Board?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.numplayers = 1
    }
    
    override func setupGame()
    {
        self.numQueens = self.parameters["numQueens"] as! Int
    }

    override func setupScene()
    {
        let map = Array.init(repeating: Array.init(repeating: 1, count: self.numQueens), count: self.numQueens)
        self.pieces = self.loadModelsFromFile(filename: "chesspieces.dae", names: [piece_name])
        let size = (self.pieces[piece_name]?.node.boundingBox.max.x)! - (self.pieces[piece_name]?.node.boundingBox.min.x)! //+ (self.pieces[piece_name]?.node.boundingBox.min.x)! * 0.01
        self.board = Board.init(map: map, squaresize: Float(size), squareheight: size * 0.2 , color1: UIColor.darkGray, color2: UIColor.black, piece_height: (pieces[piece_name]?.node.boundingBox.max.y)!)
        //////////
        self.pieces[piece_name] = Queen(piece: pieces[piece_name]!)
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
        self.board?.position.y = (pieces[piece_name]?.node.boundingBox.min.y)! - (board?.boundingBox.max.y)!
    }
    
    
    
    
    func placePiece(piece:Piece, position:(x:Int, y:Int))
    {
        self.board?.placePiece(piece: piece, position: position)
        let possibles = piece.possiblesMovements(board: board!, position: position)
        self.impossibleSquares[piece] = possibles
    }

    override func turnsEnd(player: Int) {
        
        self.impossibleSquares.removeAll()
        for i in (self.board?.pieces_on_board.keys)!
        {
        self.impossibleSquares[i] = i.possiblesMovements(board: self.board!, position: (self.board?.pieces_on_board[i])!)
        }
        super.turnsEnd(player: player)
    }

    override func beforeTurnStarts(player: Int) -> Bool {
        for i in self.impossibleSquares.values
        {
            for pos in i {
            self.highLightModel(model: (self.board?.board[pos.x][pos.y]?.node)! , color: UIColor.blue, duration: 1.0)
        
            }
        }
     
        return super.beforeTurnStarts(player: player)
    }
 
    override func handleTouchOnTurn(_ gestureRecognize: UIGestureRecognizer)
    {
        let touched = self.getTouchedElements(gestureRecognize)
        if touched.count > 0
        {
            let position = self.board?.getSquarePosition(node: (touched.first?.node)!)
            print(String(describing: position))
            if(position == nil)
            {
                return
            }
            self.placePiece(piece: Queen.init(piece: pieces[piece_name]!), position: position!)
            self.finalizeTurn()
        }
    }
    

}
