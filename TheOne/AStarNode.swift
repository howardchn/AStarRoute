//
//  File.swift
//  TheOne
//
//  Created by Howard on 12/4/14.
//  Copyright (c) 2014 Howard. All rights reserved.
//

import Foundation
import SpriteKit

public class AStarNode {
    
    init(location : PointInt, previousNode : AStarNode?, costG : Int, costH : Int) {
        self.location = location
        self.previousNode = previousNode
        self.costG = costG
        self.costH = costH
    }
    
    var location : PointInt
    var previousNode : AStarNode?
    var costG : Int
    var costH : Int
    var costF : Int {
        get {
            return costG + costH
        }
    }
}
