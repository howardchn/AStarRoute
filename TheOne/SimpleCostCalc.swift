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
    public func getCostG (currentNode : AStarNode, direction : Direction) -> Int32 {
        var cost : Int32 = 0
        switch direction {
        case .East, .North, .South, .West:
            cost += Int32(10)
        case .NorthEast, .NorthWest, .SouthEast, .SouthWest:
            cost += Int32(14)
        default:
            cost += Int32(0)
        }
        
        if(currentNode.previousNode != nil) {
            cost += Int32(currentNode.previousNode!.costG.value)
        }
        
        return cost
    }
    
    public func getCostH (nextNode : CGPoint, destination : CGPoint) -> Int32 {
        return Int32.max
    }
}
