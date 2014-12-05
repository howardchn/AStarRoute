//
//  CostCalcProtocal.swift
//  TheOne
//
//  Created by Howard on 12/5/14.
//  Copyright (c) 2014 Howard. All rights reserved.
//

import Foundation
import SpriteKit

public protocol CostCalcProtocal {
    func getCostG (currentNode : AStarNode, direction : Direction) -> Int32
    func getCostH (nextNode : CGPoint, destination : CGPoint) -> Int32
}
