//
//  Piece.swift
//  BrainGames3D
//
//  Created by eicke on 12/1/17.
//  Copyright © 2017 eicke. All rights reserved.
//

import Foundation
import SceneKit

protocol Piece 
{
    var team:Int        {get set}
    //var node:SCNNode    {get set}
    func possiblesMovements(board:Board) -> [(Int,Int)]
}
