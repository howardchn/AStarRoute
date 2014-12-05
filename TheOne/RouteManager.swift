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
    public init(column : Int32, row : Int32) {
        var matrix = [[Bool]]()
        
        for var r : Int32 = 0; r < row; r++ {
            var oneRow = [Bool]()
            for var c : Int32 = 0; c < column; c++ {
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
    
    public func route(start : CGPoint, destination : CGPoint) -> [CGPoint]? {
        let map = CGRect(x: 0, y: 0, width: matrix[0].count, height: matrix.count)
        if(!map.contains(start) || !map.contains(destination)) {
            return nil
        }
        
        let routeData = RouteData(rect: map, destination: destination)
        let startNode = AStarNode(location: start, previousNode: nil, costG: 0, costH: 0)
        routeData.openedNodes.append(startNode)
        
        var currentNode = startNode
        return routeCore(routeData, currentNode: currentNode)
    }
    
    func routeCore (routeData : RouteData, currentNode : AStarNode) -> [CGPoint]? {
        for rawValue in 1...8 {
            let direction = Direction(rawValue: rawValue)
            let nextLocation = currentNode.location.getAdjecentPoint(direction!)
            
            if !routeData.rect.contains(nextLocation) {
                continue
            }
            
            if matrix[Int(nextLocation.y)][Int(nextLocation.x)] {
                continue
            }
            
            let costG = costCalc.getCostG(currentNode, direction: direction!)
            let costH = costCalc.getCostH(nextLocation, destination: routeData.destination)
            
            if costH == 0 {
                var result = [CGPoint]()
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
        return nil
    }
    
    func getNodeOnLocation (location:CGPoint, routeData : RouteData) -> AStarNode? {
        for node in routeData.openedNodes {
            if node.location == location {
                return node;
            }
        }
        
        for node in routeData.closedNodes {
            if node.location == location {
                return node
            }
        }
        
        return nil
    }
    
    func indexAt (items : [Any], item : Any) -> Int {
        var result = -1
        
        for var index = 0; index < 3; index++ {
//            if items[i] == item {
//                result = i
//            }
        }
        
        return result
    }
    
    
}
