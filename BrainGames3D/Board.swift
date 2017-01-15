//
//  Board.swift
//  BrainGames3D
//
//  Created by eicke on 12/1/17.
//  Copyright © 2017 eicke. All rights reserved.
//

import Foundation
import SceneKit



class Board: SCNNode
{
    struct Square  {
        var node:SCNNode? = nil
        var type:Int = 0                                 //Puede que en futuro haya q distinguir entre tipos de casillas
    }
    var pieces_node = SCNNode()
    var board:[[Square?]] = []
    var pieces_on_board:[Piece:(x:Int, y:Int)] = [:]
    var board_node = SCNNode()
    var size:Float = 0
    
    init(map:[[Int]], squaresize:Float, squareheight:Float, color1:UIColor, color2:UIColor, piece_height:Float)
    {
        super.init()
        self.size = squaresize
        self.castsShadow = true
        for i in 0...map.count - 1
        {
            board.append([])
            for j in 0...map[i].count - 1
            {
                if(map[i][j] == 0)
                {
                    continue
                }
                var square = Square()
                let nodegeom = SCNNode(geometry: SCNBox(width: CGFloat(squaresize), height: CGFloat(squareheight), length: CGFloat(squaresize), chamferRadius: 0.0))
                square.node = SCNNode()
                square.node?.castsShadow = true
                square.node?.position.y = 0.0
                square.node?.position.x = Float(j) * squaresize
                square.node?.position.z = Float(i) * squaresize
                square.node?.name = "(" + String(i) + "," + String(j) + ")"
                nodegeom.name = "(" + String(i) + "," + String(j) + ")"
                print(nodegeom.name! + String(((i + j) % 2 == 0)))
                nodegeom.geometry?.firstMaterial?.diffuse.contents = ( ((i + j) % 2 == 0) ? color1 : color2)
                square.node?.addChildNode(nodegeom)
                board[i].append(square)
                self.board_node.addChildNode(square.node!)
                //self.s_node.position.y += squaresize
            }            
        }
        self.board_node.position.y -= piece_height + squareheight + squareheight * 0.01
        self.addChildNode(self.board_node)
        self.addChildNode(self.pieces_node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getSquarePosition(node:SCNNode) -> (x:Int,y:Int)?
    {
        for i in 0...self.board.count - 1
        {
            for j in 0...self.board[i].count - 1
            {
                if((self.board[i][j]?.node?.name)! == node.name!)
                {
                    return (x:i, y:j)
                }
            }
        }
        return nil
    }
    /*
    func createBorder() -> SCNNode
    {
        //let limits = self.board_node.boundingBox
        
    
    }*/
    
    func placePiece(piece:Piece, position:(x:Int, y:Int))
    {
        let np = piece//Piece.init(piece: piece)
        self.pieces_on_board[np] = position
        np.node.position.x = (self.board[position.x][position.y]?.node?.position.x)!
        np.node.position.z = (self.board[position.x][position.y]?.node?.position.z)!
        self.pieces_node.addChildNode(np.node)
    }
    
}
