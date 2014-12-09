//
//  SimpleCostCalc.swift
//  TheOne
//
//  Created by Howard on 12/5/14.
//  Copyright (c) 2014 Howard. All rights reserved.
//

import Foundation
import SpriteKit

public class SimpleCostCalc : CostCalcProtocal {
    public func getCostG (currentNode : AStarNode, direction : Direction) -> Int {
        var cost : Int = 0
        switch direction {
        case .East, .North, .South, .West:
            cost += 10
        case .NorthEast, .NorthWest, .SouthEast, .SouthWest:
            cost += 14
        default:
            cost += 0
        }
        
        if(currentNode.previousNode != nil) {
            cost += Int(currentNode.previousNode!.costG.value)
        }
        
        return cost
    }
    
    public func getCostH (nextNode : PointInt, destination : PointInt) -> Int {
        return abs(nextNode.x - destination.x) + abs(nextNode.y - destination.y)
    }
}
