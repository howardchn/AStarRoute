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
    init (rect : CGRect, destination : CGPoint) {
        self.rect = rect
        self.destination = destination
        self.openedNodes = [AStarNode]()
        self.closedNodes = [AStarNode]()
    }
    
    var rect : CGRect
    var destination : CGPoint
    var closedNodes : [AStarNode]
    var openedNodes : [AStarNode]
}
