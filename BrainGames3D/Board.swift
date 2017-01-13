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
        var pieces:[Piece] = []
        var type:Int = 0                                 //Puede que en futuro haya q distinguir entre tipos de casillas
    }
    var board:[[Square?]] = []
    //var node:SCNNode
    
    init(map:[[Int]], squaresize:Float, squareheight:Float, color1:UIColor, color2:UIColor)
    {
        super.init()
        //node = SCNNode()
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
                square.node?.position.y = 0.0
                square.node?.position.x = Float(j) * squaresize
                square.node?.position.z = Float(i) * squaresize
                nodegeom.name = "(" + String(i) + "," + String(j) + ")"
                print(nodegeom.name! + String(((i + j) % 2 == 0)))
                nodegeom.geometry?.firstMaterial?.diffuse.contents = ( ((i + j) % 2 == 0) ? color1 : color2)
                square.node?.addChildNode(nodegeom)
                board[i].append(square)
                self.addChildNode(square.node!)
            }            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
