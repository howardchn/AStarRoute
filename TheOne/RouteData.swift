//
//  RouteData.swift
//  TheOne
//
//  Created by Howard on 12/4/14.
//  Copyright (c) 2014 Howard. All rights reserved.
//

import Foundation
import SpriteKit

public class RouteData {
    init (rect : RectInt, destination : PointInt) {
        self.rect = rect
        self.destination = destination
        self.openedNodes = [AStarNode]()
        self.closedNodes = [AStarNode]()
        self.directions = [Direction]()
        self.directions.append(Direction.North)
        self.directions.append(Direction.East)
        self.directions.append(Direction.South)
        self.directions.append(Direction.West)
        self.directions.append(Direction.NorthEast)
        self.directions.append(Direction.SouthEast)
        self.directions.append(Direction.SouthWest)
        self.directions.append(Direction.NorthWest)
    }
    
    var rect : RectInt
    var destination : PointInt
    var closedNodes : [AStarNode]
    var openedNodes : [AStarNode]
    var directions : [Direction]
}
