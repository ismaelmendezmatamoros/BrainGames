//
//  Piece.swift
//  BrainGames3D
//
//  Created by eicke on 12/1/17.
//  Copyright © 2017 eicke. All rights reserved.
//

import Foundation
import SceneKit

class Piece: NSObject
{
    var node: SCNNode = SCNNode()
    var team:Int = 0
    
    
    
    override init()
    {
        self.node.castsShadow = true
        let lambda =
            { (a:SCNNode, b:UnsafeMutablePointer<ObjCBool>) in
                a.castsShadow = true
                a.castsShadow = true
                a.geometry?.firstMaterial?.isLitPerPixel = true
                a.geometry?.firstMaterial?.specular.contents = UIColor.red
                 
                
        }
        self.node.enumerateChildNodes(lambda)
    }
    
    func setName(name:String)
    {
        let lambda =
            { (a:SCNNode, b:UnsafeMutablePointer<ObjCBool>) in
                a.name = a.name! + "-" + name
        }
        self.node.enumerateChildNodes(lambda)
    }
    
    
    init(piece:Piece)
    {
        self.node = piece.node.clone()
        self.team = piece.team
        self.node.castsShadow = true
        let lambda =
            { (a:SCNNode, b:UnsafeMutablePointer<ObjCBool>) in
                a.castsShadow = true
        }
        self.node.enumerateChildNodes(lambda)
        
    }
    /*
    var hashValue: Int {
            return node.hashValue ^ team.hashValue
    }
    
    static func == (lhs: Piece, rhs: Piece) -> Bool {
            return lhs.node == rhs.node && lhs.team == rhs.team
    }

*/
    func possiblesMovements(board:Board, position:(x:Int,y:Int)) -> [(x:Int,y:Int)]
    {
        return []
    }

}
