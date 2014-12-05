//
//  File.swift
//  TheOne
//
//  Created by Howard on 12/4/14.
//  Copyright (c) 2014 Howard. All rights reserved.
//

import Foundation
import SpriteKit

public extension CGPoint {
    public func getAdjecentPoint (direction : Direction) -> CGPoint {
        var x = self.x
        var y = self.y
        
        switch direction {
        case .East:
            x += 1
        case .North:
            y -= 1
        case .West:
            x -= 1
        case .South:
                y += 1
        case .NorthEast:
            x += 1
            y -= 1
        case .NorthWest:
            x -= 1
            y -= 1
        case .SouthEast:
            x += 1
            y += 1
        case .SouthWest:
            x -= 1
            y += 1
        default: NSLog("Unsupported direction.")
        }
        
        return CGPoint(x: x, y: y)
    }
}