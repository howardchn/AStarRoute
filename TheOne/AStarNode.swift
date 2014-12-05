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
    
    init(location : CGPoint, previousNode : AStarNode?, costG : Int32, costH : Int32) {
        self.location = location
        self.previousNode = previousNode
        self.costG = costG
        self.costH = costH
    }
    
    var location : CGPoint
    var previousNode : AStarNode?
    var costG : Int32
    var costH : Int32
    var costF : Int32 {
        get {
            return costG + costH
        }
    }
}
