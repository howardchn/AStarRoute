//
//  RectInt.swift
//  TheOne
//
//  Created by Howard on 12/8/14.
//  Copyright (c) 2014 Howard. All rights reserved.
//

import Foundation

public struct RectInt {
    public var x : Int!
    public var y : Int!
    public var width : Int!
    public var height : Int!
    
    init(x : Int, y : Int, width : Int, height : Int) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
    
    public func contains (p : PointInt) -> Bool {
        return (p.x >= x && p.x < x + width && p.y >= y && p.y < y + height)
    }
}

public struct PointInt : Equatable {
    public var x : Int
    public var y : Int
    
    init (x:Int, y:Int) {
        self.x = x
        self.y = y
    }
    
    public func getAdjecentPoint (direction : Direction) -> PointInt {
        var newX = self.x
        var newY = self.y
        
        switch direction {
        case .East:
            newX += 1
        case .North:
            newY -= 1
        case .West:
            newX -= 1
        case .South:
            newY += 1
        case .NorthEast:
            newX += 1
            newY -= 1
        case .NorthWest:
            newX -= 1
            newY -= 1
        case .SouthEast:
            newX += 1
            newY += 1
        case .SouthWest:
            newX -= 1
            newY += 1
        default: NSLog("Unsupported direction.")
        }
        
        return PointInt(x: newX, y: newY)
    }
}

public func == (a: PointInt, b: PointInt) -> Bool {
    return a.x == b.x && a.y == b.y
}
