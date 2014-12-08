//
//  RouteManager.swift
//  TheOne
//
//  Created by Howard on 12/4/14.
//  Copyright (c) 2014 Howard. All rights reserved.
//

import Foundation
import SpriteKit

public class RouteManager {
    public init(column : Int, row : Int) {
        var matrix = [[Bool]]()
        
        for var r : Int = 0; r <= row; r++ {
            var oneRow = [Bool]()
            for var c : Int = 0; c <= column; c++ {
                oneRow.append(false)
            }
            
            matrix.append(oneRow)
        }
        
        self.matrix = matrix
        self.costCalc = SimpleCostCalc()
    }
    
    public required init (matrix : [[Bool]]) {
        self.matrix = matrix
        self.costCalc = SimpleCostCalc()
    }
    
    public var matrix : [[Bool]]
    public var costCalc : CostCalcProtocal!;
    
    public func route(start : PointInt, destination : PointInt) -> [PointInt]? {
        let map = RectInt(x: 0, y: 0, width: matrix[0].count, height: matrix.count)
        if(!map.contains(start) || !map.contains(destination)) {
            return nil
        }
        
        let routeData = RouteData(rect: map, destination: destination)
        let startNode = AStarNode(location: start, previousNode: nil, costG: 0, costH: 0)
        routeData.openedNodes.append(startNode)
        
        var currentNode = startNode
        return routeCore(routeData, currentNode: currentNode)
    }
    
    func routeCore (routeData : RouteData, currentNode : AStarNode) -> [PointInt]? {
        
        let start = NSDate()
        for direction in routeData.directions {
            let nextLocation = currentNode.location.getAdjecentPoint(direction)
            
            if !routeData.rect.contains(nextLocation) {
                continue
            }
            
            if matrix[nextLocation.y][nextLocation.x] {
                continue
            }
            
            let costG = costCalc.getCostG(currentNode, direction: direction)
            let costH = costCalc.getCostH(nextLocation, destination: routeData.destination)
            
            if costH == 0 {
                var result = [PointInt]()
                result.append(routeData.destination)
                result.insert(currentNode.location, atIndex: 0)
                
                var tempNode = currentNode
                while (tempNode.previousNode != nil) {
                    result.insert(tempNode.previousNode!.location, atIndex: 0)
                    tempNode = tempNode.previousNode!
                }
                return result
            }
            
            let existingNode = getNodeOnLocation(nextLocation, routeData: routeData)
            if((existingNode?) != nil) {
                if(existingNode!.costG > costG) {
                    existingNode!.previousNode = currentNode
                    existingNode!.costG = costG
                }
            }
            else {
                let newNode = AStarNode(location: nextLocation, previousNode: currentNode, costG: costG, costH: costH)
                routeData.openedNodes.append(newNode)
            }
        }
        
        
        let currentNodeIndex = indexAt(routeData.openedNodes, item: currentNode)
        routeData.openedNodes.removeAtIndex(currentNodeIndex)
        routeData.closedNodes.append(currentNode)
        
        println(routeData.openedNodes.count)
        let minimumCostNode = getMinimumCostNode(routeData)
        if minimumCostNode == nil {
            return nil   
        }
        return routeCore(routeData, currentNode: minimumCostNode!)
    }
    
    func getMinimumCostNode(routeData : RouteData) -> AStarNode? {
        var node : AStarNode? = nil
        if(routeData.openedNodes.count != 0) {
            for n in routeData.openedNodes {
                if node == nil {
                    node = n
                }
                else if node?.costF > n.costF {
                    node = n
                }
            }
        }
        
        return node
    }
    
    func getNodeOnLocation (location:PointInt, routeData : RouteData) -> AStarNode? {
        for node in routeData.openedNodes {
            if node.location.x == location.x && node.location.y == location.y {
                return node;
            }
        }
        
        for node in routeData.closedNodes {
            if node.location.x == location.x && node.location.y == location.y {
                return node
            }
        }
        
        return nil
    }
    
    func indexAt (items : [AStarNode], item : AStarNode) -> Int {
        var result = -1
        for var index = 0; index < items.count; index++ {
            if items[index] === item {
                result = index
                break
            }
        }
        
        return result
    }
}
