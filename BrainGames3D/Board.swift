//
//  Board.swift
//  BrainGames3D
//
//  Created by eicke on 12/1/17.
//  Copyright © 2017 eicke. All rights reserved.
//

import Foundation
import SceneKit



class Board
{
    struct Square  {
        var node:SCNNode? = nil
        var pieces:[Piece] = []
        var type:Int = 0                                 //Puede que en futuro haya q distinguir entre tipos de casillas
    }
    var board:[[Square?]] = []
    var node:SCNNode
    
    init(map:[[Int]], geometry:SCNGeometry)
    {
        node = SCNNode()
        let size_x = geometry.boundingBox.max.x - geometry.boundingBox.min.x
        let size_z = geometry.boundingBox.max.z - geometry.boundingBox.min.z
        for i in 0...map.count - 1
        {
            board.append([])
            for j in 0...map[i].count - 1
            {
                var square = Square()
                var nodegeom = SCNNode(geometry: geometry)
                square.node = SCNNode()
                square.node?.position.y = 0.0
                square.node?.position.x = Float(j) * size_x
                square.node?.position.z = Float(i) * size_z
                nodegeom.name = "(" + String(i) + "," + String(j) + ")"
                print(nodegeom.name! + String(((i + j) % 2 == 0)))
                nodegeom.geometry?.firstMaterial?.diffuse.contents = ( ((i + j) % 2 == 0) ? UIColor.blue : UIColor.green)
                square.node?.addChildNode(nodegeom)
                board[i].append(square)
                self.node.addChildNode(square.node!)
            }            
        //self.node.geometry?.firstMaterial?.diffuse.contents =  UIColor.brown
        }
    
        
    }
    
}
